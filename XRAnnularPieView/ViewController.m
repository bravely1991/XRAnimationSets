//
//  ViewController.m
//  XRAnnularPieView
//
//  Created by brave on 2017/9/9.
//  Copyright © 2017年 brave. All rights reserved.
//

#import "ViewController.h"
#import "XRAnnularPieView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    XRAnnularPieView *annularView = [[XRAnnularPieView alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
    annularView.valueArray = [NSMutableArray arrayWithObjects:@"0.45", @"0.30", @"0.25", nil];
    annularView.colorArray = [NSMutableArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    [annularView strokePath];
    [self.view addSubview:annularView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
