//
//  RXApiServiceResponse.h
//  RMRefresh
//
//  Created by Ryan on 15/11/24.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXStatusDefine.h"

@interface RXApiServiceResponse : NSObject
/** 应答状态 */
@property (nonatomic, assign) RXApiServiceResponseStatus code;
/** 错误消息，如无错，则为nil */
@property (nonatomic, copy) NSString *message;
/** 应答内容 */
@property (nonatomic, strong) NSDictionary *data;

@end


