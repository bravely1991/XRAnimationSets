//
//  XRFeatureIndexViewController.m
//  XRAnnularPieView
//
//  Created by brave on 2017/9/10.
//  Copyright © 2017年 brave. All rights reserved.
//

#import "XRAnnularPieViewController.h"
#import "XRAnnularPieView.h"
#import "XRSummaryPieView.h"

@interface XRAnnularPieViewController ()

@end

@implementation XRAnnularPieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
        
    XRAnnularPieView *annularView = [[XRAnnularPieView alloc] initWithFrame:CGRectMake(0, 74, XRWidth, 220)];
    annularView.itemArray = [NSMutableArray arrayWithObjects:@"张三", @"李四", @"宝宝", nil];
    annularView.valueArray = [NSMutableArray arrayWithObjects:@"0.5", @"0.3", @"0.2", nil];
    annularView.colorArray = [NSMutableArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    annularView.showAnimation = YES;
    annularView.showitemLabel = YES;
    [annularView strokePath];

    [self.view addSubview:annularView];
    
    XRSummaryPieView *summaryPieView = [[XRSummaryPieView alloc] initWithFrame:CGRectMake(0, 310, XRWidth, 150)];
    summaryPieView.itemArray = [NSMutableArray arrayWithObjects:@"余额", @"余额宝", @"定期", @"基金", nil];
    summaryPieView.valueArray = [NSMutableArray arrayWithObjects:@"14.68", @"0.68", @"12000", @"19000", nil];
    summaryPieView.colorArray = [NSMutableArray arrayWithObjects:[UIColor orangeColor], [UIColor redColor], [UIColor blueColor],[UIColor purpleColor], nil];
    summaryPieView.showAnimation = YES;
    summaryPieView.showitemLabel = NO;
    [summaryPieView strokePath];
    
    [self.view addSubview:summaryPieView];

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
