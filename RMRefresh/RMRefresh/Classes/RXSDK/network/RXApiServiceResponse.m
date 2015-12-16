//
//  RXApiServiceResponse.m
//  RMRefresh
//
//  Created by Ryan on 15/11/24.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import "RXApiServiceResponse.h"

@implementation RXApiServiceResponse

+ (instancetype)responseWithJson:(NSDictionary *)json
{
    if (![json isKindOfClass:[NSDictionary class]]) return nil;
    RXApiServiceResponse *response = [[RXApiServiceResponse alloc] init];
    response.message = json[@"message"];
    response.code = (RXApiServiceResponseStatus)[json[@"code"] integerValue];
    response.data = json[@"data"];
    return response;
}

@end
