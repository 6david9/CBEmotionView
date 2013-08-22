//
//  CBEmotionView.h
//  CBEmotionView
//
//  Created by ly on 8/21/13.
//  Copyright (c) 2013 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBEmotionView : UIView

// 原始的字符串
StrongProperty NSString *emotionString;

// 处理过后的用户绘图的富文本字符串
StrongProperty_r NSAttributedString *attrEmotionString; 

// 按顺序保存的 emotionString 中包含的表情名字
StrongProperty_r NSArray *emotionNames;

StrongProperty_r NSArray *emotionRanges;

// 表情图片缓存，用户保存表情图片在内存中
StrongProperty_r NSCache *emotionCache;





- (id)initWithFrame:(CGRect)frame emotionString:(NSString *)emotionString;

/// 将 emotionString 中的特殊字符串替换为空格
// @discussion 不要直接调用此方法
- (void)cookEmotionString;

@end
