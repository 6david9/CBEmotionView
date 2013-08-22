//
//  NSFileManager+iCloud.h
//  CBExtension
//
//  Created by ly on 13-6-2.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (iCloud)

+ (BOOL)iCloudAvaliable:(NSString *)containerID;

@end
