//
//  ViewController.m
//  ZYJDraw
//
//  Created by zhang on 15/5/27.
//  Copyright (c) 2015年 zhang. All rights reserved.
//  view

#import "ViewController.h"
#import "ZYJView.h"
#import "UIImage+ZYJ.h"

@interface ViewController ()<ZYJViewDelegate>

@end

@implementation ViewController
{
    ZYJView *zyjV;
    UIImageView *colorBgImageView;
    UIImageView *colorPenImageView;
    UIColor *getColor;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    zyjV = [[ZYJView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    zyjV.delegate = self;
    [self.view addSubview:zyjV];
    
    UIImage *colorIamge = [UIImage imageNamed:@"colorWheel"];
    CGFloat colorIamgeW = colorIamge.size.width;
    CGFloat colorIamgeH = colorIamge.size.height;
    
    colorBgImageView = [[UIImageView alloc] init];
    colorBgImageView.image = colorIamge;
    colorBgImageView.frame = CGRectMake(marginLift, marginBottom * 2.0 + btnH, colorIamgeW, colorIamgeH);
    [zyjV addSubview:colorBgImageView];
    colorBgImageView.hidden = YES;
    
    colorPenImageView = [[UIImageView alloc] init];
    colorPenImageView.image = colorIamge;
    colorPenImageView.frame = CGRectMake(screenW - marginLift - colorIamgeW, marginBottom * 2.0 + btnH, colorIamgeW, colorIamgeH);
    [zyjV addSubview:colorPenImageView];
    colorPenImageView.hidden = YES;
}

- (void)bgBtnClick:(UIButton *)button
{
    if (!colorPenImageView.hidden) {
        colorPenImageView.hidden = YES;
    }
    if (colorBgImageView.hidden) {
        colorBgImageView.hidden = NO;
    }
}
- (void)penBtnClick:(UIButton *)button
{
    if (!colorBgImageView.hidden) {
        
        colorBgImageView.hidden = YES;
    }
    if (colorPenImageView.hidden) {
        colorPenImageView.hidden = NO;
    }
}
- (void)touchesEnded:(NSSet *)touches
{
    // 获得触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    UIImage *img = [utily captureScreen];
    getColor = [img pixelColorAtLocation:point];
    
    // 获得颜色
    if (!colorBgImageView.hidden) {
        colorBgImageView.hidden = YES;
        [zyjV.ziArry removeAllObjects];
        [zyjV.bgBtn setTitleColor:getColor forState:UIControlStateNormal];
        zyjV.backgroundColor = getColor;
    }
    if (!colorPenImageView.hidden) {
        colorPenImageView.hidden = YES;
        zyjV.font = 5;
        zyjV.penBtn.backgroundColor = getColor;
        zyjV.color = getColor;
    }
}
@end
