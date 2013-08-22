//
//  NSDictionary+CBExtension.m
//  CBExtension
//
//  Created by ly on 13-7-29.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#import "NSDictionary+CBExtension.h"

@implementation NSDictionary (CBExtension)

#pragma mark - Extension for NSNumber
- (BOOL)boolForKey:(NSString *)key
{
    return [[self valueForKey:key] boolValue];
}

- (NSInteger)integerForKey:(NSString *)key
{
    return [[self valueForKey:key] integerValue];
}

- (int)intForKey:(NSString *)key
{
    return [[self valueForKey:key] intValue];
}

- (double)doubleForKey:(NSString *)key
{
    return [[self valueForKey:key] doubleValue];
}

- (float)floatForKey:(NSString *)key
{
    return [[self valueForKey:key] floatValue];
}

- (long long)longLongForKey:(NSString *)key
{
    return [[self valueForKey:key] longLongValue];
}

- (unsigned long long)unsignedLongLongForKey:(NSString *)key
{
    return [[self valueForKey:key] unsignedLongLongValue];
}

#pragma mark - Extension for NSString
- (NSString *)stringForKey:(NSString *)key
{
    return [[self valueForKey:key] description];
}

@end
