//
//  HFStarView.m
//  Free2
//
//  Created by 千锋 on 16/6/13.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "HFStarView.h"


@interface HFStarView ()

@property(nonatomic,strong)UIImageView *backgroundView;
@property(nonatomic,strong)UIImageView *foregroundView;

@end




@implementation HFStarView

//当通过story or xib 创建时候会调用这个方法。
//在这个方法可以拿到当前的视图的frame
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self  = [super initWithCoder:aDecoder]) {
        
        
        //实例化
        
//        NSLog(@"%@",NSStringFromCGRect(self.frame));
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"StarsBackground"]];
        
        [self addSubview:self.backgroundView];
        
        
        
        
        self.foregroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"StarsForeground"]];
        [self addSubview:self.foregroundView];
        
        
        //设置前部图片剪切显示
        [self.foregroundView setContentMode:UIViewContentModeLeft];
        
        self.foregroundView.clipsToBounds = YES;
        
    }
    return self;
}

//从外部给star赋值，算出长度
-(void)setStartValue:(NSString *)startValue
{
    //设置图片显示的大小、
    CGRect rect = self.backgroundView.frame;
    CGFloat realW= rect.size.width*(startValue.floatValue/5.0f);
    
    self.foregroundView.frame = CGRectMake(rect.origin.x, rect.origin.y
                                           , realW, rect.size.height);
    
}


@end
