//
//  NSMutableSet+CBExtension.m
//  CBExtension
//
//  Created by ly on 13-7-31.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#import "NSMutableSet+CBExtension.h"

@implementation NSMutableSet (CBExtension)

- (void)removeObjectsInArray:(NSArray *)array
{
    for (id obj in array)
    {
        [self removeObject:obj];
    }
}

@end
