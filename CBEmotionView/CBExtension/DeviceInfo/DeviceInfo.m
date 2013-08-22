//
//  DeviceInfo.m
//  CBExtension
//
//  Created by ly on 13-7-7.
//  Copyright (c) 2013年 Lei Yan. All rights reserved.
//

#import "DeviceInfo.h"
#import "IPAddress.h"

@implementation DeviceInfo

+ (NSString*)IPAddress
{
    InitAddresses();
    GetIPAddresses();
    GetHWAddresses();
    return [NSString stringWithFormat:@"%s", ip_names[1]];
}

@end
