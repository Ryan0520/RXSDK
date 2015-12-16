//
//  EPOAuthManager.m
//  EPIMApp
//
//  Created by Ryan on 15/12/15.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "EPOAuthManager.h"
#import "RXApiEngine.h"

@implementation EPOAuthManager

/**
 *  第三方登陆
 *
 *  @param platformType 第三方平台
 *  @param openID       第三方平台openID
 */
+ (void)loginWithPlatformType:(EPPlatformType)platformType
               platformOpenID:(NSString *)openID
               successHandler:(SuccessCodeBlcok)codeBlock
               failureHandler:(FailureHandler)failureHandler
{
    NSString *platform = [[[self alloc] init] platformStringFromType:platformType];
    
    NSDictionary *params = @{
                             @"platform":platform,
                             @"open_id":openID
                             };
    void (^successBlock)(NSDictionary *) = ^(NSDictionary *jsonData)
    {
        codeBlock(jsonData[@"authCode"]);
    };
    
    [[RXApiEngine sharedInstance] requestService:@"user.socialLogin"
                                      parameters:params
                                       onSuccess:successBlock
                                       onFailure:failureHandler];
    
}

/**
 *  绑定第三方账号
 *
 *  @param platformType   第三方平台类型
 *  @param openID         第三方平台openID
 *  @param phone          手机号码
 *  @param nickname       第三方平台昵称
 *  @param avater         头像
 *  @param validateCode   手机验证码
 *  @param validateTicket 手机验证码授权票
 *  @param codeBlock      返回授权code
 *  @param failureHandler 失败回调
 */
+ (void)bindWithPlatformType:(EPPlatformType)platformType
               platformOpenID:(NSString *)openID
                        phone:(NSString *)phone
                     nickname:(NSString *)nickname
                       avatar:(NSString *)avater
                 validateCode:(NSString *)validateCode
               validateTicket:(NSString *)validateTicket
               successHandler:(SuccessCodeBlcok)codeBlock
               failureHandler:(FailureHandler)failureHandler
{
    NSString *platform = [[[self alloc] init] platformStringFromType:platformType];
    
    NSDictionary *params = @{
                             @"platform"       :platform,
                             @"open_id"        :openID,
                             @"phone"          :phone,
                             @"nickname"       :nickname,
                             @"avatar"         :avater,
                             @"validate_code"  :validateCode,
                             @"validate_ticket":validateTicket
                             };
    void (^successBlock)(NSDictionary *) = ^(NSDictionary *jsonData)
    {
        codeBlock(jsonData[@"authCode"]);
    };
    
    [[RXApiEngine sharedInstance] requestService:@"user.bind"
                                      parameters:params
                                       onSuccess:successBlock
                                       onFailure:failureHandler];
    
}

/**
 *  获取手机验证码和获取授权ticket票
 *
 *  @param phone          手机号
 *  @param codeBlock      返回授权票ticket
 *  @param failureHandler 失败回调
 */
+ (void)fetchValidateCodeWithPhone:(NSString *)phone
                    successHandler:(SuccessCodeBlcok)codeBlock
                    failureHandler:(FailureHandler)failureHandler
{
    NSDictionary *params = @{@"phone":phone};
    
    void (^successBlock)(NSDictionary *) = ^(NSDictionary *jsonData)
    {
        codeBlock(jsonData[@"validate_ticket"]);
    };
    
    [[RXApiEngine sharedInstance] requestService:@"user.fetchValidateCode"
                                      parameters:params
                                       onSuccess:successBlock
                                       onFailure:failureHandler];
}

/**
 *  手机号登陆
 *
 *  @param phone          手机号码
 *  @param validateCode   手机验证码
 *  @param validateTicket 手机验证码授权票
 */
+ (void)loginWithPhone:(NSString *)phone
          validateCode:(NSString *)validateCode
        validateTicket:(NSString *)validateTicket
        successHandler:(SuccessCodeBlcok)codeBlock
        failureHandler:(FailureHandler)failureHandler
{
    NSDictionary *params = @{@"phone"           : phone ,
                             @"validate_code"   : validateCode,
                             @"validate_ticket" : validateTicket
                             };
    
    void (^successBlock)(NSDictionary *) = ^(NSDictionary *jsonData)
    {
        codeBlock(jsonData[@"authCode"]);
    };
    
    [[RXApiEngine sharedInstance] requestService:@"user.login"
                                      parameters:params
                                       onSuccess:successBlock
                                       onFailure:failureHandler];

}


/**
 *  手机号绑定
 *
 *  @param phone          手机号码
 *  @param username       用户名
 *  @param codeBlock      返回授权code
 *  @param failureHandler 失败回调
 */
+ (void)bindWithPhone:(NSString *)phone
             username:(NSString *)username
       successHandler:(SuccessCodeBlcok)codeBlock
       failureHandler:(FailureHandler)failureHandler
{
    NSDictionary *params = @{
                             @"phone"      : phone ,
                             @"username"   : username
                             };
    
    void (^successBlock)(NSDictionary *) = ^(NSDictionary *jsonData)
    {
        codeBlock(jsonData[@"authCode"]);
    };
    
    [[RXApiEngine sharedInstance] requestService:@"user.loginBind"
                                      parameters:params
                                       onSuccess:successBlock
                                       onFailure:failureHandler];
}

/**
 *  获取访问令牌 access_token
 *
 *  @param authCode       授权码code
 *  @param scope          授权权限范围
 *  @param codeBlock      返回access_token
 *  @param failureHandler 失败回调
 */
+ (void)getAccessTokenWithAuthCode:(NSString *)authCode
                             scope:(NSString *)scope
                    successHandler:(SuccessCodeBlcok)codeBlock
                    failureHandler:(FailureHandler)failureHandler
{
    NSDictionary *params = @{
                             @"code"     : authCode ,
                             @"scope"    : scope
                             };
    
    void (^successBlock)(NSDictionary *) = ^(NSDictionary *jsonData)
    {
        codeBlock(jsonData[@"token"]);
    };
    
    [[RXApiEngine sharedInstance] requestService:@"user.fetchAccessToken"
                                      parameters:params
                                       onSuccess:successBlock
                                       onFailure:failureHandler];
}

#pragma mark - private method
- (NSString *)platformStringFromType:(EPPlatformType)type
{
    switch (type) {
        case EPPlatformTypeQQ:
            return @"QQ";
            break;
        case EPPlatformTypeWechat:
            return @"Wechat";
            break;
        case EPPlatformTypeWeibo:
            return @"Weibo";
            break;
        default:
            return @"";
            break;
    }
}
@end
