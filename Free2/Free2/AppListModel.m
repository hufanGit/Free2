//
//  AppListModel.m
//  Free2
//
//  Created by 千锋 on 16/6/13.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "AppListModel.h"

@implementation AppListModel

//从新定制映射
+(NSDictionary *)modelCustomPropertyMapper
{
    //属性的descrip和字典的description对应
    return @{@"descrip":@"description"};
}
-(NSString *)description
{
    return _descrip;
}


@end
