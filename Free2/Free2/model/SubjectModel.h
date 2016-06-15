//
//  SubjectModel.h
//  Free2
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectModel : NSObject<YYModel>

//应用程序数组
@property(nonatomic,strong)NSArray *applications;

//日期
@property(nonatomic,copy)NSString *date;

//描述
@property(nonatomic,copy)NSString *desc;

//头像
@property(nonatomic,copy)NSString *desc_img;

//大图片
@property(nonatomic,copy)NSString *img;

//标题
@property(nonatomic,copy)NSString *title;

@end

@interface SubjectModelAppModel:NSObject

//应用
@property(nonatomic,copy)NSString *applicationId;

//下载数
@property(nonatomic,copy)NSString *downloads;

//icon
@property(nonatomic,copy)NSString *iconUrl;

//名字
@property(nonatomic,copy)NSString *name;

//评论
@property(nonatomic,copy)NSString *ratingOverall;

//星级
@property(nonatomic,copy)NSString *starOverall;

@end
