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
    void (^sucessHandler)(NSDictionary *) = ^(NSDictionary *json)
    {
        NSLog(@"%@",[NSThread currentThread]);
    };
    
    void (^failureHandler)(NSError *) = ^(NSError *error)
    {
        NSLog(@"%@",error);
    };
    
    if (sender.isOn)
    {
        for (NSInteger index= 0 ; index< 10; index++) {
            [[RXApiEngine sharedInstance] requestService:@"option.project_region"
                                              parameters:@{}
                                               onSuccess:sucessHandler
                                               onFailure:failureHandler];
        }
    }else{
        [[RXApiEngine sharedInstance] cancelAllTask];
    }
}
@end
