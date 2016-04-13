//
//  EPOAuthManager.h
//  EPIMApp
//
//  Created by Ryan on 15/12/15.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

// 第三方平台
typedef NS_ENUM(NSInteger, EPPlatformType) {
    /** 微博平台 */
    EPPlatformTypeWeibo = 0,
    /** QQ平台 */
    EPPlatformTypeQQ = 1,
    /** 微信平台 */
    EPPlatformTypeWechat = 2
};
// 失败的处理
typedef void(^FailureHandler)(NSError *);
typedef void(^SuccessCodeBlcok)(NSString *);

@interface EPOAuthManager : NSObject
/**
 *  第三方登陆
 *
 *  @param platformType 第三方平台
 *  @param openID       第三方平台openID
 *  @param codeBlock      返回授权票ticket
 *  @param failureHandler 失败回调
 */
+ (void)loginWithPlatformType:(EPPlatformType)platformType
               platformOpenID:(NSString *)openID
               successHandler:(SuccessCodeBlcok)codeBlock
               failureHandler:(FailureHandler)failureHandler;

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
               failureHandler:(FailureHandler)failureHandler;


/**
 *  发送手机验证码获取授权ticket票
 *
 *  @param phone          手机号
 *  @param codeBlock      返回授权票ticket
 *  @param failureHandler 失败回调
 */
+ (void)fetchValidateCodeWithPhone:(NSString *)phone
                    successHandler:(SuccessCodeBlcok)codeBlock
                    failureHandler:(FailureHandler)failureHandler;

/**
 *  手机号登陆
 *
 *  @param phone          手机号码
 *  @param validateCode   手机验证码
 *  @param validateTicket 手机验证码授权票
 *  @param codeBlock      返回授权票ticket
 *  @param failureHandler 失败回调
 */
+ (void)loginWithPhone:(NSString *)phone
          validateCode:(NSString *)validateCode
        validateTicket:(NSString *)validateTicket
        successHandler:(SuccessCodeBlcok)codeBlock
        failureHandler:(FailureHandler)failureHandler;

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
       failureHandler:(FailureHandler)failureHandler;

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
                    failureHandler:(FailureHandler)failureHandler;


+ (void)getUserInfoWithUserId:(NSString *)userId
					   source:(NSString *)source
					  success:(void (^)())successHandler
					  failure:(FailureHandler)failureHandler;

@end
