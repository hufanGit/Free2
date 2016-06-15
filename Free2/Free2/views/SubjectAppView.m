//
//  SubjectAppView.m
//  Free2
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "SubjectAppView.h"
#import "HFStarView.h"
#import "SubjectModel.h"

@interface SubjectAppView ()

//头像
@property(nonatomic,strong)UIImageView *iconImageView;

//名字
@property(nonatomic,strong)UILabel *nameLabel;

//评论
@property(nonatomic,strong)UILabel *commentLabel;

//下载
@property(nonatomic,strong)UILabel *downloadLabel;

//星级
@property(nonatomic,strong)HFStarView *starView;


@end

@implementation SubjectAppView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self creatSubView];
    }
    return self;
}

-(void)layoutSubviews
{
    [self calculateFrame];
}




#pragma mark 给子视图的属性辅助!!!!!

-(void)setAppmodel:(SubjectModelAppModel *)appmodel

{
    _appmodel = appmodel;
    
    [_iconImageView setImageWithURL:[NSURL URLWithString:appmodel.iconUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    _nameLabel.text =appmodel.name;
    
   
    _commentLabel.attributedText = [self mixImage:[UIImage imageNamed:@"topic_Comment"] text:[NSString stringWithFormat:@" %@",appmodel.ratingOverall]];
    
    //_downloadLabel.text = appmodel.downloads;
    _downloadLabel.attributedText = [self mixImage:[UIImage imageNamed:@"topic_Download"] text:[NSString stringWithFormat:@" %@",appmodel.downloads]];
    
    _starView.startValue = appmodel.starOverall;
}


-(void)creatSubView
{
    
    
    //实例化子视图
    
    //头像
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:_iconImageView];
    
    //名字
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
   
    [self addSubview:_nameLabel];
    
    //评论
    _commentLabel = [UILabel new];
    _commentLabel.translatesAutoresizingMaskIntoConstraints = NO;
   

    [self addSubview:_commentLabel];
    
    //下载
    _downloadLabel = [UILabel new];
    _downloadLabel.translatesAutoresizingMaskIntoConstraints = NO;
   
    [self addSubview:_downloadLabel];
    
    //星级
    _starView = [HFStarView new];
    _starView.translatesAutoresizingMaskIntoConstraints = NO;
   
    [self addSubview:_starView];
    
}

#pragma mark 图文混合
-(NSAttributedString *)mixImage:(UIImage *)image text:(NSString *)text
{
    //将图片转化成文本附件
    
    NSTextAttachment *imageMent = [NSTextAttachment new];
    imageMent.image = image;
    //将文本图片转换成富文本
    NSAttributedString *imageAttri = [NSAttributedString attributedStringWithAttachment:imageMent];
    
    //将文字
    NSAttributedString *textatt = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    NSMutableAttributedString *mix  = [NSMutableAttributedString new];
    
    [mix appendAttributedString:imageAttri];
    
    [mix appendAttributedString:textatt];
    
    return mix;
}


#pragma mark 计算子视图的frame

-(void)calculateFrame
{
    __weak typeof(self) weakself = self;
    //头像
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置上下边距
        
        make.left.equalTo(weakself.mas_left);
        make.top.equalTo (weakself.mas_top);
        
        make.bottom.equalTo(weakself.mas_bottom);
        //宽高相等
        make.width.equalTo(_iconImageView.mas_height);
        
    }];
    
    //名字
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //设置左上右边的间距、
        make.left.equalTo(_iconImageView.mas_right).offset(5);
        
        make.top.equalTo (weakself.mas_top);
        
        make.right.equalTo(weakself.mas_right);
        
        //高度为当前视图高度的1/3
        make.height .equalTo(weakself.mas_height).multipliedBy(1/3.0f);
        
    }];
    
    //评论
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        //设置左边距
        make.left.equalTo(_iconImageView.mas_right).offset(8);
        //设置高度。
        
        make.height.equalTo(_nameLabel.mas_height);
        
        //设置 中心对齐于头像的图片。
        make.centerY.equalTo(_iconImageView.mas_centerY);
        
        //label 的宽度
        CGFloat commentW = self.frame.size.width/3.0f;
        
        //设置label 的宽度。
        //传入对象
        make.width.equalTo(@(commentW));
        
        
    }];
    //下载
    [_downloadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_commentLabel.mas_right).offset(8);
        
        make.centerY.equalTo(_iconImageView.mas_centerY);
        
        make.height.equalTo(_commentLabel);
        
        make.width.equalTo(_commentLabel);
        
    }];
    
    //星级
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_iconImageView.mas_right).offset(5);
        
        make.height.equalTo(_nameLabel);
        
        make.right.equalTo(weakself.mas_right).offset(-5);
        
        make.bottom.equalTo(_iconImageView);
        
    }];
}

@end
