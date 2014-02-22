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
@property (nonatomic) int winner;

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
    
    self.grid = [[NSMutableArray alloc] initWithCapacity:9];

    self.x = [[shapeImageView alloc] initWithImage:[UIImage imageNamed:@"xImage"]];
    [self addRecognizers:self.x];
    self.x.xOrigin = 0;
    self.x.yOrigin = 450;
    self.x.value = X;
    self.x.frame = CGRectMake(self.x.xOrigin, self.x.yOrigin, self.x.frame.size.width, self.x.frame.size.height);
    [self.view addSubview:self.x];
    
    self.o = [[shapeImageView alloc] initWithImage:[UIImage imageNamed:@"oImage"]];
    [self addRecognizers:self.o];
    self.o.xOrigin = 230;
    self.o.yOrigin = 450;
    self.o.value = O;
    self.o.frame = CGRectMake(self.o.xOrigin, self.o.yOrigin, self.o.frame.size.width, self.o.frame.size.height);
    [self.view addSubview:self.o];
    
    [self resetGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)resetGame
{
    for (int i = 0; i < 9; ++i) {
        self.grid[i] = [NSNumber numberWithInt:Empty];
    }
    for (int i = 0; i < self.cellCollection.count; ++i) {
        
        UIView *view = (UIView *)self.cellCollection[i];
        [[view subviews]
         makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    self.winner = Empty;
    [self startTurn:self.x];
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
        shapeImageView *shape = (shapeImageView*)recognizer.view;
        
        if ([self checkCollission:shape]) {
            if ([self checkWinner]){
                [self displayAlert];
            } else {
                if (shape == self.x) {
                    [self startTurn:self.o];
                } else {
                    [self startTurn:self.x];
                }
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
    BOOL foundSingleIntersection = NO;
    int intersectIndex = -1;
    for (int i = 0; i < self.cellCollection.count; ++i) {
        
        UIView *view = (UIView *)self.cellCollection[i];
        
        if (CGRectIntersectsRect(shape.frame,view.frame)) {
            if (!foundSingleIntersection) {
                foundSingleIntersection = YES;
                intersectIndex = i;
            } else {
                //intersecting two possible cells, try again
                return NO;
            }
        }
    }
    
    if (foundSingleIntersection &&
        self.grid[intersectIndex] == [NSNumber numberWithInt:Empty]) {
        
        self.grid[intersectIndex] =[NSNumber numberWithInt:shape.value];
        
        UIView *view = (UIView *)self.cellCollection[intersectIndex];
        [UIView animateWithDuration:0.5
                         animations:^{
                             shape.center = [view convertPoint:view.center fromView:nil];
                         } completion:^(BOOL finished){
                             if (finished) {
                                 UIImageView *img = [[UIImageView alloc] initWithImage:shape.image];
                                 [view addSubview:img];
                                 shape.frame = CGRectMake(shape.xOrigin, shape.yOrigin, shape.frame.size.width, shape.frame.size.height);
                             }
                         }];
        return YES;
    }
    
    return NO;
}

- (BOOL)checkWinner
{
    //Check the 8 ways to win
    if (self.grid[0] != [NSNumber numberWithInt:Empty]){
        if ((self.grid[0] == self.grid[1] && self.grid[0] == self.grid[2]) ||
            (self.grid[0] == self.grid[3] && self.grid[0] == self.grid[6]) ||
             (self.grid[0] == self.grid[4] && self.grid[0] == self.grid[8])){
            self.winner = [self.grid[0] intValue];
            return YES;
        }
    }
    if (self.grid[1] != [NSNumber numberWithInteger:Empty] &&
        (self.grid[1] == self.grid[4] && self.grid[1] == self.grid[7])) {
        self.winner = [self.grid[1] intValue];
        return YES;
    }
    if (self.grid[2] != [NSNumber numberWithInt:Empty]){
        if ((self.grid[2] == self.grid[4] && self.grid[2] == self.grid[6]) ||
            (self.grid[2] == self.grid[5] && self.grid[2] == self.grid[8])){
            self.winner = [self.grid[2] intValue];
            return YES;
        }
    }
    if (self.grid[3] != [NSNumber numberWithInteger:Empty] &&
        (self.grid[3] == self.grid[4] && self.grid[3] == self.grid[5])) {
        self.winner = [self.grid[3] intValue];
        return YES;
    }
    if (self.grid[6] != [NSNumber numberWithInteger:Empty] &&
        (self.grid[6] == self.grid[7] && self.grid[6] == self.grid[8])) {
        self.winner = [self.grid[6] intValue];
        return YES;
    }
    
    //No winner, cat's game?
    for (int i = 0; i < [self.grid count]; ++i){
        if (self.grid[i] == [NSNumber numberWithInt:Empty]){
            //still an empty spot
            return NO;
        }
    }
    return YES;
}

- (void)displayAlert
{
    NSString *message;
    if (self.winner == Empty) {
        message = @"No winner :(";
    } else if (self.winner == X) {
        message = @"Congratulations Player X";
    } else {
        message = @"Congratulations Player O";
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                 message:message
                                                delegate:self
                                       cancelButtonTitle:@"Restart Game"
                                       otherButtonTitles:nil]; 
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex
{
    [self resetGame];
}

- (void)startTurn:(shapeImageView *)shape
{
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
