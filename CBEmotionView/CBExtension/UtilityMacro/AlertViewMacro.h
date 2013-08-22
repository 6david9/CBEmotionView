//
//  AlertViewMacro.h
//  CBExtension
//
//  Created by ly on 13-6-29.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#ifndef HuXiu_AlertViewMacro_h
#define HuXiu_AlertViewMacro_h

#define ShowAlerViewWithMessage(msg) \
    [[[UIAlertView alloc] initWithTitle:nil message:(msg) delegate:nil \
        cancelButtonTitle:NSLocalizedString(@"好", @"OK") otherButtonTitles:nil] show];

#endif
