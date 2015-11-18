//
//  NSBundle+Extension.m
//  EPIMApp
//
//  Created by 沈文涛 on 15/10/24.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "NSBundle+Extension.h"

@implementation NSBundle (Extension)
/**
 *  加载从Bundle加载Xib
 *
 *  @param xibName xib的名字
 *
 *  @return xib
 */
+ (id)loadXibNameWith:(NSString *)xibName
{
    return [[[NSBundle mainBundle] loadNibNamed:xibName
                                          owner:nil
                                        options:nil] lastObject];
}

@end
