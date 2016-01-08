//
//  ZYUnlockView.m
//  手势解锁
//
//  Created by 章芝源 on 16/1/8.
//  Copyright © 2016年 ZZY. All rights reserved.
//

#import "ZYUnlockView.h"
@interface ZYUnlockView()
//按钮数组, 用于记录我们选中的按钮s
@property(nonatomic, strong)NSMutableArray *arrayBtns;
///记录手指在屏幕上的位置
@property(nonatomic, assign)CGPoint point;
@end
@implementation ZYUnlockView

//绑定tag
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i < 9 ; i++ ) {
            UIButton *button = [[UIButton alloc]init];
            [button setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
            button.tag = i;
            button.userInteractionEnabled = NO;
            button.selected = NO;
            //按钮被点击了那么就让按钮一直都出去, 被点击状态
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)btnClick:(UIButton *)button
{
    button.selected = YES;
}

///在自定义控件中对子控件进行布局,  必须使用layoutSubViews进行,  这个方法中, 父控件已经开始布局完成,  可以开始布局子控件
- (void)layoutSubviews
{
    NSUInteger count = self.subviews.count;
    CGFloat buttonH = 74;
    CGFloat buttonW = 74;
    NSInteger totalCols = 3;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat margin = (self.bounds.size.width - totalCols * buttonW) / (totalCols + 1);
    //列
    int row = 0;
    //行
    int col = 0;
    for (int i = 0; i < count ; i++ ) {
        UIButton *button = self.subviews[i];
        col = i / totalCols;
        row = i % totalCols;
        buttonX = margin + row * (buttonW + margin);
        buttonY = col * (buttonH + margin);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }

}

///点中第一个
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //得到点击点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    //记录
    self.point = point;
    //判断点击点在哪个按钮上
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, point)) {
            if (button.selected == NO) {
                button.selected = YES;
                //把选中的按钮添加到数组记录
                [self.arrayBtns addObject:button];
            }
        }
    }
    //重绘
    [self setNeedsDisplay];
}

#pragma mark - 绘制

- (void)drawRect:(CGRect)rect {
    //1. 用户没有选中按钮
    //防止用户在界面除了按钮的其他地方拖拽的时候,  调用这个方法
    if (self.arrayBtns.count == 0)return;

    UIBezierPath *path = [UIBezierPath bezierPath];
    //判断第一个按钮
    for (int i = 0; i < self.arrayBtns.count ; i++ ) {
        UIButton *button = self.arrayBtns[i];
        if (i == 0) {
            CGPoint point = button.center;
            [path moveToPoint:point];
        }else{
            [path addLineToPoint:button.center];
        }
    }
    
    //添加一条线到手指移动的地方
    [path addLineToPoint:self.point];
    [[UIColor greenColor]set];
    [path setLineWidth:5];
    [path stroke];

}

///当用户松手的时候
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1. 用户没有选中按钮
    if (self.arrayBtns.count == 0)return;
    NSMutableString *stringM = [[NSMutableString alloc]init];
    //2. 将每个按钮设置成, 未选中
    for (UIButton *button in self.arrayBtns) {
        [stringM appendFormat:@"%ld", button.tag];
        button.selected = NO;
    }
     NSLog(@"%@", stringM);
    //3. 清空按钮数组
    [self.arrayBtns removeAllObjects];
    
    //4. 重绘
    [self setNeedsDisplay];
}

#pragma mark - 懒加载
- (NSMutableArray *)arrayBtns
{
    if (!_arrayBtns) {
        _arrayBtns = [[NSMutableArray alloc]init];
    }
    return _arrayBtns;
}




@end
