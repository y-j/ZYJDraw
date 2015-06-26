

#import <UIKit/UIKit.h>

@interface UIImage (ZYJ)
/**
 *  获得某个像素的颜色
 *
 *  @param point 像素点的位置
 */
- (UIColor *)pixelColorAtLocation:(CGPoint)point;
- (UIImage *)cropToRect:(CGRect)rect;
@end
