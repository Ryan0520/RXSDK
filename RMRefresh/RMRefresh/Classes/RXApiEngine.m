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
    
    self = [super initWithBaseUrl:url
                            appId:@"123"
                        secretKey:nil
                     appSecretKey:@"123"
                      accessToken:accessToken];
    
    return self;
}

@end
