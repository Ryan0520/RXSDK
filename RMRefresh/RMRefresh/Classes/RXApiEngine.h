//
//  RXApiEngine.h
//  RMRefresh
//
//  Created by Ryan on 15/12/15.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import "RXApiServiceEngine.h"

/** Oauth Api URL*/
extern NSString *const EPOAuthApiBaseUrl;
/** Open Api URL*/
extern NSString *const EPOpenApiBaseUrl;

/** Api Secret key */
extern NSString *const EPApiSecretKey;
/** Api Access Token */
extern NSString *const EPApiAccessToken;

@interface RXApiEngine : RXApiServiceEngine

singleton_interface(RXApiEngine)

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
					onFailure:(FailureHandler)failureHandler;
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
				  onFailure:(FailureHandler)failureHandler;

@end
