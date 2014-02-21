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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)infoTapped:(UIButton *)sender {
    UIActionSheet *msg = [[UIActionSheet alloc]
                          initWithTitle:@"It's tic tac toe. Do you really need instructions?"
                          delegate:nil
                          cancelButtonTitle:nil destructiveButtonTitle:nil
                          otherButtonTitles:@"I guess not...", nil]; 
    [msg showInView:self.view];
}
@end
