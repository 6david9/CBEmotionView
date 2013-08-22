//
//  ReplacingStringTests.m
//  CBEmotionView
//
//  Created by ly on 8/21/13.
//  Copyright (c) 2013 ly. All rights reserved.
//

#import "ReplacingStringTests.h"
#import "NSString+CBExtension.h"

@implementation ReplacingStringTests

- (void)testThrowsWhenInputNilForIndexes
{
    STAssertThrows([@"" replaceCharactersAtIndexes:nil withString:@""],
                   @"参数 indexes 不可以为nil");
}

- (void)testThrowsWhenInputNilForAString
{
    STAssertThrows([@"" replaceCharactersAtIndexes:[NSArray array] withString:nil],
                   @"参数 aString 不可以为nil");
}

- (void)testNoThrowsWhenInputNotNil
{
    STAssertNoThrow([@"" replaceCharactersAtIndexes:[NSArray array] withString:@""],
                    @"传入参数不为空时不应该抛异常");
}

- (void)testReplaceMatchingStringAtBeginOfTheLine
{
    NSRange range = NSMakeRange(0, 7);
    NSValue *rangeValue = [NSValue valueWithRange:range];
    NSString *oldString = @"</asdf>9";
    NSString *newString = [oldString replaceCharactersAtIndexes:@[ rangeValue ]
                           withString:@" "];
    
    STAssertEqualObjects(newString, @" 9", @"替换后的字符串应为 ' 9' ");
}

- (void)testReplaceMatchingStringAtEndOfTheLine
{
    NSRange range = NSMakeRange(1, 7);
    NSValue *rangeValue = [NSValue valueWithRange:range];
    NSString *oldString = @"9</asdf>";
    NSString *newString = [oldString replaceCharactersAtIndexes:@[ rangeValue ]
                                                     withString:@" "];
    
    STAssertEqualObjects(newString, @"9 ", @"替换后的字符串应为 '9 ' ");
}

- (void)testReplaceMatchingStringAtMiddleOfTheLine
{
    NSRange range = NSMakeRange(1, 7);
    NSValue *rangeValue = [NSValue valueWithRange:range];
    NSString *oldString = @"9</asdf>9";
    NSString *newString = [oldString replaceCharactersAtIndexes:@[ rangeValue ]
                                                     withString:@" "];
    
    STAssertEqualObjects(newString, @"9 9", @"替换后的字符串应为 '9 9' ");
}

- (void)testReplaceTwoMatchingString
{
    NSRange range1 = NSMakeRange(1, 7);
    NSRange range2 = NSMakeRange(10, 4);
    NSValue *rangeValue1 = [NSValue valueWithRange:range1];
    NSValue *rangeValue2 = [NSValue valueWithRange:range2];
    
    NSString *oldString = @"9</asdf>vv</d>9";
    NSString *newString = [oldString replaceCharactersAtIndexes:@[ rangeValue1, rangeValue2 ]
                                                     withString:@" "];
    
    STAssertEqualObjects(newString, @"9 vv 9", @"替换后的字符串应为 '9 vv 9' ");
}

- (void)testReplaceTwoNearMatchingString
{
    NSRange range1 = NSMakeRange(1, 7);
    NSRange range2 = NSMakeRange(8, 4);
    NSValue *rangeValue1 = [NSValue valueWithRange:range1];
    NSValue *rangeValue2 = [NSValue valueWithRange:range2];
    
    NSString *oldString = @"9</asdf></d>9";
    NSString *newString = [oldString replaceCharactersAtIndexes:@[ rangeValue1, rangeValue2 ]
                                                     withString:@" "];
    
    STAssertEqualObjects(newString, @"9  9", @"替换后的字符串应为 '9  9' ");
}

@end
