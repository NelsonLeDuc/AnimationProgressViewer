//
//  WDCAnimationProgressDescriptor.m
//  AnimationProgressViewer
//
//  Created by Nelson LeDuc on 12/2/14.
//  Copyright (c) 2014 Nelson LeDuc. All rights reserved.
//

#import "WDCAnimationProgressDescriptor.h"

@interface WDCAnimationProgressDescriptor ()

@property (nonatomic, weak) UIView *view;
@property (nonatomic, strong) NSArray *keyPaths;

@end

@implementation WDCAnimationProgressDescriptor

#pragma mark - Class Methods

+ (instancetype)descriptorWithView:(UIView *)view layerKeyPaths:(NSArray *)keyPaths
{
    return [[self alloc] initWithView:view layerKeyPaths:keyPaths];
}

+ (instancetype)descriptorWithView:(UIView *)view layerKeyPath:(NSString *)keyPath
{
    return [[self alloc] initWithView:view layerKeyPath:keyPath];
}

#pragma mark - Initializers

- (instancetype)initWithView:(UIView *)view layerKeyPaths:(NSArray *)keyPaths
{
    self = [super init];
    if (self)
    {
        _view = view;
        _keyPaths = keyPaths;
    }
    
    return self;
}

- (instancetype)initWithView:(UIView *)view layerKeyPath:(NSString *)keyPath
{
    self = [super init];
    if (self)
    {
        _view = view;
        _keyPaths = @[ keyPath ];
    }
    
    return self;
}

@end
