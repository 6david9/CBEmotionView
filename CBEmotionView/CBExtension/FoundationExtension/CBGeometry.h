//
//  CBGeometry.h
//  CBExtension
//
//  Created by ly on 13-7-14.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#ifndef CBExtension_CBGeometry_h
#define CBExtension_CBGeometry_h

/*** 返回被放大 scale 倍后的 rect
 * @discussion 错误返回 CGRectZero
 */
CG_INLINE
CGRect CGRectMakeScale(CGRect rect, CGFloat scale)
{
    if (scale < 0.00001)
        return CGRectZero;
    
    return CGRectMake(rect.origin.x * scale, rect.origin.y * scale ,
                      rect.size.width * scale, rect.size.height * scale);
}

/*** 返回顶点为 (0,0)， 大小与frame.size 相同的矩形*/
CG_INLINE
CGRect CGRectMakeFull(CGRect frame)
{
    return CGRectMake(0, 0, frame.size.width, frame.size.height);
}

/*** 返回在 r 中大小为 size，居中的矩形大小 */
CG_INLINE
CGRect CGRectCenterRectWithSize(CGRect r, CGSize size)
{
    CGRect newRect;
    newRect.origin.x = (CGRectGetWidth(r)-size.width)/2.0;
    newRect.origin.y = (CGRectGetHeight(r)-size.height)/2.0;
    newRect.size = size;
    return newRect;
}

#endif
