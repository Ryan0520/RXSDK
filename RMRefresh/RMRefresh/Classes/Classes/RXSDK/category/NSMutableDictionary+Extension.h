//
//  NSMutableDictionary+Extension.h
//  RXSDK
//
//  Created by Ryan on 15/11/17.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Extension)
/**
 *  处理urlQuery的参数转成可变字典
 *
 *  @param urlQuery
 *
 *  @return 可变字典
 */
+ (instancetype)dealUrlParmasWithQuery:(NSString *)urlQuery;
@end
