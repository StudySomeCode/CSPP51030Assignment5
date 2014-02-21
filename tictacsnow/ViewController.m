//
//  ViewController.m
//  tictacsnow
//
//  Created by Mark Meyer on 2/19/14.
//  Copyright (c) 2014 Mark Meyer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) shapeImageView *x;
@property (strong, nonatomic) shapeImageView *o;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.x = [[shapeImageView alloc] initWithImage:[UIImage imageNamed:@"xImage"]];
    [self addRecognizers:self.x];
    self.x.xOrigin = 0;
    self.x.yOrigin = 450;
    self.x.frame = CGRectMake(self.x.xOrigin, self.x.yOrigin, self.x.frame.size.width, self.x.frame.size.height);
    [self.view addSubview:self.x];
    
    self.o = [[shapeImageView alloc] initWithImage:[UIImage imageNamed:@"oImage"]];
    [self addRecognizers:self.o];
    self.o.xOrigin = 230;
    self.o.yOrigin = 450;
    self.o.frame = CGRectMake(self.o.xOrigin, self.o.yOrigin, self.o.frame.size.width, self.o.frame.size.height);
    [self.view addSubview:self.o];
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
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animateDouble:)];
    [tapReconizer setDelegate:self];
    [piece addGestureRecognizer:tapReconizer];
}

- (void)panGestureDetected:(UIPanGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    } else if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled)
    {
        NSLog(@"Stopped moving");
        shapeImageView *shape = (shapeImageView*)recognizer.view;
        [UIView animateWithDuration:1.0
                         animations:^{
                             shape.frame = CGRectMake(shape.xOrigin, shape.yOrigin, shape.frame.size.width, shape.frame.size.height);
                         }];
    }
}

- (void)animateDouble:(UITapGestureRecognizer *)recognizer
{
    shapeImageView *shape = (shapeImageView*)recognizer.view;
    [shape animateDouble];
}
@end
