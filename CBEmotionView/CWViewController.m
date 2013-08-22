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
        emotionString:@"</1>sadfaf</2>ldllldd</1>sadfaf</2>ldllldd</1>sadfaf</2>ldllldd</1>sadfaf</2>ldllldd</1>sadfaf</2>ldllldd</2></2></2></2></2></2></2></2></2></2></2></2></2></2></2></2></2></1>asdf"];
    

    [self.view addSubview:emotionView];
}

@end
