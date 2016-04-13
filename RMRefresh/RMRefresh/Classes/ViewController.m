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
	
	[EPOAuthManager  getUserInfoWithUserId:@"12" source:@"cxs" success:^{
		
	} failure:^(NSError *error) {
		
	}];
}
@end