//
//  DetailModel.m
//  Free2
//
//  Created by 千锋 on 16/6/15.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

//更改映射
+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"desc":@"description"};
}

//装载成数组
+(NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"photos":[PhotoModel class]};
}

@end

@implementation PhotoModel



@end