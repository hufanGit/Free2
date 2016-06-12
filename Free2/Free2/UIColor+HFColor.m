//
//  UIColor+HFColor.m
//  Free2
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "UIColor+HFColor.h"
//类别文件。
@implementation UIColor(HFColor)

+(UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B
{
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}

+(UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B alpth:(CGFloat)alpha
{
     return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:alpha];
}


@end
