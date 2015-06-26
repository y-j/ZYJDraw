//
//  utily.m
//  ZYJDraw
//
//  Created by 陈令令 on 15/6/26.
//  Copyright (c) 2015年 zhang. All rights reserved.
//

#import "utily.h"

@implementation utily
+ (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
