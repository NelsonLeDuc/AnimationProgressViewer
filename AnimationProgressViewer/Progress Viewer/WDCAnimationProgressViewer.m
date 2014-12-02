//
//  WDCAnimateProgressViewer.m
//  WWDC
//
//  Created by Nelson LeDuc on 4/11/14.
//  Copyright (c) 2014 Nelson LeDuc. All rights reserved.
//

#import "WDCAnimationProgressViewer.h"
#import "WDCAnimationProgressDescriptor.h"

@interface WDCAnimationProgressViewer ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) NSMapTable *observerTable;

@property (nonatomic, strong) NSMapTable *descriptorTable;

- (void)handleDisplayLink:(id)sender;

@end

@implementation WDCAnimationProgressViewer

#pragma mark - Public Class Methods

+ (instancetype)sharedInstance
{
    static WDCAnimationProgressViewer *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WDCAnimationProgressViewer alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _observerTable = [[NSMapTable alloc] initWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableStrongMemory capacity:2];
        _descriptorTable = [[NSMapTable alloc] initWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableCopyIn capacity:2];
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

    }
    return self;
}

#pragma mark - Public Methods

+ (void)addAnimationObserver:(id<WDCAnimationProgressViewerObserver>)observer forViews:(NSArray *)views
{
    if (!observer || !views)
        return;
    
    [[[self sharedInstance] observerTable] setObject:views forKey:observer];
}

+ (void)removeAnimationObserver:(id<WDCAnimationProgressViewerObserver>)observer
{
    [[[self sharedInstance] observerTable] removeObjectForKey:observer];
}

+ (void)addAnimationDescriptor:(WDCAnimationProgressDescriptor *)descriptor withCallback:(WDCProgressCallback)callback
{
    if (!descriptor || !callback)
        return;
    
    [[[self sharedInstance] descriptorTable] setObject:callback forKey:descriptor];
}

#pragma mark - Private Methods

- (void)handleDisplayLink:(id)sender
{
    if ([self.observerTable count] <= 0 && [self.descriptorTable count] <= 0)
    {
        return;
    }
    
    //Obsevers
    for (id<WDCAnimationProgressViewerObserver> observer in [[self.observerTable keyEnumerator] allObjects])
    {
        NSArray *views = [self.observerTable objectForKey:observer];
        NSMutableArray *mutLayers = [NSMutableArray arrayWithCapacity:[views count]];
        for (UIView *view in views)
        {
            CALayer *presLayer = [[view layer] presentationLayer];
            if (presLayer)
                [mutLayers addObject:presLayer];
        }
        [observer layersOfObservedViews:[NSArray arrayWithArray:mutLayers]];
    }
    
    //TODO: Refactor these two loops
    //Descriptors
    for (WDCAnimationProgressDescriptor *descriptor in [[self.descriptorTable keyEnumerator] allObjects])
    {
        WDCProgressCallback callback = [self.descriptorTable objectForKey:descriptor];
        CALayer *presLayer = [[descriptor.view layer] presentationLayer];
        
        NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithCapacity:descriptor.keyPaths.count];
        for (NSString *keyPath in descriptor.keyPaths)
        {
            id val = [presLayer valueForKeyPath:keyPath];
            [mutDict setObject:val forKey:keyPath];
        }
        
        callback([mutDict copy]);
    }
}

@end
