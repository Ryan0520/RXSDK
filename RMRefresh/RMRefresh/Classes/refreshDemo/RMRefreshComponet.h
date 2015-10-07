//
//  RMRefreshComponet.h
//  RMRefresh
//
//  Created by 沈文涛 on 15/10/6.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMRefreshComponet : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *money;

- (void)run;
- (void)eat;
- (void)climb;

+ (instancetype)shareInstance;

@end
