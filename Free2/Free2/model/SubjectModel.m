//
//  SubjectModel.m
//  Free2
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "SubjectModel.h"

@implementation SubjectModel

//将当前模型中容器属性这个属性，转化成其后的类型、
+(NSDictionary *)modelContainerPropertyGenericClass
{
    //将当前模型中容器属性这个属性，转化成其后的类型、
    return @{@"applications":[SubjectModelAppModel class]};
}

@end

@implementation SubjectModelAppModel



@end
