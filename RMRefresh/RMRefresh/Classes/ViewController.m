//
//  ViewController.m
//  RMRefresh
//
//  Created by 沈文涛 on 15/10/6.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import "ViewController.h"
#import "RXApiEngine.h"
#import "EPOAuthManager.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    void (^failureHandler)(NSError *) = ^(NSError *error)
    {
        NSLog(@"%@",error);
    };
    
    [[NSUserDefaults standardUserDefaults] setObject:@"60f4fbcba8074bfa70d2ac1bdaf3f1ded420d543" forKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *phone = @"15521325365";

    [[RXApiEngine sharedInstance] requestService:@"userInfo.userInfo" parameters:nil onSuccess:^(NSDictionary *json) {

    } onFailure:failureHandler];
    
    //    [EPOAuthManager fetchValidateCodeWithPhone:phone successHandler:^(NSString *code) {
    //
    //        NSLog(@"%@",code);
    //
    //    } failureHandler:failureHandler];
    
//    [EPOAuthManager loginWithPhone:phone validateCode:@"02877" validateTicket:@"L7QOMGP" successHandler:^(NSString *authCode) {
//
//    } failureHandler:failureHandler];
    
//    [EPOAuthManager getAccessTokenWithAuthCode:@"XiJfP" scope:@"all" successHandler:^(NSString *access_token) {
//        
//    } failureHandler:failureHandler];
    

    
//    [EPOAuthManager fetchValidateCodeWithPhone:phone
//                                successHandler:^(NSString *code) {
//                                    NSLog(@"%@",code);
//                                }
//                                failureHandler:failureHandler];
}
@end