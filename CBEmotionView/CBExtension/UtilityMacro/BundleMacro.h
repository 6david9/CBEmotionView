//
//  BundleMacro.h
//  CBExtension
//
//  Created by  ly on 13-6-14.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#ifndef BundleMacro_h
#define BundleMacro_h

#define PathForPNGResource(name)    [[NSBundle mainBundle] pathForResource:(name) ofType:@"png"]
#define PathForXMLResource(name)    [[NSBundle mainBundle] pathForResource:(name) ofType:@"xml"]

#define PathForResourceOfType(res, type)    [[NSBundle mainBundle] pathForResource:(res) ofType:(type)]

#endif
