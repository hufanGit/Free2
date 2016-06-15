//
//  bigImageViewController.m
//  Free2
//
//  Created by 千锋 on 16/6/15.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "bigImageViewController.h"
#import "settingCollectionView.h"


@interface bigImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (weak, nonatomic) IBOutlet UICollectionView *BigcollectionView;

@property (weak, nonatomic) IBOutlet UILabel *pageSIzeLabel;



@end

@implementation bigImageViewController

-(void)viewDidAppear:(BOOL)animated
{
    self.BigcollectionView.contentOffset = CGPointMake(self.index *_BigcollectionView.frame.size.width, 0);
    
    //设置显示的位置
    _pageSIzeLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.index + 1,self.photoArray.count];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.BigcollectionView registerNib:[UINib nibWithNibName:@"settingCollectionView" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    //添加手势
    [self addTap];

}
#pragma mark 添加手势
-(void)addTap
{
    //创建手势
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    //将手势添加到collection上
    [self.BigcollectionView addGestureRecognizer:Tap];
}

//当执行手势的时候调用的方法
-(void)tap:(UITapGestureRecognizer *)tap
{
    printf("添加手势\n");
    if (self.topViewConstraint.constant == 0) {
        [UIView animateWithDuration:0.3 animations:^{
           
            self.topViewConstraint.constant = -70;
            self.bottomConstraint.constant =-60;
            
            //更改约束的时候必须调用的方法。
            [self.view layoutIfNeeded];
        }];
        [UIApplication sharedApplication].statusBarHidden = YES;
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.topViewConstraint.constant = 0;
            self.bottomConstraint.constant =0;
            
            //更改约束的时候必须调用的方法。
            [self.view layoutIfNeeded];
        }];
        [UIApplication sharedApplication].statusBarHidden = NO;
    }
}

//拿到当前滑动的偏移
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat Offset = scrollView.contentOffset.x;
    
    int page = (int)(Offset/scrollView.frame.size.width);
    
    self.pageSIzeLabel.text = [NSString stringWithFormat:@"%d/%ld",page+1,self.photoArray.count];
}




#pragma mark   collectionView的代理方法。

//设置位置
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat margin = (collectionView.frame.size.height - 300)/2.0f;
    return UIEdgeInsetsMake(margin, 0, margin, 0);
}


//设置cell 的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
}

//设置cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    settingCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.photoModel = self.photoArray[indexPath.row];
    
    return cell;
}

//计算cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat W = collectionView.frame.size.width;
    
    //CGFloat H =300;
    CGFloat H = collectionView.frame.size.height;
    
    return CGSizeMake(W, H);
}


- (IBAction)backButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)saveButton:(UIButton *)sender {
}

@end
