//
//  RXApiEngine.m
//  RXSDK
//
//  Created by Ryan on 15/11/17.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "RXApiEngine.h"
#import <AFNetworking.h>

@implementation RXApiEngine

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
    
    switch (type) {
        case RequestMethodTypeGet:
        {
            [manager GET:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               
                if (competionHandler) {
                    competionHandler(responseObject,nil);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (competionHandler) {
                    competionHandler(nil,error);
                }
                
            }];
        }
            break;
            
        case RequestMethodTypePost:
        {
            [manager POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (competionHandler) {
                    competionHandler(responseObject,nil);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (competionHandler) {
                    competionHandler(nil,error);
                }
                
            }];
        }
            break;
        default:
            break;
    }
    
}

@end
