//
//  RXApiEngine.h
//  RXSDK
//
//  Created by Ryan on 15/11/17.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2
};

typedef void(^CompletionHandler)(id jsonData,NSError *error);

@interface RXApiEngine : NSObject

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
      completionHanlder:(CompletionHandler)handler;

@end
