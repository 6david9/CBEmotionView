//
//  NSArray+CBExtension.m
//  CBEmotionView
//
//  Created by ly on 8/21/13.
//  Copyright (c) 2013 ly. All rights reserved.
//

#import "NSArray+CBExtension.h"

@implementation NSArray (CBExtension)

- (NSArray *)offsetRangesInArrayBy:(NSUInteger)offset
{
    NSUInteger aOffset = 0;
    NSUInteger prevLength = 0;
    
    
    NSMutableArray *ranges = [[NSMutableArray alloc] initWithCapacity:[self count]];
    for(NSInteger i = 0; i < [self count]; i++)
    {
        @autoreleasepool {
            NSRange range = [[self objectAtIndex:i] rangeValue];
            prevLength    = range.length;
            
            range.location -= aOffset;
            range.length    = offset;
            [ranges addObject:[NSValue valueWithRange:range]];
            
            aOffset = aOffset + prevLength - offset;
        }
    }
    
    return ranges;
}

@end
