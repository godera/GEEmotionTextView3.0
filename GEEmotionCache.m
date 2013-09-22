//
//  GEEmotionCache.m
//  kissme
//
//  Created by sunyanliang on 13-9-22.
//  Copyright (c) 2013年 赵岩. All rights reserved.
//

#import "GEEmotionCache.h"
#import "GEGifView.h"

@interface GEEmotionCache ()

@property (retain, nonatomic) NSMutableDictionary* emotionDataCache;

@end

@implementation GEEmotionCache

+ (instancetype)sharedInstance
{
    static GEEmotionCache* cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [GEEmotionCache new];
    });
    return cache;
}

-(id)retain
{
    return self;
}

-(oneway void)release
{
    //do nothing
}

-(NSUInteger)retainCount{
    return NSUIntegerMax;
}

// 在此处加载表情
- (id)init
{
    self = [super init];
    if (self) {
        _emotionDataCache = [NSMutableDictionary new];
        NSArray* emotionZis = @[@"吃惊",@"亲亲",@"抓狂",@"悲伤"];
        
        GEGifView* tempGifView = [GEGifView new];
        for (NSString* emotionZi in emotionZis) {
            @autoreleasepool {
                tempGifView.data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:emotionZi ofType:@"gif"]];
                [_emotionDataCache setObject:tempGifView.frameItems forKey:emotionZi];
            }
        }
        [tempGifView release];
    }
    return self;
}

+ (NSDictionary*)objectForKey:(NSString*)emotionZi
{
    return [[[self sharedInstance] emotionDataCache] objectForKey:emotionZi];
}

@end


























