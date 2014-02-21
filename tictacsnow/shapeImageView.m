//
//  shapeView.m
//  tictacsnow
//
//  Created by Mark Meyer on 2/20/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import "shapeImageView.h"

@implementation shapeImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer *panRecognizer =
        [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
        [panRecognizer setDelegate:self];
        panRecognizer.minimumNumberOfTouches = 1;
        panRecognizer.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:panRecognizer];
    }
    return self;
}

- (void)panGestureDetected:(UIPanGestureRecognizer *)recognizer
{
    NSLog(@"Moved");
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
