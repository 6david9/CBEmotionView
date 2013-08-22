//
//  CBEmotionView.m
//  CBEmotionView
//
//  Created by ly on 8/21/13.
//  Copyright (c) 2013 ly. All rights reserved.
//

#import "CBEmotionView.h"
#import <CoreText/CoreText.h>
#import "CBRegularExpressionManager.h"
#import "NSString+CBExtension.h"
#import "NSArray+CBExtension.h"

#define EmotionItemPattern          @"</(\\w+)>"
#define PlaceHolder                 @" "
#define EmotionFileType             @"gif"
#define AttributedImageNameKey      @"ImageName"
#define EmotionImageWidth           15.0

#define ImageLeftPadding            2.0
#define ImageTopPadding             3.0

@implementation CBEmotionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _emotionString = @"";
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame emotionString:(NSString *)emotionString
{
    self = [super initWithFrame:frame];
    if (self) {
        _emotionString = emotionString;
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    _emotionString = nil;
}

- (void)setup
{
    _emotionCache = [[NSCache alloc] init];
    [self prepare];
}

- (void)prepare
{
    self.backgroundColor = [UIColor whiteColor];
    [self cookEmotionString];
}

#pragma mark - Cook the emotion string
- (void)cookEmotionString
{
    // 使用正则表达式查找特殊字符的位置
    NSArray *itemIndexes = [CBRegularExpressionManager itemIndexesWithPattern:
                            EmotionItemPattern inString:_emotionString];
    
    // 查找表情对应的字符串 并加载相应的表情图片到内存中
    _emotionNames = [_emotionString itemsForPattern:EmotionItemPattern captureGroupIndex:1];
    [self loadEmotions:_emotionNames];
    
    
    // 将 emotionString 中的特殊字符串替换为空格
    NSString *newString = [_emotionString replaceCharactersAtIndexes:itemIndexes
                                                     withString:PlaceHolder];
    
    // 新的表情的占位符的 range 数组
    _emotionRanges = [itemIndexes offsetRangesInArrayBy:[PlaceHolder length]];
    
    
    _attrEmotionString = [self createAttributedEmotionStringWithRanges:_emotionRanges forString:newString];
}

#pragma mark - Utility for emotions relative operations
// 加载表情到内存中
- (void)loadEmotions:(NSArray *)emotionNames
{
    NSAssert(_emotionNames != nil, @"emotionNames 不可以为 nil");
    
    for(NSInteger i = 0; i < [emotionNames count]; i++)
    {
        NSString *name = [emotionNames objectAtIndex:i];
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:EmotionFileType];
        UIImage *emotionImg = [[UIImage alloc] initWithContentsOfFile:path];
        [self.emotionCache setObject:emotionImg forKey:name];
    }
}

// 根据调整后的字符串，生成绘图时使用的 attribute string
- (NSAttributedString *)createAttributedEmotionStringWithRanges:(NSArray *)ranges
                                                      forString:(NSString*)aString
{
    NSAssert(_emotionString != nil, @"emotionString 不可以为Nil");
    NSAssert(aString != nil,        @"aString 不可以为Nil");
    
    
    NSMutableAttributedString *attrString =
        [[NSMutableAttributedString alloc] initWithString:aString];
    
    for(NSInteger i = 0; i < [ranges count]; i++)
    {
        NSRange range = [[ranges objectAtIndex:i] rangeValue];
        NSString *emotionName = [self.emotionNames objectAtIndex:i];
        [attrString addAttribute:AttributedImageNameKey value:emotionName range:range];
        [attrString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)newEmotionRunDelegate() range:range];
    }
    return attrString;
}

// 通过表情名获得表情的图片
- (UIImage *)getEmotionForKey:(NSString *)key
{
    UIImage *emotion = [self.emotionCache objectForKey:key];
    
    if ( !emotion )
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:key ofType:EmotionFileType];
        UIImage *emotionImg = [[UIImage alloc] initWithContentsOfFile:path];
        [self.emotionCache setObject:emotionImg forKey:key];
    }
    return emotion;
}

CTRunDelegateRef newEmotionRunDelegate()
{
    static NSString *emotionRunName = @"com.cocoabit.CBEmotionView.emotionRunName";
    
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = RunDelegateDeallocCallback;
    imageCallbacks.getAscent = RunDelegateGetAscentCallback;
    imageCallbacks.getDescent = RunDelegateGetDescentCallback;
    imageCallbacks.getWidth = RunDelegateGetWidthCallback;
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks,
                                   (__bridge void *)(emotionRunName));
    
    return runDelegate;
}

#pragma mark - Run delegate
void RunDelegateDeallocCallback( void* refCon )
{
    // Do nothing here
}

CGFloat RunDelegateGetAscentCallback( void *refCon )
{
    return 15.0;
}

CGFloat RunDelegateGetDescentCallback(void *refCon)
{
    return 0.0;
}

CGFloat RunDelegateGetWidthCallback(void *refCon)
{
    // EmotionImageWidth + 2 * ImageLeftPadding
    return  19.0;
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 翻转坐标系
    CGFloat h = CGRectGetHeight(self.bounds);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -h);
    
    // 生成绘图路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y,
                               self.bounds.size.width, self.bounds.size.height);
    CGPathAddRect(path, NULL, bounds);
    
    // Frame setter
    CTFramesetterRef ctFramesetter =
        CTFramesetterCreateWithAttributedString((__bridge CFMutableAttributedStringRef)_attrEmotionString);
    
    // 画字
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter,CFRangeMake(0, 0), path, NULL);
    CTFrameDraw(ctFrame, context);
    
    // 画表情
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];        // 每个 line 的起始坐标
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;     // 上行距
        CGFloat lineDescent;    // 下行距
        CGFloat lineLeading;    // 行间距
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        for (int j = 0; j < CFArrayGetCount(runs); j++) {
            CGPoint lineOrigin = lineOrigins[i];
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary* attributes = (__bridge NSDictionary*)CTRunGetAttributes(run);
            
            NSString *imageName = [attributes objectForKey:AttributedImageNameKey];
            //图片渲染逻辑
            if (imageName)
            {
                CGFloat runOriginX = lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
                
                UIImage *image = [self getEmotionForKey:imageName];
                if (image) {
                    CGRect imageDrawRect;
                    imageDrawRect.size = CGSizeMake(EmotionImageWidth, EmotionImageWidth);
                    imageDrawRect.origin.x = runOriginX + lineOrigin.x + ImageLeftPadding;
                    imageDrawRect.origin.y = lineOrigin.y - ImageTopPadding;
                    CGContextDrawImage(context, imageDrawRect, image.CGImage);
                }
            }
        }
    }
}


@end
