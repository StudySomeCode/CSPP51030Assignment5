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
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)animateDouble
{
    NSLog(@"animate Double on shape");
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(2.0, 2.0);
                     }
                     completion:^(BOOL completed){
                         if (completed) {
                             [UIView animateWithDuration:1.0 animations:^{
                                 self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                             }];
                         }
                     }];
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
