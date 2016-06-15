//
//  DetailModel.h
//  Free2
//
//  Created by 千锋 on 16/6/15.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject<YYModel>

//iocn
@property(nonatomic,copy)NSString *iconUrl;

//名字
@property(nonatomic,copy)NSString *name;

//原价格
@property(nonatomic,copy)NSString *lastPrice;

//当前价格
@property(nonatomic,copy)NSString *currentPrice;

//分类
@property(nonatomic,copy)NSString *categoryName;

//评分
@property(nonatomic,copy)NSString *starCurrent;

//图片
@property(nonatomic,copy)NSArray *photos;

//描述
@property(nonatomic,copy)NSString *desc;

//下载链接
@property(nonatomic,copy)NSString *itunesUrl;



@end

@interface PhotoModel : NSObject
//小图
@property(nonatomic,copy)NSString *smallUrl;

//大图
@property(nonatomic,copy)NSString *originalUrl;

@end

