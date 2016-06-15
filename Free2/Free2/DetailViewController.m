//
//  DetailViewController.m
//  Free2
//
//  Created by 千锋 on 16/6/15.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailModel.h"
#import "settingCollectionView.h"
#import "AppListModel.h"
#import "bigImageViewController.h"

#import <CoreLocation/CoreLocation.h>


@interface DetailViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,CLLocationManagerDelegate>


//子视图
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *topCollectionView;

@property (weak, nonatomic) IBOutlet UITextView *descTextView;


@property (weak, nonatomic) IBOutlet UICollectionView *bottonView;


//当钱页面
@property(nonatomic,strong)DetailModel *detailModel;




//定位管理
@property(nonatomic,strong)CLLocationManager *locationManager;


//下面的数据源
@property(nonatomic,strong)NSMutableArray *bottomArray;

@end

@implementation DetailViewController


#pragma mark 懒加载下面模型的数据源

-(NSMutableArray *)bottomArray
{
    if (!_bottomArray) {
        _bottomArray = [NSMutableArray new];
    }
    return _bottomArray;
}

- (void)viewDidLoad {
    [self requestData];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //开始定位
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        
        if ([CLLocationManager locationServicesEnabled]) {
            
            
            //设置plist
            [_locationManager requestAlwaysAuthorization];
            
            //设置精确度
            [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
            
            //设置过滤距离
            [_locationManager setDistanceFilter:200];
            
            
            //设置代理 //遵循协议拿到定位结果
            
            _locationManager.delegate = self;
            
 
            
            printf("支持定位\n");
        }
        else
        {
            printf("不支持定位\n");
        }
    }
    return _locationManager;
}

#pragma mark 定位



#pragma mark 给子视图赋值
-(void)setDetailModel:(DetailModel *)detailModel
{
    _detailModel = detailModel;
    //头像
    [self.iconImageView setImageWithURL:[NSURL URLWithString:detailModel.iconUrl] placeholderImage:[UIImage imageNamed:@""]];
    //name
    self.namelabel.text = detailModel.name;
    
    //price
    self.priceLabel.text = [NSString stringWithFormat:@"原价:¥%@ 限时:%@",detailModel.lastPrice,detailModel.currentPrice];
    //type
    self.typeLabel.text = [NSString stringWithFormat:@"类型:%@ 星级:%@",detailModel.categoryName,detailModel.starCurrent];
    
    //detail
    self.descTextView.text = detailModel.desc;
}

//请求数据
-(void)requestData
{
    NSString *Url = [NSString stringWithFormat:kDetailUrl,self.applicationId];
    
    [self.requestManager GET:Url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
       // NSLog(@"%@",responseObject);
         
         //将字典转换成模型
         self.detailModel = [DetailModel yy_modelWithDictionary:responseObject];
         
         [self.topCollectionView reloadData];
         
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"%@",error);
    }];
}




#pragma mark collection Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.topCollectionView) {
        
        
        //跳转到大界面
        bigImageViewController *imageController = [[bigImageViewController alloc]init];
        
        //跳转时候给大图控制器传递数值
        imageController.photoArray = [self.detailModel.photos copy];
        imageController.index = indexPath.row;
        
        
        [self presentViewController:imageController animated:YES completion:nil];
        
    }else {
        
        //获取被选中的cell的模型
        AppListModel *model = self.bottomArray[indexPath.row];
        //
        DetailViewController *detail = [[DetailViewController alloc]init];
        detail.applicationId = model.applicationId;
        
        [self.navigationController pushViewController:detail animated:YES];
    }
}





-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.topCollectionView) {
        CGFloat H = collectionView.frame.size.height -20;
        CGFloat W = H;
        return CGSizeMake(W, H);
    }
    else
    {
        return CGSizeMake(67,80);
    }
}






//创建详情页界面
-(void)creatUI
{
    //设置导航栏
    [self addNavigationItemWithTitle:@"返回" isBack:YES isRight:NO target:self action:@selector(backLastView)];
    
    //注册cel
    [self.topCollectionView registerNib:[UINib nibWithNibName:@"settingCollectionView" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.bottonView registerNib:[UINib nibWithNibName:@"settingCollectionView" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
}



#pragma mark collection data

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (collectionView == self.topCollectionView)
    
    {
         return  self.detailModel.photos.count;
    }
    
    else
    {
        NSLog(@"%lu",(unsigned long)self.bottomArray.count);
        return self.bottomArray.count;
    }
   
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.topCollectionView) {
        settingCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        PhotoModel *model = self.detailModel.photos[indexPath.row];
        cell.photoModel = model;
        
        return cell;
    }
    
    
    else
    {
        
        settingCollectionView *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        
        AppListModel *model  =self.bottomArray[indexPath.row];
        
        cell2.appModel = model;
        
        return cell2;
    }
    
}


#pragma mark 定位协议的方法


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //获取位置的信息
    if (locations.count>0) {
        printf("获取定位\n");
        CLLocation *location  = locations[0];
        
        [self getNearDataWithLocation:location.coordinate];
    }
    
}
#pragma mark 请求周边数据

-(void)getNearDataWithLocation:(CLLocationCoordinate2D)coordinate
{
    [self.requestManager GET:kNearAppUrl parameters:@{@"longitude":@(coordinate.longitude),@"latitude":@(coordinate.latitude)} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        printf("成功\n");
        
        //将字典数组转化成模型数组
        
        NSArray *modelArray = [NSArray  yy_modelArrayWithClass:[AppListModel class] json:responseObject[@"applications"]];
        
        //将模型数组放入数据源数组中
        
        [self.bottomArray addObjectsFromArray:modelArray];
        
        //刷新底部的界面
        
        [self.bottonView reloadData];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        printf("失败\n");
    }];

}

//按钮点击事件

- (IBAction)share:(id)sender {
}

- (IBAction)button2:(id)sender {
}

- (IBAction)button3:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.detailModel.itunesUrl]];
}

@end
