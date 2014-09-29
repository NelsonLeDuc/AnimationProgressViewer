//
//  WDCAnimateProgressViewer.h
//  WWDC
//
//  Created by Nelson LeDuc on 4/11/14.
//  Copyright (c) 2014 Nelson LeDuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WDCAnimationProgressViewerObserver;

@interface WDCAnimationProgressViewer : NSObject

+ (void)addAnimationObserver:(id<WDCAnimationProgressViewerObserver>)observer forViews:(NSArray *)views;
+ (void)removeAnimationObserver:(id<WDCAnimationProgressViewerObserver>)observer;

@end

@protocol WDCAnimationProgressViewerObserver <NSObject>

@required
- (void)layersOfObservedViews:(NSArray *)layers;

@end