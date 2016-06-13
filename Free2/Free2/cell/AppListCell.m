//
//  AppListCell.m
//  Free2
//
//  Created by 千锋 on 16/6/13.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "AppListCell.h"
#import <UIImageView+AFNetworking.h>
#import "AppListModel.h"
#import "HFStarView.h"

@interface AppListCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *datelabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@property (weak, nonatomic) IBOutlet HFStarView *StarView;


@end

@implementation AppListCell


//使用story 或者xib,界面要显示的时候会自动调用。
- (void)awakeFromNib {
    
    
    //切圆角
    
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius=10;
    
    
    //使用自己的字体
    self.nameLabel.font = [UIFont fontWithName:@"汉仪篆书繁" size:14];
    //self.nameLabel.font = [UIFont fontWithName:@"HYZhuanShuF" size:17];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//把模型传给cell ,执行
-(void)setModel:(AppListModel *)model
{
    _model = model;
    
    //af库里面的方法。
    [self.iconImageView setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    //name
    self.nameLabel.text = model.name;
    
    //date
    self.datelabel.text = model.releaseDate;
    
    //price
    self.priceLabel.text = model.lastPrice;
    
    
    
    //参数二是线条的类型。Point
    NSAttributedString *attri = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",model.lastPrice] attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:[UIColor redColor]}];
    
    self.priceLabel.attributedText = attri;
    
    
    //类型
    self.typeLabel.text = model.categoryName;
    
    //数量
    self.countLabel.text = [NSString stringWithFormat:@"分享:%@ 收藏:%@ 下载:%@",model.shares,model.favorites,model.downloads];
    
    
    self.StarView.startValue =model.starCurrent;
    
   // printf("%s\n",model.lastPrice.UTF8String);
    
}


@end
