//
//  RXApiServiceEngine.m
//  RMRefresh
//
//  Created by Ryan on 15/11/24.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import "RXApiServiceEngine.h"
#import "AFNetworking.h"
#import "RXApiServiceRequest.h"
#import "RXApiServiceResponse.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "NSData+SDK_Encrypt.h"
#import "RXRuntime.h"
#import <CommonCrypto/CommonDigest.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "RXMarco.h"

// api error domain
NSString *const RXApiServiceErrorDomain = @"Api.Service.ErrorDomain";

// api error message key
NSString *const RXApiServiceErrorMessage = @"Api.Service.ErrorMessage";


@interface RXApiServiceEngine()

@property (nonatomic, strong) AFURLSessionManager *sessionManager;

@property (nonatomic, strong) NSMutableURLRequest *requset;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, copy) NSString *requestUrl;

@property (nonatomic, copy) NSString *secretKey;
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appSecretKey;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, assign) BOOL debugLog;
@property (nonatomic, assign) NSTimeInterval timeout;
@end

@implementation RXApiServiceEngine
singleton_implementation(RXApiServiceEngine)
/**
 *  初始化
 *
 *  @param baseUrl   URL
 *  @param secretKey 秘钥
 */
- (instancetype)initWithBaseUrl:(NSString *)baseUrl
						  appId:(NSString *)appId
					  secretKey:(NSString *)secretKey
				   appSecretKey:(NSString *)appSecretKey
					accessToken:(NSString *)accessToken
					   debugLog:(BOOL)debugLog
						timeout:(NSTimeInterval)timeout;
{
	self = [super init];
	if (self)
	{
		NSURLSessionConfiguration *configuration =
		[NSURLSessionConfiguration defaultSessionConfiguration];
		_sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
		[AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
		AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
		[_sessionManager setResponseSerializer:responseSerializer];
		
		_baseUrl = baseUrl;
		_appId = appId;
		_secretKey = secretKey;
		_appSecretKey = appSecretKey;
		_accessToken = accessToken;
		_debugLog = debugLog;
		_timeout = timeout;
	}
	return self;
}

/**
 *  发送一个请求
 *
 *  @param type    请求类型,POST or GET
 *  @param url     路径
 *  @param params  参数
 *  @param handler 完成的处理
 */
+ (void)requestWithType:(RequestMethodType)type
					url:(NSString *)url
			 parameters:(NSDictionary *)parameters
	  completionHanlder:(CompletionHandler)competionHandler
{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
	responseSerializer.removesKeysWithNullValues = YES;
	manager.responseSerializer = responseSerializer;
	NSLog(@"parameters:\n %@",parameters);
	__weak typeof(self) weakSelf = self;
	
	switch (type) {
		case RequestMethodTypeGet:
		{
			[manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
				NSLog(@"response.content = \n%@",[[[self alloc] init] dictionaryToJson:responseObject]);
				if (competionHandler) {
					competionHandler(responseObject,nil);
				}
				
			} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
				if (error.code == -1005) {
					[weakSelf requestWithType:type
										  url:url
								   parameters:parameters
							completionHanlder:competionHandler];
				}else if (error.code == -1001){
					NSLog(@"网络请求超时%@",error);
				}else{
					if (competionHandler) {
						competionHandler(nil,error);
					}
				}
			}];
		}
			break;
			
		case RequestMethodTypePost:
		{
			[manager POST:url parameters:parameters progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
				NSLog(@"response.content = \n%@",[[[self alloc] init] dictionaryToJson:responseObject]);
				if (competionHandler) {
					competionHandler(responseObject,nil);
				}
				
			} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
				if (error.code == -1005) {
					[weakSelf requestWithType:type
										  url:url
								   parameters:parameters
							completionHanlder:competionHandler];
				}else if (error.code == -1001){
					NSLog(@"网络请求超时%@",error);
				}else{
					if (competionHandler) {
						competionHandler(nil,error);
					}
				}
			}];
		}
			break;
		default:
			break;
	}
}

#pragma mark - 请求的方法
- (void)requestService:(NSString *)servies
			parameters:(NSDictionary *)parameters
			 onSuccess:(SuccessHandler)successHandler
			 onFailure:(FailureHandler)failureHanler
{
	[self processRequestParmasWithParams:parameters servies:servies];
	
	NSURLSessionDataTask *dataTask = [_sessionManager dataTaskWithRequest:_requset completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
									  {
										  // 请求失败,-999是取消请求错误
										  if (error && error.code != -999) {
											  if (_debugLog) {
												  NSLog(@"非服务端返回的错误信息---%@---",error);
											  }
											  NSString *errorDescription = error.userInfo[@"NSLocalizedDescription"];
											  [SVProgressHUD showErrorWithStatus:errorDescription];
											  if (failureHanler) {
												  failureHanler(error);
											  }
											  return ;
										  }
										  
										  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
										  if (httpResponse == nil) {
											  if (failureHanler) {
												  failureHanler(error);
											  }
											  return ;
										  }
										  
										  // 请求成功,有服务端返回的数据回来
										  if (httpResponse.statusCode == 200) {
											  RXApiServiceResponse *response = [self decodeResponse:responseObject];
											  if (response.code == RX_Response_SUCCESS) {
												  if (successHandler) {
													  if (_debugLog) {
														  NSLog(@"请求成功的数据\n 服务名 = %@ \n 数据内容 = %@ \n",
																servies,[self dictionaryToJson:response.data]);
													  }
													  successHandler(response.data);
												  }
											  } else {
												  if (response != nil) {
													  NSDictionary *userInfo = @{RXApiServiceErrorMessage : response.message};
													  NSError *error = [NSError errorWithDomain:RXApiServiceErrorDomain
																						   code:response.code
																					   userInfo:userInfo];
													  BOOL showErrorHUD = YES;
													  // 遍历需要忽略的错误码，不提示错误
													  for (NSNumber *nuber in self.igonreCode) {
														  if ([nuber integerValue] == error.code) {
															  showErrorHUD = NO;
															  break;
														  }
													  }
													  
													  if (showErrorHUD) {
														  if (!response.message.length)  response.message = @"未知错误";
														  
														  [SVProgressHUD showErrorWithStatus:response.message];
													  }
													  
													  if (_debugLog) {
														  NSLog(@"服务端返回的错误信息---%@---",error.description);
													  }
													  
													  if (failureHanler) {
														  failureHanler(error);
													  }
												  } else {
													  [SVProgressHUD showErrorWithStatus:@"后台返回数据错误!!"];
													  if (failureHanler) {
														  failureHanler(nil);
													  }
												  }
											  }
										  }
									  }];
	
	[dataTask resume];
	self.dataTask = dataTask;
}
#pragma mark - 加工请求参数
- (void)processRequestParmasWithParams:(NSDictionary *)parameters servies:(NSString *)servies
{
	_sign = [self signWithParmas:parameters];
	
	_requestUrl = [self getRequestUrl];
	
	NSURL *baseURL = [NSURL URLWithString:_requestUrl];
	
	NSTimeInterval timeInterval = 15.0f;
	if (_timeout) {
		timeInterval = _timeout;
	}
	
	_requset = [NSMutableURLRequest requestWithURL:baseURL
									   cachePolicy:NSURLRequestUseProtocolCachePolicy
								   timeoutInterval:timeInterval];
	_requset.HTTPMethod = @"POST";
	
	RXApiServiceRequest *serviceRequest = [self generateServiceRequestWithServiceName:servies
																		   parameters:parameters];
	
	[_requset setHTTPBody:[self encodeRequest:serviceRequest]];
}
#pragma mark - 获取请求url
- (NSString *)getRequestUrl
{
	NSString *appendingString = [NSString stringWithFormat:@"sign=%@&app_id=%@",_sign,_appId];
	
	_requestUrl = [_baseUrl stringByAppendingString:appendingString];
	
	if (_debugLog) {
		NSLog(@"\n签名sign = %@ \n请求url = %@",_sign,_requestUrl);
	}
	
	return _requestUrl;
}

- (RXApiServiceRequest *)generateServiceRequestWithServiceName:(NSString *)serviceName
													parameters:(NSDictionary *)parameters
{
	RXApiServiceRequest *request = [[RXApiServiceRequest alloc] init];
	RXRuntime *runtime = [RXRuntime sharedInstance];
	request.service = serviceName;
	request.os = runtime.os;
	request.osVersion = runtime.osVersion;
	request.appName = runtime.appName;
	request.appVersion = runtime.appVersion;
	request.udid = runtime.udid;
	request.params = parameters;
	if (_accessToken == nil) _accessToken = @"";
	request.accessToken = _accessToken;
	if (_debugLog) {
		NSLog(@"%@",request.description);
	}
	return request;
}

#pragma mark - 编码请求
- (NSData *)encodeRequest:(RXApiServiceRequest *)request
{
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	
	for (NSString *key in request.params.allKeys)
	{
		id value = request.params[key];
		if ([value isKindOfClass:[NSData class]])
		{
			NSData *data = value;
			params[key] = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
		}
		else
		{
			params[key] = value;
		}
	}
	
	NSDictionary *jsonObject = @{
								 @"service" : request.service,
								 @"os" : request.os,
								 @"os_version" : request.osVersion,
								 @"app_name" : request.appName,
								 @"app_version" : request.appVersion,
								 @"udid" : request.udid,
								 @"access_token": request.accessToken,
								 @"params" : params
								 };
	NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
	if (_secretKey != nil)
	{
		data = [data sdk_AESEncryptWithKey:_secretKey];
	}
	
	return data;
}

#pragma mark - 解码应答
- (RXApiServiceResponse *)decodeResponse:(NSData *)responseData
{
	NSData *data = responseData;
	
	if (_secretKey != nil)
	{
		data = [responseData sdk_AESDecryptWithKey:_secretKey];
	}
	
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
														 options:NSJSONReadingMutableContainers
														   error:nil];
	
	return [RXApiServiceResponse responseWithJson:json];
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic
{
	if (!dic || ![dic isKindOfClass:[NSDictionary class]]) return nil;
	
	NSError *parseError = nil;
	
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
													   options:NSJSONWritingPrettyPrinted
														 error:&parseError];
	return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
#pragma mark - private method
#pragma mark 字典排序返回拼接好的字符串
- (NSString *)sortStringWithParamsDictionary:(NSDictionary *)parmasDictionary
{
	// NSDictionary排序
	NSArray *keys = [parmasDictionary allKeys];
	NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
		return [obj1 compare:obj2 options:NSNumericSearch];
	}];
	__block NSString *tmpString = @"";
	[sortedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		tmpString = [tmpString stringByAppendingFormat:@"%@",obj];
		tmpString = [tmpString stringByAppendingFormat:@"%@",[parmasDictionary objectForKey:obj]];
	}];
	return tmpString;
}
#pragma mark 参数加密
- (NSString *)signWithParmas:(NSDictionary *)parmas
{
	NSString *tmp = @"";
	if (parmas) {
		tmp = [self sortStringWithParamsDictionary:parmas];
		tmp = [self md5:tmp];
	}
	if (_accessToken.length > 0){
		tmp = [self md5:[tmp stringByAppendingString:_accessToken]];
	}
	tmp = [tmp stringByAppendingString:_appSecretKey];
	return [self md5:tmp];
}
#pragma mark MD5加密
- (NSString *)md5:(NSString *)string
{
	if (string.length>0) {
		const char* cStr = [string UTF8String];
		unsigned char result[CC_MD5_DIGEST_LENGTH];
		CC_MD5(cStr, (unsigned int)strlen(cStr), result);
		
		NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
		for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
			[ret appendFormat:@"%02x", result[i]];
		}
		return ret;
	}
	return @"";
}
#pragma mark - 取消所有任务
- (void)cancelAllTask
{
	[self.dataTask cancel];
}
@end
