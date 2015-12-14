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
#define CONVERTER(obj) [obj isEqual:[NSNull null]] ? nil: obj

// api error domain
NSString *const RXApiServiceErrorDomain = @"Api.Service.ErrorDomain";

// api error message key
NSString *const RXApiServiceErrorMessage = @"Api.Service.ErrorMessage";

static NSTimeInterval const timeoutInterval = 45.0f;

@interface RXApiServiceEngine()

@property (nonatomic, strong) AFURLSessionManager *sessionManager;

@property (nonatomic, strong) NSMutableURLRequest *requset;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, copy) NSString *baseUrl;

@property (nonatomic, copy) NSString *secretKey;

@property (nonatomic, copy) NSString *appId;

@property (nonatomic, copy) NSString *appSecretKey;

@property (nonatomic, copy) NSString *sign;

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
            [manager GET:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
            [manager POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

/**
 *   发送一个拼接httpbody类型的POST请求
 *
 *  @param servies        服务名
 *  @param parameters     参数
 *  @param successHandler 成功回调
 *  @param failureHanler  失败回调
 */
- (void)requestService:(NSString *)servies
            parameters:(NSDictionary *)parameters
             onSuccess:(SuccessHandler)successHandler
             onFailure:(FailureHandler)failureHanler
{
    _sign = [self signWithParmas:parameters];
    
    RXApiServiceRequest *serviceRequest = [self generateServiceRequestWithServiceName:servies
                                                                           parameters:parameters];
    
    [self.requset setHTTPBody:[self encodeRequest:serviceRequest]];
    
    NSURLSessionDataTask *dataTask = [_sessionManager dataTaskWithRequest:self.requset completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
    {
          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
          // 请求成功,有数据回来
          if (httpResponse.statusCode == 200) {
              RXApiServiceResponse *response = [self decodeResponse:responseObject];
              if (response.code == RXApiServiceResponseStatusSuccess) {
                  if (successHandler) {
                      NSLog(@"response.data = \n%@",[self dictionaryToJson:response.data]);
                      successHandler(response.data);
                  }
              }else{
                  NSDictionary *userInfo = @{RXApiServiceErrorMessage : response.message};
                  NSError *error = [NSError errorWithDomain:RXApiServiceErrorDomain
                                                       code:response.code
                                                   userInfo:userInfo];
                  if (failureHanler) {
                      failureHanler(error);
                  }
              }
          }
          // 请求失败
          if (error) {
              if (failureHanler) {
                  failureHanler(error);
              }
              NSLog(@"%@",error);
          }
    }];
    
    [dataTask resume];
    self.dataTask = dataTask;
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
    return request;
}

// 编码请求
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
                                 @"params" : params
                                 };
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
    if (_secretKey != nil)
    {
        data = [data sdk_AESEncryptWithKey:_secretKey];
    }
    
    return data;
}


// 解码应答
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
    
    RXApiServiceResponse *response = [[RXApiServiceResponse alloc] init];
    response.code = (RXApiServiceResponseStatus)[json[@"code"] intValue];
    response.message = json[@"message"];
    response.data = json[@"data"];
    
    return response;
}

- (NSMutableURLRequest *)requset
{
    if (!_requset) {
        _baseUrl = [_baseUrl stringByAppendingFormat:@"sign=%@&app_id=%@",_sign,_appId];
        
        NSURL *baseURL = [NSURL URLWithString:_baseUrl];
        
        _requset = [NSMutableURLRequest requestWithURL:baseURL
                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                       timeoutInterval:timeoutInterval];
        _requset.HTTPMethod = @"POST";
    }
    return _requset;
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
    // 因为NSDictionary排序
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
    NSString *tmp = [self sortStringWithParamsDictionary:parmas];
    tmp = [self md5:tmp];
    tmp = [tmp stringByAppendingString:_appSecretKey];
    return [self md5:tmp];
}
#pragma mark MD5加密
- (NSString *)md5:(NSString *)string
{
    const char* cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", result[i]];
    }
    return ret;
}
#pragma mark - 取消所有任务
- (void)cancelAllTask
{
    [self.dataTask cancel];
}
@end
