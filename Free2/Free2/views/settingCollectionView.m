//
//  settingCollectionView.m
//  Free2
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "settingCollectionView.h"
#import "setModel.h"

@interface settingCollectionView()

@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@end


@implementation settingCollectionView

-(void)setModel:(setModel *)model
{
    _model = model;
    
    self.nameLabel.text = model.name;
    
    self.smallImageView .image = [UIImage imageNamed:model.image];
}

#pragma mark 
-(void)setPhotoModel:(PhotoModel *)photoModel
{
    
    //在一个视图上添加两个关联的类
    _photoModel = photoModel;
    
    self.smallImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    
    
    [self.bigImageView setImageWithURL:[NSURL URLWithString:photoModel.smallUrl] placeholderImage:nil];
}

#pragma mark 通过applistmodel 设置

-(void)setAppModel:(AppListModel *)appModel
{
    _appModel = appModel;
    self.bigImageView .hidden = YES;
    [self.smallImageView  setImageWithURL:[NSURL URLWithString:appModel.iconUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    self.nameLabel.text = appModel.name;
}

@end
