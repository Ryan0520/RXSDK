//
//  RMRefreshComponet.m
//  RMRefresh
//
//  Created by 沈文涛 on 15/10/6.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import "RMRefreshComponet.h"

@implementation RMRefreshComponet

static id _instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.money = @"1200";
        self.email = @"CoderRxShen@126.com";
        self.name  = @"Ryan";
        self.phone = @"15521325365";
        NSLog(@"money=%@,email=%@,name=%@,phone=%@",self.money,self.email,self.name,self.phone);
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [super allocWithZone:zone];
}

- (void)run
{
    NSLog(@"run");
}

- (void)climb
{
    NSLog(@"climb");
}

- (void)eat
{
    NSLog(@"eat");
}

@end
