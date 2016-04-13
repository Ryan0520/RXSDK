//
//  RXApiEngine.m
//  RMRefresh
//
//  Created by Ryan on 15/12/15.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import "RXApiEngine.h"

//NSString *const EPOAuthApiBaseUrl = @"http://124.172.184.215:8081/oauth2/api?";

NSString *const EPOAuthApiBaseUrl = @"http://192.168.172.109:8080/monitor/api?";
NSString *const EPOpenApiBaseUrl =  @"http://124.172.184.216:8080/open_api/api?";

NSString *const EPApiSecretKey = nil;
NSString *const EPApiAccessToken = @"ApiAccessToken";

NSString *const EPAppId = @"123";
NSString *const EPAppSecretKey = @"123";

@implementation RXApiEngine
singleton_implementation(RXApiEngine)

- (instancetype)init
{
	NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
	NSString *url = @"";
	
	if (accessToken.length>0) {
		url = EPOpenApiBaseUrl;
	}else{
		url = EPOAuthApiBaseUrl;
	}
	
	self = [super initWithBaseUrl:url
							appId:EPAppId
						secretKey:EPApiSecretKey
					 appSecretKey:EPAppSecretKey
					  accessToken:accessToken
						 debugLog:YES
						  timeout:15.0f];
	
	return self;
}

/**
 *  请求openApi服务器
 *
 *  @param service        服务名
 *  @param parameters     参数
 *  @param successHandler 成功回调
 *  @param failureHandler  失败回调
 */
- (void)requestOpenApiService:(NSString *)service
				   parameters:(NSDictionary *)parameters
					onSuccess:(SuccessHandler)successHandler
					onFailure:(FailureHandler)failureHandler
{
	self.baseUrl = EPOpenApiBaseUrl;
//	self.accessToken = [GVUserDefaults standardUserDefaults].accessToken;
	
	// 监听AccessToken过期的通知
	void (^failureBlock)(NSError *) = ^(NSError *error)
	{
		if (failureHandler) {
			failureHandler(error);
		}
	};
	
	[self requestService:service
			  parameters:parameters
			   onSuccess:successHandler
			   onFailure:failureBlock];
}

/**
 *  请求OauthApi服务器
 *
 *  @param service        服务名
 *  @param parameters     参数
 *  @param successHandler 成功回调
 *  @param failureHandler  失败回调
 */
- (void)requestOauthService:(NSString *)service
				 parameters:(NSDictionary *)parameters
				  onSuccess:(SuccessHandler)successHandler
				  onFailure:(FailureHandler)failureHandler
{
	self.baseUrl  = EPOAuthApiBaseUrl;
	
	[self requestService:service
			  parameters:parameters
			   onSuccess:successHandler
			   onFailure:failureHandler];
}


@end
