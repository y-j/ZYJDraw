//
//  ZYJView.h
//  ZYJDraw
//
//  Created by zhang on 15/5/28.
//  Copyright (c) 2015年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

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
