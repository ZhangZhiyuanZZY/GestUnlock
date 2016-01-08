//
//  ZYBGView.m
//  手势解锁
//
//  Created by 章芝源 on 16/1/8.
//  Copyright © 2016年 ZZY. All rights reserved.
//

#import "ZYBGView.h"

@implementation ZYBGView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"Home_refresh_bg"];
    [image drawInRect:rect];
}


@end
