//
//  CategoryViewController.m
//  Free2
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()
@property(nonatomic,strong)UITableView *categoryTableView;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 创建界面
-(void)creatUI
{
    self.title =@"分类";
    [self addNavigationItemWithTitle:@"返回" isBack:YES isRight:NO target:self action:@selector(backLastView)];
    
    //添加刷新
    
    
    //加上TableView
    self.categoryTableView = [UITableView new];
    
    self.categoryTableView.translatesAutoresizingMaskIntoConstraints =NO;
    
    [self .view addSubview:self.categoryTableView];
    
    [self.categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self addMJRefresh];

}

#pragma mark 刷新控件。
-(void)addMJRefresh
{
    self.categoryTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //刷新
        [self.categoryTableView.mj_header endRefreshing];
    }];
    
    self.categoryTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.categoryTableView.mj_footer endRefreshing];
        
    }];
}


@end
