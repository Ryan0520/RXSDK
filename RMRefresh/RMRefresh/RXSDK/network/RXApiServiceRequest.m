//
//  RXApiServiceRequest.m
//  RMRefresh
//
//  Created by Ryan on 15/11/24.
//  Copyright © 2015年 RyanShen. All rights reserved.
//

#import "RXApiServiceRequest.h"

@implementation RXApiServiceRequest
- (NSString *)description
{
    return [NSString stringWithFormat:@"\n请求体request:\nos = %@\nosVersion = %@\nappName = %@\nappVersion = %@\nudid = %@\nsessionId = %@\nservice = %@\naccessToken = %@\nparams = %@\n",_os,_osVersion,_appName,_appVersion,_udid,_sessionId,_service,_accessToken,_params];
}

+ (NSDictionary *)dictionaryWithRequset:(RXApiServiceRequest *)request
{
	if (request.params == nil) request.params = @{};
	
	if (request.udid == nil) {
		request.udid = @"";
	}
	
	NSDictionary *dict = @{@"os":request.os,
						   @"os_version":request.osVersion,
						   @"app_name":request.appName,
						   @"app_version":request.appVersion,
						   @"udid":request.udid,
						   @"service":request.service,
						   @"access_token":request.accessToken,
						   @"params":request.params};
	return dict;
}
@end
