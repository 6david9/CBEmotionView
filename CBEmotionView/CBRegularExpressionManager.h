//
//  CBRegularExpressionManager.h
//  CBEmotionView
//
//  Created by ly on 8/21/13.
//  Copyright (c) 2013 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBRegularExpressionManager : NSObject

+ (NSArray *)itemIndexesWithPattern:(NSString *)pattern inString:(NSString *)findingString;

@end
