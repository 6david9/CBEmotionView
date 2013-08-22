//
//  ColorMacro.h
//  CBExtension
//
//  Created by  ly on 13-5-28.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#ifndef ColorMacro_h
#define ColorMacro_h

#ifdef RGBAlphaColor
#undef RGBAlphaColor
#endif

#ifdef OpaqueRGBColor
#undef OpaqueRGBColor
#endif

#define RGBAlphaColor(r, g, b, a) \
            [UIColor colorWithRed:(r/255.0)\
                            green:(g/255.0)\
                             blue:(b/255.0)\
                            alpha:(a)]

#define OpaqueRGBColor(r, g, b) RGBAlphaColor((r), (g), (b), 1.0)


#define RedColor    [UIColor redColor]
#define GreenColor  [UIColor greenColor]
#define BlackColor  [UIColor blackColor]
#define ClearColor  [UIColor clearColor]


#endif
