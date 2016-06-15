//
//  HFSearchViewController.m
//  Free2
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "HFSearchViewController.h"
#import "AppListModel.h"
#import "AppListCell.h"

@interface HFSearchViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *searchTableView;

@end

@implementation HFSearchViewController

-(NSMutableArray *)dataArray
{
    if (!_dataArray ) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

-(void )viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [self resquestDataWithPage:1 search:self.searchText cate_ID:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self resquestDataWithPage:1 search:self.searchText cate_ID:nil];
}

//创建界面
-(void)creatUI
{
    self.searchTableView = [UITableView new];
    
    [self.view addSubview:self.searchTableView];
    
    self.searchTableView.translatesAutoresizingMaskIntoConstraints=NO;
    
    __weak typeof(self) weakself = self;
    [self.searchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakself.view);
    }];
    
    self.searchTableView.delegate =self;
    self.searchTableView.dataSource =self;
    
    //注册cell
    
    [self.searchTableView registerNib:[UINib nibWithNibName:@"AppListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    self.title =@"搜索结果";
    [self addNavigationItemWithTitle:@"返回" isBack:YES isRight:NO target:self action:@selector(backLastView)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 获取数据

-(void)resquestDataWithPage:(NSInteger)page search:(NSString *)search cate_ID:(NSString*)cate_ID
{
    NSDictionary *dict = @{@"page":@(page),@"number":@20,@"search":self.searchText};
    
    [self.requestManager GET:self.requestURL parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *dicArray = responseObject[@"applications"];
        
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[AppListModel class] json:dicArray];
        
        //将模型放入dataArray
        [self.dataArray addObjectsFromArray:modelArray];
        
        [self.searchTableView reloadData];
        
        NSLog(@"chengg");
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"filed");
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //设置行数
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //在6 上是135
    CGFloat scale = 135/667.0f;
    return scale * self.view.frame.size.height;
}



@end
