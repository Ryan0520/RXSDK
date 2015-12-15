//
//  ViewController.m
//  RMRefresh
//
//  Created by 沈文涛 on 15/10/6.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import "ViewController.h"
#import "RXApiEngine.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"db95135e13cbf19be01c2528691def27f3617c8b"
                                              forKey:@"access_token"];
    
    NSDictionary *parmas = @{@"user_id": @"123"};
    
    void (^successHandler)(NSDictionary *) = ^(NSDictionary *json)
    {
        
    };
    
    void (^failureHandler)(NSError *) = ^(NSError *error)
    {
        NSLog(@"%@",error);
    };
    
    [[RXApiEngine sharedInstance] requestService:@"user.Test"
                                      parameters:parmas
                                       onSuccess:successHandler
                                       onFailure:failureHandler];
}
@end
