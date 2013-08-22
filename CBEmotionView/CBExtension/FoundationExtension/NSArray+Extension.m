//
//  NSArray+Extension.m
//  CBExtension
//
//  Created by ly on 13-6-29.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (NSString *)composeString
{
    if ([self count] == 0)
        return @"";
    
    NSMutableString *str = [[NSMutableString alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([str isKindOfClass:[NSString class]]) {
            [str appendString:obj];
        } else {
            [str appendString:[obj description]];
        }
    }];
    return str;
}

- (id)firstObject
{
    return [self objectAtIndex:0];
}

@end
