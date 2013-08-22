//
//  UIImage+CBExtension.m
//  CBExtension
//
//  Created by ly on 13-7-7.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#import "UIImage+CBExtension.h"

@implementation UIImage (CBExtension)

- (id)stretchableImage
{
    NSInteger leftCap = (NSInteger)(self.size.width/2);
    NSInteger topCap = (NSInteger)(self.size.height/2);
    return [self stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

@end
