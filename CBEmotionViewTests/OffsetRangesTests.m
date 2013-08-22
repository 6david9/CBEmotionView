//
//  OffsetRangesTests.m
//  CBEmotionView
//
//  Created by ly on 8/21/13.
//  Copyright (c) 2013 ly. All rights reserved.
//

#import "OffsetRangesTests.h"
#import "NSArray+CBExtension.h"

@implementation OffsetRangesTests

- (void)testNoThrowsWhenArrayIsEmpty
{
    NSArray *emptyArray = [NSArray array];
    
    STAssertNoThrow([emptyArray offsetRangesInArrayBy:1],
                    @"对空数组做偏移不抛异常");
}

- (void)testReturnEmptyArrayWhenReciverIsEmptyArray
{
    NSArray *empty = [NSArray array];
    NSArray *result = [empty offsetRangesInArrayBy:1];
    
    STAssertTrue([result count] == 0, @"对空数组做偏移返回空数组");
}

- (void)testOffsetOneRangeInArray
{
    NSArray *singleArray = @[ [NSValue valueWithRange:NSMakeRange(1, 5)] ];
    NSArray *result = [singleArray offsetRangesInArrayBy:1];
    
    NSRange range = [[result objectAtIndex:0] rangeValue];
    STAssertTrue(range.location == 1, @"range.location == 1");
    STAssertTrue(range.length == 1, @"range.length == 1");
}

- (void)testOffsetMultiRangesInArray
{
    NSValue *rangeValue1 = [NSValue valueWithRange:NSMakeRange(1, 3)];
    NSValue *rangeValue2 = [NSValue valueWithRange:NSMakeRange(5, 5)];
    NSArray *singleArray = @[ rangeValue1, rangeValue2 ];
    NSArray *result = [singleArray offsetRangesInArrayBy:1];
    
    NSRange range1 = [[result objectAtIndex:0] rangeValue];
    STAssertTrue(range1.location == 1, @"range1.location == 1 移动后location不变");
    STAssertTrue(range1.length == 1, @"range1.length == 1");
    
    NSRange range2 = [[result objectAtIndex:1] rangeValue];
    STAssertTrue(range2.location == 3, @"range2.location == 3");
    STAssertTrue(range2.length == 1, @"range2.length == 1");
}

@end
