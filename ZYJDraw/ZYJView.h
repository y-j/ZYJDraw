//
//  ZYJView.h
//  ZYJDraw
//
//  Created by zhang on 15/5/28.
//  Copyright (c) 2015年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utily.h"
#define RGBCOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define screenW [[UIScreen mainScreen] bounds].size.width
#define screenH [[UIScreen mainScreen] bounds].size.height
#define marginLift screenW/8.0
#define marginBottom 35
#define btnH 45

@protocol ZYJViewDelegate <NSObject>

@required
- (void)bgBtnClick:(UIButton *)button;
- (void)penBtnClick:(UIButton *)button;
-(void)touchesEnded:(NSSet *)touches;
@end

@interface ZYJView : UIView
{
    
    CGContextRef contex;
    
    UIButton *cancleBtn;
    UIButton *rubberBtn;
    
}
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, weak) id<ZYJViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *ziArry;
@property (nonatomic, assign) int font;
@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UIButton *penBtn;
@end
