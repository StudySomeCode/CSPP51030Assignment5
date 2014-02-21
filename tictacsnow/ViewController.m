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
@property (strong, nonatomic) NSMutableArray *grid;

typedef NS_ENUM(NSInteger, CellState) {
    Empty,
    X,
    O
};

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"viewController viewDidLoad");
    
    self.grid = [[NSMutableArray alloc] initWithCapacity:3];
    for (int i = 0; i < 3; ++i) {
        self.grid[i] = [[NSMutableArray alloc] initWithCapacity:3];
        for (int j = 0; j < 3; ++j) {
            self.grid[i][j] = [NSNumber numberWithInt:Empty];
        }
    }
    
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
    
    [self startTurn:self.x];
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
    
    /*
    UITapGestureRecognizer *tapReconizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animateDouble:)];
    [tapReconizer setDelegate:self];
    [piece addGestureRecognizer:tapReconizer];
     */
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
        
        if ([self checkCollission:shape]) {
            if (shape == self.x) {
                [self startTurn:self.o];
            } else {
                [self startTurn:self.x];
            }
        } else {
            [UIView animateWithDuration:1.0
                         animations:^{
                             shape.frame = CGRectMake(shape.xOrigin, shape.yOrigin, shape.frame.size.width, shape.frame.size.height);
                         }];
        }
    }
}

- (BOOL)checkCollission:(shapeImageView *)shape
{
    return NO;
}

- (void)animateDouble:(UITapGestureRecognizer *)recognizer
{
    shapeImageView *shape = (shapeImageView *)recognizer.view;
    [shape animateDouble];
}

- (void)startTurn:(shapeImageView *)shape
{
    NSLog(@"viewController startTurn");

    if (shape == self.x) {
        self.o.userInteractionEnabled = NO;
        [UIView animateWithDuration:1.0
                         animations:^{
                             self.o.alpha = 0.5;
                             shape.alpha = 1.0;
                         }];
    } else {
        self.x.userInteractionEnabled = NO;
        [UIView animateWithDuration:1.0
                         animations:^{
                             self.x.alpha = 0.5;
                             shape.alpha = 1.0;
                         }];
    }
    
    shape.userInteractionEnabled = YES;
    
    [shape animateDouble];
}
@end
