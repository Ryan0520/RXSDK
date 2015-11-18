//
//  RXMarco.h
//  RXSDK
//
//  Created by Ryan on 15/11/17.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#ifndef RXMarco_h
#define RXMarco_h
// 设备机型
#define iPhone4 [UIScreen mainScreen].bounds.size.height==480 ? YES : NO
#define iPhone5 [UIScreen mainScreen].bounds.size.height==568 ? YES : NO
#define iPhone6 [UIScreen mainScreen].bounds.size.width==375 ? YES : NO
#define iPhone6P [UIScreen mainScreen].bounds.size.height==736 ? YES : NO
// 设备系统
#define iOS7 [[UIDevice currentDevice].systemVersion doubleValue] >= 7.0
#define iOS8 [[UIDevice currentDevice].systemVersion doubleValue] >= 8.0
#define iOS9 [[UIDevice currentDevice].systemVersion doubleValue] >= 9.0
// 设备屏幕尺寸
#define kScreen_Height   ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width    ([UIScreen mainScreen].bounds.size.width)
// 一像素的宽度
#define SINGLE_LINE_WIDTH  (1.0f / [[UIScreen mainScreen] scale])
// iOS8的字体
#define EPFONT(_size_) [UIFont fontWithName:@"HelveticaNeue" size:_size_]
// 调试输出日志
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d\n%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


#endif /* RXMarco_h */
