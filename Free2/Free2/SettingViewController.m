//
//  SettingViewController.m
//  Free2
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "SettingViewController.h"
#import "setModel.h"
#import "settingCollectionView.h"

@interface SettingViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation SettingViewController

-(NSMutableArray *)dataArray
{
    
    if (!_dataArray ) {
        
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetpList];
    // Do any additional setup after loading the view.
    //[self creatUI];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 创建界面
-(void)creatUI
{
    
    printf("创建界面\n");
    self.title =@"设置";
    [self addNavigationItemWithTitle:@"返回" isBack:YES isRight:NO target:self action:@selector(backLastView)];
    
   // self.view.backgroundColor = [UIColor redColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //创建自动布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //水平方向最小间隙的设置
    layout.minimumInteritemSpacing = 40;
    //垂直方向最小间隙的设置
    layout.minimumLineSpacing = 40;
    
    //实例化滚动视图类
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,50,self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    
    //设置滚动视图的代理
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //把滚动视图添加到视图控制器上面。
    [self.view addSubview:self.collectionView];
    
    
    //为滚动视图添加对应得cell
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"settingCollectionView" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //UICollectionViewCell:必须使用自定义的方式，必须使用注册cell的样式
    
    //创建
    settingCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //填充cell数据
    cell.model = self.dataArray[indexPath.row];
  
    return cell;
}

//设置cell 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat W = (self.view.frame .size.width -180)/3.0f;
    CGFloat H  = W + 16;
    
    return CGSizeMake(W, H);
}
//设置上下左右的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(40, 40, 40, 40);
}

//设置行距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 40;
}


#pragma mark 请求数据
-(void)GetpList
{
    NSString * pathlist = [[NSBundle mainBundle]pathForResource:@"Setting.plist" ofType:nil];
    
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:pathlist];
    
    //枚举遍历
    [plistArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        setModel *model = [setModel new];
        
        model.image = obj[@"image"];
        model.name = obj[@"name"];
        
        [self.dataArray addObject:model];
        
    }];
    
    
    printf("%lu\n",(unsigned long)self.dataArray.count);
    
//      [self.collectionView reloadData];

}

@end
