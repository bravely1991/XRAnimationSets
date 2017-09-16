//
//  FeatureTestViewController.m
//  XRAnnularPieView
//
//  Created by brave on 2017/9/10.
//  Copyright © 2017年 brave. All rights reserved.
//

#import "FeatureTestViewController.h"
#import "XRAnnularPieView.h"

@interface FeatureTestViewController ()

@end

@implementation FeatureTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    XRAnnularPieView *annularView = [[XRAnnularPieView alloc] initWithFrame:CGRectMake(0, 100, 320, 220)];
    annularView.itemArray = [NSMutableArray arrayWithObjects:@"自己", @"其他", nil];
    annularView.valueArray = [NSMutableArray arrayWithObjects:@"0.2", @"0.8", nil];
    
    annularView.colorArray = [NSMutableArray arrayWithObjects:[UIColor colorWithRed:241/255.0 green:90/255.0 blue:85/255.0 alpha:1], [UIColor colorWithRed:221/255.0 green:222/255.0 blue:223/255.0 alpha:1], nil];
    annularView.showAnimation = YES;
    annularView.showitemLabel = YES;
    [annularView strokePath];
    

    [self.view addSubview:annularView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
