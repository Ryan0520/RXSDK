//
//  UIImage+Extension.h
//  BWDApp
//
//  Created by Kratos on 15/8/14.
//  Copyright (c) 2015年 Flinkinfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  返回一张具有边界的图片
 *
 *  @param name        图片名字
 *  @param borderWidth 边界宽度
 *  @param borderColor 边界颜色
 */
+ (instancetype)circleImageWithName:(NSString *)name
                        borderWidth:(CGFloat)borderWidth
                        borderColor:(UIColor *)borderColor;
/**
 *  拉伸图片
 *
 *  @param imageName 图片名
 */
+ (instancetype)captureImageWithImageName:(NSString *)imageName;

/**
 *  返回一张纯颜色的图片
 *
 *  @param size  尺寸大小
 */
+ (instancetype)imageViewWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  修发图片大小
 *
 *  @param image 要修剪的图片
 *  @param newSize 要修剪的图片大小
 */
+ (instancetype)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize;

/**
 * 返回一张圆形图片
 */
- (instancetype)circleImage;

/**
 * 返回一张圆形图片
 */
+ (instancetype)circleImageNamed:(NSString *)name;

@end
