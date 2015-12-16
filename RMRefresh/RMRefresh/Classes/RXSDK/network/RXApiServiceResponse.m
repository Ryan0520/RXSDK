//
//  RXApiServiceResponse.m
//  RMRefresh
//
//  Created by Ryan on 15/11/24.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import "RXApiServiceResponse.h"
#import "RXApiServiceEngine.h"
#import "RXMarco.h"
#define checkNull(__X__) (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]
@implementation RXApiServiceResponse

+ (instancetype)responseWithJson:(NSDictionary *)json
{
    if (![json isKindOfClass:[NSDictionary class]]) return nil;
    RXApiServiceResponse *response = [[RXApiServiceResponse alloc] init];
    response.message = checkNull(json[@"message"]);
    response.code = (RXApiServiceResponseStatus)[RXCONVERTER(json[@"code"]) integerValue];
    response.data = RXCONVERTER(json[@"data"]);
    return response;
}

@end
