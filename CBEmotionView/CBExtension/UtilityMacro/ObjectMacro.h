//
//  ObjectMacro.h
//  CBExtension
//
//  Created by ly on 13-7-14.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#ifndef CBExtension_ObjectMacro_h
#define CBExtension_ObjectMacro_h


#define SafelyReleaseTimer(t)  ([t invalidate], t = nil)


#if __has_feature(objc_arc)
    #define SafelyRelease(obj)     obj = nil
    #define SafelyRetain(obj)      
#else
    #define SafelyRelease(obj)     ([obj release], obj = nil)
    #define SafelyRetain(obj)      [obj retain]
#endif


#endif
