//
//  CustomTabBarController.m
//  Free2
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "CustomTabBarController.h"
#import "LimitViewViewController.h"
#import "ReductionViewController.h"
#import "FreeViewController.h"
#import "SubjectViewController.h"
#import "HotViewController.h"
#import "CustomNavitationController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CreatControllers];
    
     //设置界面
    [self CreatUI];
}

#pragma mark 创建界面
-(void)CreatUI
{
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
    
    //设置tabbar 的颜色
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:60/155.0 green:130/255.0 blue:200/255.0 alpha:1]}];
    
    //设置tabbar 上面的文字颜色
    [self.tabBar setTintColor:[UIColor colorWithRed:60/155.0 green:130/255.0 blue:200/255.0 alpha:1]];
   
    
    
}


#pragma mark 创建视图控制器

-(void)CreatControllers
{
    //拿到plist
    NSString * pathlist = [[NSBundle mainBundle]pathForResource:@"controllers.plist" ofType:nil];
    
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:pathlist];
    
    //枚举遍历
    [plistArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *className = obj[@"className"];
        NSString *imageName = obj[@"imageName"];
        NSString *title = obj[@"title"];
        
        //将类名转化成类。runtime
        Class HFclass =NSClassFromString(className);
        
        UIViewController *controller = [[HFclass alloc]init];
        
        //设置item
        controller.title = title;
        
        controller.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        controller.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_press",imageName]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //添加到tab
        CustomNavitationController *nav = [[CustomNavitationController alloc]initWithRootViewController:controller];
        
        
        [self addChildViewController:nav];
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
