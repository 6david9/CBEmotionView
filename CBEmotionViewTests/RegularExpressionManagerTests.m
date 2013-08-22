//
//  RegularExpressionManagerTests.m
//  CBEmotionView
//
//  Created by ly on 8/21/13.
//  Copyright (c) 2013 ly. All rights reserved.
//

#import "RegularExpressionManagerTests.h"
#import "CBRegularExpressionManager.h"

@implementation RegularExpressionManagerTests

- (void)testThrowsWhenInputNilForPattern
{
    STAssertThrows([CBRegularExpressionManager itemIndexesWithPattern:nil inString:@""],
      @"itemIndexesWithPattern:inString:参数 pattern不能为nil");
}

- (void)testThrowsWhenInputNilForFindingString
{
    STAssertThrows([CBRegularExpressionManager itemIndexesWithPattern:@"" inString:nil],
       @"itemIndexesWithPattern:inString:参数 findingString不能为nil");
}

- (void)testNoThrowsWhenArgumentsNotNil
{
    STAssertNoThrow([CBRegularExpressionManager itemIndexesWithPattern:@"" inString:@""],
        @"itemIndexesWithPattern:inString:参数不为nil时，不应该抛异常");
}

- (void)testReturnEmptyArrayWhenNotFound
{
    NSArray *result = [CBRegularExpressionManager itemIndexesWithPattern:@"asdf" inString:@""];
    STAssertTrue([result count] == 0, @"找不到结果时应该返回空数组");
}

- (void)testShouldReturnTwoItemsWhenFoundTwoMatching
{
    NSArray *result = [CBRegularExpressionManager itemIndexesWithPattern:@"</\\w+>" inString:@"</asdf>sadfaf</adsff>ldllldd"];
    STAssertTrue([result count] == 2, @"有两个匹配时应该返回两个元素");
}

- (void)testShouldReturnCorrectRangeArray
{
    NSArray *result = [CBRegularExpressionManager itemIndexesWithPattern:@"</(\\w+)>" inString:@"</asdf>f</adsff>ldllldd"];
    NSRange range1 = [[result objectAtIndex:0] rangeValue];
    NSRange range2 = [[result objectAtIndex:1] rangeValue];
    STAssertTrue(range1.location == 0, @"range1.location == 0");
    STAssertTrue(range1.length == 7, @"range1.length == 7");
    
    STAssertTrue(range2.location == 8, @"range2.location == 8");
    STAssertTrue(range2.length == 8, @"range2.length == 8");
}

@end
