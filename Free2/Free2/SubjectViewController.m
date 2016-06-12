//
//  SubjectViewController.m
//  Free2
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "SubjectViewController.h"

@interface SubjectViewController ()

@property(nonatomic,strong)UITableView *subjectTableView;

@end

@implementation SubjectViewController

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
    self.subjectTableView = [[UITableView alloc]init];
    
    [self addMJRefresh];
    
    self.subjectTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.subjectTableView];
    
    [self.subjectTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.edges.equalTo(self.view);
    }];
    
    
    
    
}

-(void)addMJRefresh
{
    // 设置文字
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh:)];
    
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    self.subjectTableView .mj_header = header;
    
    
    
    
    MJRefreshBackGifFooter *footer =[MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshss:)];
    
    [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];
    
    
    self.subjectTableView.mj_footer = footer;


}

-(void)refresh:(MJRefreshGifHeader *)header
{
    //刷新时候的操作
    [self.subjectTableView.mj_header endRefreshing];
}


-(void)refreshss:(MJRefreshBackFooter *)footer
{
    [self.subjectTableView.mj_footer endRefreshing];
}
@end
