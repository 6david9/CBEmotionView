//
//  UIView+CBExtension.m
//  CBExtension
//
//  Created by ly on 13-7-14.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#import "UIView+CBExtension.h"
#import <QuartzCore/QuartzCore.h>
#import "UtilityMacro.h"
#import "FoundationExtension.h"

@implementation UIView (CBExtension)

- (UIImage *)screenImageWithRect:(CGRect)rect
{
    CGFloat scale = ScreenScale();
    UIImage *screenshot = [self screenImage];
    rect = CGRectMakeScale(rect, scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([screenshot CGImage], rect);
    UIImage *croppedScreenshot = [UIImage imageWithCGImage:imageRef
                                                     scale:screenshot.scale
                                               orientation:screenshot.imageOrientation];
    CGImageRelease(imageRef);
    
    UIImageOrientation imageOrientation = [self imageOrientationWithScreenOrientation];
    return [[UIImage alloc] initWithCGImage:croppedScreenshot.CGImage
                                      scale:croppedScreenshot.scale
                                orientation:imageOrientation];
}

- (UIImage *)screenImage
{
    CGSize  layerSize = self.layer.frame.size;
    CGFloat scale     = ScreenScale();
    CGFloat opaque    = NO;
    UIGraphicsBeginImageContextWithOptions(layerSize, opaque, scale);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return screenshot;
}

- (UIImageOrientation)imageOrientationWithScreenOrientation
{
    UIInterfaceOrientation orientation = StatusBarOrientation();
    UIImageOrientation imageOrientation = UIImageOrientationUp;
    
    switch (orientation)
    {
        case UIDeviceOrientationPortraitUpsideDown:
            imageOrientation = UIImageOrientationDown;
            break;
        case UIDeviceOrientationLandscapeRight:
            imageOrientation = UIImageOrientationRight;
            break;
        case UIDeviceOrientationLandscapeLeft:
            imageOrientation = UIImageOrientationLeft;
            break;
        default:
            break;
    }
    return imageOrientation;
}

@end
