//
//  NSData+CBExtension.m
//  CBExtension
//
//  Created by ly on 13-7-29.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#import "NSData+CBExtension.h"

@implementation NSData (CBExtension)

- (NSDictionary *)jsonObject
{
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:nil];
}

+ (NSString *)contentTypeForImageData:(NSData *)data
{
    // http://stackoverflow.com/questions/4147311/finding-image-type-from-nsdata-or-uiimage
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

@end
