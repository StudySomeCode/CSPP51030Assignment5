//
//  ViewController.h
//  tictacsnow
//
//  Created by Mark Meyer on 2/19/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shapeImageView.h"

@interface ViewController : UIViewController <UIGestureRecognizerDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cellCollection;

- (IBAction)infoTapped:(UIButton *)sender;

@end
