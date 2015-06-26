//
//  ZYJView.m
//  ZYJDraw
//
//  Created by zhang on 15/5/28.
//  Copyright (c) 2015年 zhang. All rights reserved.
//

#import "ZYJView.h"

@implementation ZYJView


- (void)cornerRadiusClip:(UIButton *)button
{
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
}
-(id)initWithFrame:(CGRect)frame
{
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        _color=[UIColor redColor];
        //初始化字arry
        _ziArry=[NSMutableArray array];
        _font=5;
        
        _bgBtn = [[UIButton alloc] initWithFrame:CGRectMake(marginLift, marginBottom, (screenW - marginLift)/4.0, btnH)];
        [_bgBtn setBackgroundColor:RGBCOLOR(35, 160, 255, 1.0)];
        [_bgBtn setTitle:@"背景颜色" forState:UIControlStateNormal];
        [_bgBtn addTarget:self action:@selector(bgBtn:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_bgBtn];
        
        _penBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenW/2.0 + marginLift, marginBottom, (screenW - marginLift)/4.0, btnH)];
        [_penBtn setTitle:@"画笔颜色" forState:UIControlStateNormal];
        [_penBtn setBackgroundColor:RGBCOLOR(35, 160, 255, 1.0)];
        [_penBtn addTarget:self action:@selector(penBtn:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_penBtn];

        
                
        cancleBtn=[[UIButton alloc]initWithFrame:CGRectMake(marginLift, screenH - marginBottom - btnH, (screenW - marginLift)/4.0, btnH)];
        [cancleBtn setBackgroundColor:RGBCOLOR(35, 30, 40, 1.0)];
        [cancleBtn setTitle:@"撤销" forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchDown];
        [self addSubview:cancleBtn];
        
        rubberBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenW/2.0 + marginLift, screenH - marginBottom - btnH, (screenW - marginLift)/4.0, btnH)];
        [rubberBtn setTitle:@"橡皮" forState:UIControlStateNormal];
        [rubberBtn setBackgroundColor:RGBCOLOR(35, 30, 40, 1.0)];
        [rubberBtn addTarget:self action:@selector(Rubber) forControlEvents:UIControlEventTouchDown];
        [self addSubview:rubberBtn];
        
        [self cornerRadiusClip:_bgBtn];
        [self cornerRadiusClip:_penBtn];
        [self cornerRadiusClip:cancleBtn];
        [self cornerRadiusClip:rubberBtn];
        
    }
    
    return self;
}
- (void)bgBtn:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(bgBtnClick:)]) {
        [self.delegate bgBtnClick:button];
    }
}
- (void)penBtn:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(penBtnClick:)]) {
        [self.delegate penBtnClick:button];
    }
}
-(void)Rubber
{
    _color=self.backgroundColor;
    _font=20;
}
-(void)cancel
{
    [_ziArry removeObject:[_ziArry lastObject]];
    [self setNeedsDisplay];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //创建笔画的数组
    NSMutableArray *arry=[[NSMutableArray alloc]init];
    //将颜色添加到笔画数组中
    [arry addObject:_color];
    [arry addObject:[NSNumber numberWithInt:_font]];
    //得到触摸对象
    UITouch *touch=[touches anyObject];
    //将触摸对象装化为触摸点
    CGPoint point=[touch locationInView:self];
    //将point转换为对象类型
    NSValue *pointValue=[NSValue valueWithCGPoint:point];
    //将得到的起点添加到数组里面
    [arry addObject:pointValue];
    //将笔画数组放在子数组里面
    [_ziArry addObject:arry];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    //得到触摸对象
    UITouch *touch=[touches anyObject];
    //将触摸对象装化为触摸点
    CGPoint point=[touch locationInView:self];
    //将point转换为对象类型
    NSValue *pointValue=[NSValue valueWithCGPoint:point];
    //通过ziarry取到笔画数组
    NSMutableArray *bihuaArry=[_ziArry lastObject];
    //将对象point添加到笔画数组
    [bihuaArry addObject:pointValue];
    //视图重绘，不是准备工作，而是子绘画中使用
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    if ([self.delegate respondsToSelector:@selector(touchesEnded:)]) {
        [self.delegate touchesEnded:touches];
    }
}
- (void)drawRect:(CGRect)rect
{
    //循环一个字有多少笔画
    for (int i=0; i<[_ziArry count]; i++) {
        NSMutableArray *bihua=[_ziArry objectAtIndex:i];
        //设置绘画属性、
        //拿到画笔
        contex=UIGraphicsGetCurrentContext();
        //设置画笔的粗细
        CGContextSetLineWidth(contex, [bihua[1] intValue]);
        //设置画笔的颜色
        CGContextSetStrokeColorWithColor(contex, [bihua[0] CGColor]);
        //内层循环是用来处理每个笔画有多少个点
        for (int j=2; j<[bihua count]-2; j++) {
            //将点连成线
            //将对象类型的点从数组中取出来
            NSValue *pointValue=[bihua objectAtIndex:j];
            //将对象类型转换成point
            CGPoint first=[pointValue CGPointValue];
            //两点画线，取到后面的一个点
            CGPoint second=[[bihua objectAtIndex:j+1] CGPointValue];
            //设定线的起点和终点
            CGContextMoveToPoint(contex, first.x, first.y);
            //用点连接成线
            CGContextAddLineToPoint(contex, second.x, second.y);
            //提交画笔
            CGContextStrokePath(contex);
        }
    }
    
}



@end
