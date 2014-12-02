//
//  WDCAnimationProgressDescriptor.h
//  AnimationProgressViewer
//
//  Created by Nelson LeDuc on 12/2/14.
//  Copyright (c) 2014 Nelson LeDuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDCAnimationProgressDescriptor : NSObject

@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic, strong, readonly) NSArray *keyPaths;

+ (instancetype)descriptorWithView:(UIView *)view layerKeyPaths:(NSArray *)keyPaths;
+ (instancetype)descriptorWithView:(UIView *)view layerKeyPath:(NSString *)keyPath;

- (instancetype)initWithView:(UIView *)view layerKeyPaths:(NSArray *)keyPaths;
- (instancetype)initWithView:(UIView *)view layerKeyPath:(NSString *)keyPath;

@end
