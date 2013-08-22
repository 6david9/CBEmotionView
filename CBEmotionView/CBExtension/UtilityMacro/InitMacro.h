//
//  InitMacro.h
//  CBExtension
//
//  Created by ly on 13-7-3.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#ifndef CBExtension_InitMacro_h
#define CBExtension_InitMacro_h

#define INIT_BEGIN   \
    self = [super init];\
    if (self) {

#define INIT_END     \
    }\
    return self;

#define INIT_WITH_FRAME_BEGIN(frame)    \
    self = [super initWithFrame:frame];\
    if (self) {
    
#define INIT_WITH_FRAME_END    INIT_END

#endif
