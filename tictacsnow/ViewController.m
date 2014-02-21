//
//  ViewController.m
//  tictacsnow
//
//  Created by Mark Meyer on 2/19/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    shapeImageView *x = [[shapeImageView alloc] initWithImage:[UIImage imageNamed:@"xImage"]];
    [self addRecognizers:x];
    //shapeImageView *o = [[shapeImageView alloc] initWithImage:[UIImage imageNamed:@"oImage"]];
    [self.view addSubview:x];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)infoTapped:(UIButton *)sender {
    UIActionSheet *msg = [[UIActionSheet alloc]
                          initWithTitle:@"It's tic tac toe. Do you really need instructions?"
                          delegate:nil
                          cancelButtonTitle:nil destructiveButtonTitle:nil
                          otherButtonTitles:@"I guess not...", nil]; 
    [msg showInView:self.view];
}

- (void)addRecognizers:(shapeImageView *)piece {
    UIPanGestureRecognizer *panRecognizer =
    [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    [panRecognizer setDelegate:self];
    panRecognizer.minimumNumberOfTouches = 1;
    [piece addGestureRecognizer:panRecognizer];
    
    UITapGestureRecognizer *tapReconizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animateDouble)];
    [tapReconizer setDelegate:self];
    [piece addGestureRecognizer:tapReconizer];
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

- (void)animateDouble
{
    NSLog(@"animate Double");
    /*
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
     */
}
@end
