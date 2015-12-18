//
//  RXApiEngine.m
//  RMRefresh
//
//  Created by Ryan on 15/12/15.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import "RXApiEngine.h"
@implementation RXApiEngine
singleton_implementation(RXApiEngine)
- (instancetype)init
{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSString *url = @"";
    
    if (accessToken.length>0) {
        url = @"http://120.24.88.40:8888/open_api/api?";
    }else{
        url = @"http://120.24.88.40:8888/oauth2/api?";
    }
    
//    url = @"http://120.24.88.40:8888/oauth2/api?";
    
    self = [super initWithBaseUrl:url
                            appId:@"123"
                        secretKey:nil
                     appSecretKey:@"123"
                      accessToken:accessToken];
    
    return self;
}

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
                    onFailure:(FailureHandler)failureHanler
{
    self.baseUrl = @"http://120.24.88.40:8888/open_api/api?";
    self.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"EPApiAccessToken"];
    
    [self requestService:servies
              parameters:parameters
               onSuccess:successHandler
               onFailure:failureHanler];
}

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
                  onFailure:(FailureHandler)failureHanler
{
    self.baseUrl  = @"http://120.24.88.40:8888/oauth2/api?";
    
    [self requestService:servies
              parameters:parameters
               onSuccess:successHandler
               onFailure:failureHanler];
}

@end
