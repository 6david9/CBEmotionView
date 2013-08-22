//
//  NSString+Extension.m
//  CBExtension
//
//  Created by ly on 13-6-29.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

#pragma mark - Regular expression
- (NSMutableArray *)itemsForPattern:(NSString *)pattern
{
    return [self itemsForPattern:pattern captureGroupIndex:0];
}

- (NSMutableArray *)itemsForPattern:(NSString *)pattern captureGroupIndex:(NSUInteger)index
{
    if ( !pattern )
        return nil;
    
    NSError *error = nil;
    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:pattern
        options:NSRegularExpressionCaseInsensitive error:&error];
    if (error)
    {
        NSLog(@"Error for create regular expression:\nString: %@\nPattern %@\nError: %@\n",self, pattern, error);
    }
    else
    {
        NSMutableArray *results = [[NSMutableArray alloc] init];
        NSRange searchRange = NSMakeRange(0, [self length]);
        [regx enumerateMatchesInString:self options:0 range:searchRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            
            NSRange groupRange =  [result rangeAtIndex:index];
            NSString *match = [self substringWithRange:groupRange];
            [results addObject:match];
        }];
        return results;
    }
    
    return nil;
}

- (NSString *)itemForPatter:(NSString *)pattern
{
    return [self itemForPattern:pattern captureGroupIndex:0];
}

- (NSString *)itemForPattern:(NSString *)pattern captureGroupIndex:(NSUInteger)index
{
    if ( !pattern )
        return nil;
    
    NSError *error = nil;
    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:pattern
        options:NSRegularExpressionCaseInsensitive error:&error];
    if (error)
    {
        NSLog(@"Error for create regular expression:\nString: %@\nPattern %@\nError: %@\n",self, pattern, error);
    }
    else
    {
        NSRange searchRange = NSMakeRange(0, [self length]);
        NSTextCheckingResult *result = [regx firstMatchInString:self options:0 range:searchRange];
        NSRange groupRange = [result rangeAtIndex:index];
        NSString *match = [self substringWithRange:groupRange];
        return match;
    }
    
    return nil;
}

#pragma mark - Time Interval
- (NSTimeInterval)timeIntervalFromString:(NSString *)timeString withDateFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [[formatter dateFromString:timeString] timeIntervalSince1970];
}

- (NSTimeInterval)localTimeIntervalFromString:(NSString *)timeString withDateFormat:(NSString *)format
{
    NSTimeInterval timeInterval = [self timeIntervalFromString:timeString withDateFormat:format];
    NSUInteger secondsOffset = [[NSTimeZone localTimeZone] secondsFromGMT];
    return (timeInterval + secondsOffset);
}

#pragma mark - Contains
- (BOOL)contains:(NSString *)piece
{
    return ( [self rangeOfString:piece].location != NSNotFound );
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
