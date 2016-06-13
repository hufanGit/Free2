//
//  CategoryViewController.m
//  Free2
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "CategoryViewController.h"
#import <UIImageView+AFNetworking.h>

@interface CategoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *categoryTableView;
//表格视图


@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation CategoryViewController

#pragma mark 懒加载

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

#pragma mark taleview代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    
    
    
    //刷新cell
    CategoryModel *model = self.dataArray[indexPath.row];
    
    //使用af来导入URL图片
    [cell.imageView setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@""]];
    cell.textLabel.text = model.categoryCname;
    
    cell.detailTextLabel.text =[NSString stringWithFormat:@"共多%@ 款，其中%@免费",model.categoryCount,model.limited];
    
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    // Do any additional setup after loading the view.
}


#pragma mark -tableview Delegate

//cell 的点击事件。
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryModel *model = self.dataArray[indexPath.row];
    
    self.setValue(model.categoryId);

    
    //返回上个界面
    [self backLastView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 网络请求

-(void)requestData
{
    [self.requestManager GET:kCateUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"分类请求数据成功");
        
        //将请求的数据转化成模型
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[CategoryModel class] json:responseObject];
        
//        NSLog(@"%@",modelArray);
        [self.dataArray addObjectsFromArray:modelArray];
        
        [self.categoryTableView reloadData];
       
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"分类失败");
    }];
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
    
    //添加约束
    __weak typeof(self) weakself = self;
    [self.categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view);
    }];
    
    [self addMJRefresh];
    
    //设置代理
    self.categoryTableView.delegate =self;
    self.categoryTableView.dataSource =self;
    //设置行高
    self.categoryTableView.rowHeight =100;
}

#pragma mark - 添加刷新控件
- (void)addMJRefresh {
    
    //下拉
    self.categoryTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //进入刷新状态后会调用
        [self.categoryTableView.mj_header endRefreshing];
    }];
    
    //上拉
    self.categoryTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.categoryTableView.mj_footer endRefreshing];
    }];
}


@end
