//
//  NSData+CBExtension.h
//  CBExtension
//
//  Created by ly on 13-7-29.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CBExtension)

- (NSDictionary *)jsonObject;

+ (NSString *)contentTypeForImageData:(NSData *)data;

@end
