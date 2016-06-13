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
#import "AppListModel.h"
#import "AppListCell.h"


@interface AppListViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *appTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation AppListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self resquestDataWithPage:1 search:@"" cate_ID:@""];
    
    [self.appTableView reloadData];
    
}

#pragma mark 懒加载
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}



#pragma mark 数据请求
-(void)resquestDataWithPage:(NSInteger)page search:(NSString *)search cate_ID:(NSString*)cate_ID
{
    
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:page],@"number":@20,@"search":search};
    
    if (self.cateId)
    {
        //存在选中项的时候
        
        dic =@{@"page":[NSNumber numberWithInteger:page],@"number":@20,@"search":search,@"cate_id":self.cateId};
        printf("%s\n",self.cateId.UTF8String);
    }
    
    NSLog(@"%@",dic);
    //使用AFnetworking
    [self.requestManager GET:self.requestURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject)
    {
    NSLog(@"第一界面请求成功");
        
        //请求到一个字典。
        
        NSArray *plistArray= responseObject[@"applications"];
        
        //将字典数组转化成模型数组YYmodel
        
        //参数1， 模型的类型，参2. 需要转的数组
        NSArray *appArray = [NSArray yy_modelArrayWithClass:[AppListModel class] json:plistArray];
        
        
        //将模型放在数据源数组中
        [self.dataArray addObjectsFromArray:appArray];
        
        printf("刷新后数组的长%lu\n",(unsigned long)self.dataArray.count);
        
        //刷新
        [self.appTableView.mj_header endRefreshing];
        printf("关闭头部刷新\n");
        
        [self.appTableView.mj_footer endRefreshing];
        
        [self.appTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"第一界面请求失败");
    }];
    
    
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
    
    
    self.appTableView.delegate =self;
    self.appTableView.dataSource =self;
    
    //设置cell 的高度
    self.appTableView.rowHeight = 135;
    
    //注册cell
    
    [self.appTableView registerNib:[UINib nibWithNibName: @"AppListCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    
    //添加搜索框，在cell 的上面
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 0, 40)];
    searchBar.showsCancelButton = YES;
    searchBar.placeholder = @"百万装备想爆就爆";
    
    searchBar.delegate =self;
    
    self.appTableView.tableHeaderView = searchBar;
}

#pragma mark 添加刷新

-(void)addMJRefresh
{
    self.appTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        
        printf("调用fresh\n");
        //刷新
        //[self.appTableView.mj_header endRefreshing];
        //[self.appTableView.mj_header Refreshing];

        if ([self.appTableView.mj_header isRefreshing]) {
            [self.dataArray removeAllObjects];
            printf("数组移除完毕%lu\n",(unsigned long)self.dataArray.count);
        }
        //重新请求
        [self resquestDataWithPage:1 search:@"" cate_ID:self.cateId];
        
        
    }];
    
    self.appTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        //[self.appTableView.mj_footer endRefreshing];
        
        NSInteger page = self.dataArray.count/20;
        
        [self resquestDataWithPage:page search:@"" cate_ID:@""];
        
    }];
}

#pragma mark tableview


//设置cell 数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


//创建cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //去复用查找cell
    
    AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = self.dataArray [indexPath.row];
    
    
    return cell;
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
    
    //在跳转到下一个界面的地方添加block实现。
    CategoryViewController *category = [[CategoryViewController alloc]init];
    
    
    
    //实现下一级界面的block
    
    category.setValue = ^(NSString *cateID)
    
    {
     
        [self.appTableView.mj_header beginRefreshing];
        
        //[self resquestDataWithPage:1 search:@"" cate_ID:self.cateId];
        
        self.cateId = cateID;
        
        
        
      
        
        printf("block\n");
    
        
    };
    
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
