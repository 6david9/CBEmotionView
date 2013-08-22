//
//  UIImageView+CBExtension.h
//  CBExtension
//
//  Created by ly on 8/8/13.
//  Copyright (c) 2013 Lei Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CBExtension)

+ (id)imageViewWithURL:(NSURL *)url cornerRadius:(CGFloat)radius
           borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
