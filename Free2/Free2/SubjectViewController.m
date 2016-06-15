//
//  SubjectViewController.m
//  Free2
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "SubjectViewController.h"
#import "SubjectModel.h"
#import "SubjectCell.h"


@interface SubjectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *subjectTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SubjectViewController

-(instancetype)init
{
    if (self = [super init]) {
        //在创建时候给一个请求地址、
        self.requestURL = kSubjectUrl;
    }
    return self;
}

#pragma mark - 获取数据
//page 分页 number 数量

-(void)requestDataWithPage:(NSInteger)page
{
    [self.requestManager GET:self.requestURL parameters:@{@"page":[NSNumber numberWithInteger:page],@"number":@5} success:^(NSURLSessionDataTask *task, id responseObject)
    {
        
        printf("专题成功\n");
        
        //将获取到的数据转化成模型数组。。
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[SubjectModel class] json:responseObject];
  
        
        
        if([self.subjectTableView.mj_header isRefreshing])
        {
            [self.dataArray removeAllObjects];
        }
        [self.subjectTableView.mj_header endRefreshing];
        [self.subjectTableView.mj_footer endRefreshing];
        
        [self.dataArray addObjectsFromArray:modelArray];
        
        [self.subjectTableView reloadData];
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        printf("专题请求失败\n");
    }];
}

#pragma mark  懒加载
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestDataWithPage:1];
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
    
    self.subjectTableView.delegate  =self;
    self.subjectTableView.dataSource= self;
    
    self.subjectTableView.rowHeight = 324;
    
    [self.subjectTableView registerNib:[UINib nibWithNibName:@"SubjectCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    SubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //刷新数据
    cell.model = self.dataArray [indexPath.row];
    
    return cell;
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
    [self addMore];
    
    self.subjectTableView.mj_footer = footer;


}

#pragma mark 上拉加载
-(void)addMore
{
    [self requestDataWithPage:(self.dataArray.count/5+1)];
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
