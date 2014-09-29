//
//  ViewController.m
//  AnimationProgressViewer
//
//  Created by Nelson LeDuc on 9/29/14.
//  Copyright (c) 2014 Nelson LeDuc. All rights reserved.
//

#import "ViewController.h"
#import "WDCAnimationProgressViewer.h"

@interface ViewController () <WDCAnimationProgressViewerObserver>

@property (nonatomic, strong) UIView *animatedView;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.animatedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.animatedView.backgroundColor = [UIColor blueColor];
    self.animatedView.center = self.view.center;
    [self.view addSubview:self.animatedView];
    
    //Create up and down animation
    CGFloat shiftAmount = 100.0;
    CGFloat xPosition = self.animatedView.center.x;
    CGFloat yPosition = self.animatedView.center.y;
    CABasicAnimation *bounceAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    bounceAnimation.duration = 2.0;
    bounceAnimation.repeatCount = HUGE_VALF;
    bounceAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(xPosition, yPosition - shiftAmount)];
    bounceAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(xPosition, yPosition + shiftAmount)];
    bounceAnimation.autoreverses = YES;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.animatedView.layer addAnimation:bounceAnimation forKey:@"bounce"];
    
    [WDCAnimationProgressViewer addAnimationObserver:self forViews:@[self.animatedView]];
}

#pragma mark - WDCAnimationProgressViewerObserver

- (void)layersOfObservedViews:(NSArray *)layers
{
    if (layers.count == 0)
        return;
    
    CALayer *animatedLayer = layers[0];
    if (ABS(animatedLayer.position.y - self.view.center.y) < 1.0)
    {
        self.animatedView.backgroundColor = ([self.animatedView.backgroundColor isEqual:[UIColor blueColor]]) ? [UIColor redColor] : [UIColor blueColor];
    }
}

@end
