//
//  FreeViewController.m
//  Free2
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "FreeViewController.h"

@interface FreeViewController ()

@end

@implementation FreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)init
{
    if (self = [super init]) {
        //在创建时候给一个请求地址、
        self.requestURL = kFreeUrl;
    }
    return self;
}

@end
