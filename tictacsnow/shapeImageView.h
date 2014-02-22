//
//  shapeImageView.h
//  tictacsnow
//
//  Created by Mark Meyer on 2/20/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shapeImageView : UIImageView <UIGestureRecognizerDelegate>

@property (nonatomic) int xOrigin;
@property (nonatomic) int yOrigin;
@property (nonatomic) int value;

- (void)animateDouble;

@end
