//
//  ViewController.m
//  NBJNibBasedView-ObjC-Example
//
//  Created by Brentley Jones on 6/22/14.
//  Copyright (c) 2014 Brentley Jones. All rights reserved.
//

#import "ViewController.h"

#import "CustomView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CustomView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customView.topLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam feugiat laoreet iaculis. Proin condimentum iaculis dui vitae tristique. Praesent lobortis iaculis urna eu elementum. Quisque convallis, nunc ac viverra elementum, sem turpis dapibus dolor.";
    self.customView.bottomLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque imperdiet elit ut aliquet. Aliquam.";
}

@end
