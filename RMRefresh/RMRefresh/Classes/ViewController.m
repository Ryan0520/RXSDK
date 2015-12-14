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
- (IBAction)switchValueChange:(UISwitch *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)switchValueChange:(UISwitch *)sender
{
    NSDictionary *dict =  @{@"open_id" : @"123",@"platform" : @"QQ"};
    
    [[RXApiEngine sharedInstance] requestService:@"user.socialLogin"
                                      parameters:dict
                                       onSuccess:^(NSDictionary *jsonData) {
        NSLog(@"%@",jsonData);
    } onFailure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


@end
