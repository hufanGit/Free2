//
//  bigImageViewController.h
//  Free2
//
//  Created by 千锋 on 16/6/15.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bigImageViewController : UIViewController


//数据源数组
@property(nonatomic,strong)NSArray *photoArray;

//详情页选中的下标
@property(nonatomic,assign)NSInteger index;

@end
