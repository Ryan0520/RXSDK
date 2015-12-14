//
//  RXApiEngine.m
//  RXSDK
//
//  Created by Ryan on 15/11/17.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "RXApiEngine.h"
@implementation RXApiEngine
singleton_implementation(RXApiEngine)

- (instancetype)init
{
    self = [super initWithBaseUrl:@"http://120.24.88.40:8888/oauth2/api?"
                            appId:@"123"
                        secretKey:nil
                     appSecretKey:@"123"];
    return self;
}

@end
