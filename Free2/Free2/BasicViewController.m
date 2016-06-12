//
//  BasicViewController.m
//  Free2
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //为所有的视图控制器设置颜色为白色
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self creatUI];

}








#pragma mark 添加头部的导航控制器。
-(void)addNavigationItemWithTitle:(NSString *)title isBack:(BOOL)isBack isRight:(BOOL)isRight target:(id)target action:(SEL)action
{
    //自定义按钮创建。
    UIButton *button = [[UIButton alloc]init];
    
    //如果是返回按钮，
    if (isBack) {
        button.frame= CGRectMake(0, 0, 63, 30);
        [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    }
    else
    {
        button.frame = CGRectMake(0, 0, 44, 30);
        [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    }
    
    
    //设置文字
    [button setTitle:title forState:UIControlStateNormal];
    //设置文字颜色
    //[button setTitleColor:[UIColor colorWithRed:61/255.0 green:40/255.0 blue:60/255.0 alpha:1] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor colorWithR:61 G:40 B:60] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    //添加点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //根据自定义按钮创建导航按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    if (isRight)
    {
        [self.navigationItem setRightBarButtonItem:item];
        
        
    }
    else
    {
        [self.navigationItem setLeftBarButtonItem:item];
    }
    
}
#pragma mark 创建界面

-(void)creatUI
{
    
}

#pragma mark 返回上一页
-(void)backLastView
{
    [self.navigationController popViewControllerAnimated:YES];

}

@end
