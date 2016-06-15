//
//  AppListModel.h
//  Free2
//
//  Created by 千锋 on 16/6/13.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppListModel : NSObject<YYModel>

//appID
@property(nonatomic,strong)NSString *applicationId;

//头像
@property(nonatomic,copy)NSString *iconUrl;

//名字
@property(nonatomic,copy)NSString *name;

//时间
@property(nonatomic,copy)NSString *releaseDate;

//价格
@property(nonatomic,copy)NSString *lastPrice;

//星级
@property(nonatomic,copy)NSString *starCurrent;

//类型
@property(nonatomic,copy)NSString *categoryName;

//分享
@property(nonatomic,copy)NSString *shares;

//收藏
@property(nonatomic,copy)NSString *favorites;

//下载
@property(nonatomic,copy)NSString *downloads;

//描述

@property(nonatomic,copy)NSString *descrip;


@end
