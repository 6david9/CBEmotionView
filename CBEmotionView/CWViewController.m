//
//  CWViewController.m
//  CBEmotionView
//
//  Created by ly on 8/21/13.
//  Copyright (c) 2013 ly. All rights reserved.
//

#import "CWViewController.h"
#import "CBEmotionView.h"

@interface CWViewController ()

@end

@implementation CWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CBEmotionView *emotionView = [[CBEmotionView alloc]
        initWithFrame:CGRectMake(0, 0, 200, 200)
        emotionString:@"</1>中文（Chinese），一般特指汉字</1></1>，即汉语的文字表达形式</2>。但</2>有时广义的</3>概念也有所扩展，即既包括书写</4>体系，也包括发音</4>体系。</1>中文的使用人数在15亿以上，范围包括中国（含香港、澳门、台湾地区）、新加坡、马来西亚、印度尼西亚、泰国、越南、柬埔寨、缅甸以及世界各地的华人社区。(</2</1>)"];
    
    emotionView.frame = CGRectMake(0, 0, 200, 200);
    [self.view addSubview:emotionView];
}

@end
