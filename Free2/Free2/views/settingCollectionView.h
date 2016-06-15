//
//  settingCollectionView.h
//  Free2
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

#import "AppListModel.h"
@class setModel;

@interface settingCollectionView : UICollectionViewCell

@property(nonatomic,strong)setModel *model;

@property(nonatomic,strong)PhotoModel *photoModel;

@property(nonatomic,strong)AppListModel *appModel;

@end
