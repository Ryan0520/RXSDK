//
//  RXStatusDefine.h
//  RMRefresh
//
//  Created by Ryan on 15/12/15.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#ifndef RXStatusDefine_h
#define RXStatusDefine_h

/**
 *  @enum 融云连接业务的返回码。
 */
typedef NS_ENUM(NSInteger, RXApiServiceResponseStatus) {
    /**
     *  响应成功
     */
    RX_Response_SUCCESS = 200 ,
    /**
     *  找不到相应的api文件
     */
    RX_Response_FILE_NOT_FOUND = 1001,
    /**
     *  找不到相应的类
     */
    RX_Response_CLASS_NOT_FOUND = 1002,
    /**
     *  参数验证失败
     */
    RX_Response_PARAMS_VALIDATE_FALURE = 1003,
    /**
     *  手机号为空
     */
    RX_Response_PHONE_IS_NULL = 1004,
    /**
     *  验证码为空
     */
    RX_Response_VALIDATE_CODE_IS_NULL = 1005,
    /**
     *  验证码错误
     */
    RX_Response_CODE_VALIDATE_FALURE = 1006,
    /**
     *  第三方账户不存在
     */
    RX_Response_SOCIAL_ACCOUNT_NOT_FOUND = 1007,
    /**
     *  数据错误
     */
    RX_Response_DATA_ERROR = 1008,
    /**
     *  第三方平台不为空
     */
    RX_Response_PLATFORM_IS_NULL = 4021,
    /**
     *  第三方openid不为空
     */
    RX_Response_OPENID_IS_NULL = 4022,
    /**
     *  有效验证码票证不能为空
     */
    RX_Response_VALIDATE_TICKET_IS_NULL = 4023,
    /**
     *  第三方账号已绑定
     */
    RX_Response_SOCIAL_ACCOUNT_BINDING = 4025,
    /**
     *  appId 不能为空
     */
    RX_Response_APP_ID_IS_NULL = 4026,
    /**
     *  authCode不能为空
     */
    RX_Response_AUTHCODE_IS_NULL = 4027,
    /**
     *  authcode已过期
     */
    RX_Response_AUTHCODE_EXPIRED = 4028,
    /**
     *  token 不能为空
     */
    RX_Response_ACCESSTOKEN_IS_NULL = 4029,
    /**
     *  token 已过期
     */
    RX_Response_ACCESSTOKEN_EXPIRED = 4030,
    /**
     *  获取scope_list失败
     */
    RX_Response_SCOPELIST_FAIL = 4031,
    /**
     *  获取应用失败
     */
    RX_Response_APPLICATION_FAIL = 4032,
    /**
     *  验证标签失败
     */
    RX_Response_SIGN_FAIL = 4033,
    /**
     *  验证service_name为空或者不存在
     */
    RX_Response_SERVICE_VALIDATE_FAIL = 4034,
    /**
     *  scope不能为空
     */
    RX_Response_SCOPE_IS_NULL = 4035,
    /**
     *  error
     */
    RX_Response_ILLEGAL_ERROR = 403,
};


#endif /* RXStatusDefine_h */
