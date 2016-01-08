//
//  ViewController.m
//  手势解锁
//
//  Created by 章芝源 on 16/1/8.
//  Copyright © 2016年 ZZY. All rights reserved.
//

#import "ViewController.h"
// 自动装箱,把基本类型的数据转换成对象
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

//预编译可以不写前缀msa_
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

#import <Masonry.h>
@interface ViewController ()

@end

@implementation ViewController

//替换控制器view
- (void)loadView
{
    ZYBGView *bjView = [[ZYBGView alloc]init];
//    bjView.frame = self.view.bounds;  //不能这么写, 这个时候self.view还没有没创建,  可以使用set方法, 但是不能使用get方法, 不然会死循环
    bjView.frame = [UIScreen mainScreen].bounds;
    self.view = bjView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI
    [self setupUI];
}

- (void)setupUI
{
    ZYUnlockView *unlockView = [[ZYUnlockView alloc]init];
    unlockView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:unlockView];
    [unlockView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.right.left.equalTo(self.view).offset(0);
        make.height.equalTo(300);
    }];
    
}

@end
