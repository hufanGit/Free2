//
//  BasicViewController.h
//  Free2
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController

//请求路径
@property(nonatomic,strong)NSString *requestURL;
//AFNet的管理员
@property (nonatomic,strong)AFHTTPSessionManager *requestManager;

-(void)addNavigationItemWithTitle:(NSString *)title isBack:(BOOL)isBack isRight:(BOOL)isRight target:(id)target action:(SEL)action;

-(void)creatUI;

-(void)backLastView;

@end
