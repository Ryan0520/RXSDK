//
//  NSDate+Extension.h
//  F4App
//
//  Created by Kratos on 15/4/13.
//  Copyright (c) 2015年 iOS Team. All rights reserved.
//  

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

/**
 *  根据Date类型的时间返回时间字符串
 */
+ (NSString *)createDate:(NSDate *)createdDate;

/**
 *  根据时间字符串以及格式字符串返回时间戳字符串
 *
 *  @param dateStr 时间字符串
 *  @param format  格式字符串
 *
 *  @return 时间戳字符串
 */
+ (NSString *)timestampStrWithDateStr:(NSString *)dateStr format:(NSString *)format;

/**
 *  根据NSDate返回时间戳字符串
 *
 *  @param date NSDate  为nil时表示返回当前时间时间戳
 *
 *  @return 时间戳字符串
 */
+ (NSString *)timestampStrWithDate:(NSDate *)date;

/**
 *  返回时间的格式是YYYY年MM月DD日
 *
 */
+ (NSString *)createDateWithYYYYMMDD:(NSDate *)createdDate;

/**
 *  时间戳返回时间字符串
 */
+ (NSString *)transTimeWithTimeString:(NSString *)time;

@end
