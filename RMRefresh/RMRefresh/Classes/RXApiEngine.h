//
//  RXApiEngine.h
//  RMRefresh
//
//  Created by Ryan on 15/12/15.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import "RXApiServiceEngine.h"

@interface RXApiEngine : RXApiServiceEngine

singleton_interface(RXApiEngine)

/**
 *  请求openApi服务器
 *
 *  @param servies        服务名
 *  @param parameters     参数
 *  @param successHandler 成功回调
 *  @param failureHanler  失败回调
 */
- (void)requestOpenApiService:(NSString *)servies
                   parameters:(NSDictionary *)parameters
                    onSuccess:(SuccessHandler)successHandler
                    onFailure:(FailureHandler)failureHanler;
/**
 *  请求OauthApi服务器
 *
 *  @param servies        服务名
 *  @param parameters     参数
 *  @param successHandler 成功回调
 *  @param failureHanler  失败回调
 */
- (void)requestOauthService:(NSString *)servies
                 parameters:(NSDictionary *)parameters
                  onSuccess:(SuccessHandler)successHandler
                  onFailure:(FailureHandler)failureHanler;

@end
