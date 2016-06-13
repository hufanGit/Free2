//
//  CategoryViewController.h
//  Free2
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "BasicViewController.h"

@interface CategoryViewController : BasicViewController

//使用block 反向传值。????? 在下一级声明调用block，上一及实现
@property(nonatomic,copy)void(^setValue)(NSString *cateID);

@end
