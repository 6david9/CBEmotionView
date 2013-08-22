//
//  UIView+CBExtension.h
//  CBExtension
//
//  Created by ly on 13-7-14.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CBExtension)

/*** 返回包含 view 的 image */
- (UIImage *)screenImage;

/*** 返回包含 view 中 rect 部分的 image */
- (UIImage *)screenImageWithRect:(CGRect)rect;

/*** 根据屏幕方向，返回合适的图片方向 */
- (UIImageOrientation)imageOrientationWithScreenOrientation;

@end
