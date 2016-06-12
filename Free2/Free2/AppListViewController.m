//
//  AppListViewController.m
//  Free2
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "AppListViewController.h"
#import "SettingViewController.h"
#import "CategoryViewController.h"


@interface AppListViewController ()<UISearchBarDelegate>

@property(nonatomic,strong)UITableView *appTableView;

@end

@implementation AppListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark 创建界面
-(void)creatUI
{
    //设置导航栏
    
    
    //分类
    [self addNavigationItemWithTitle:@"分类" isBack:NO isRight:NO target:self action:@selector(category:)];
    
    [self addNavigationItemWithTitle:@"设置" isBack:NO isRight:YES target:self action:@selector(setting:)];
    
    
    //创建tabview
    self.appTableView  = [[UITableView alloc]init];
    
    self.appTableView.translatesAutoresizingMaskIntoConstraints =NO;
    
    [self.view addSubview:self.appTableView];
    
    //添加约束
    //__weak typeof(self) weakself = self;
    [self .appTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        //同时添加上下左右的边距。
        make.edges.equalTo(self.view);
    }];
    
    //调用刷新控件
    [self addMJRefresh];
    
    //添加搜索框，在cell 的上面
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 0, 40)];
    searchBar.showsCancelButton = YES;
    searchBar.placeholder = @"百万应用想爆就爆";
    
    searchBar.delegate =self;
    
    self.appTableView.tableHeaderView = searchBar;
}
#pragma mark 添加刷新空间

-(void)addMJRefresh
{
    self.appTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        //刷新
        [self.appTableView.mj_header endRefreshing];
    }];
    
    self.appTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.appTableView.mj_footer endRefreshing];
        
    }];
}



#pragma mark searchBar代理方法。

//搜索按钮
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

//点击取消
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //收齐键盘
    [searchBar resignFirstResponder];
    searchBar.text = nil;
}

//分类  的点击事件
-(void)category:(UIButton *)button
{
    CategoryViewController *category = [[CategoryViewController alloc]init];
    
    category.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:category animated:YES];
}

//设置  的点击事件。
-(void)setting:(UIButton *)button
{
    SettingViewController *setting = [[SettingViewController alloc]init];
    
    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];
}



@end
