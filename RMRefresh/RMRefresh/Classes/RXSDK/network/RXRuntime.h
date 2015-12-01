//
//  RXRuntime.h
//  RMRefresh
//
//  Created by Ryan on 15/11/24.
//  Copyright © 2015年 RyanShen. All rights reserved.
//
#import "RXBaseCompoent.h"

NS_ASSUME_NONNULL_BEGIN
@interface RXRuntime : NSObject
singleton_interface(RXRuntime)
// 操作系统
@property (nonatomic, strong, readonly) NSString *os;

// 操作系统版本
@property (nonatomic, strong, readonly) NSString *osVersion;

// 应用名
@property (nonatomic, strong, readonly) NSString *appName;

// 应用版本
@property (nonatomic, strong, readonly) NSString *appVersion;

// 设备ID
@property (nonatomic, strong, readonly) NSString *udid;

// 缓存目录
@property(nonatomic, strong, readonly) NSString *cacheDirPath;
@end
NS_ASSUME_NONNULL_END