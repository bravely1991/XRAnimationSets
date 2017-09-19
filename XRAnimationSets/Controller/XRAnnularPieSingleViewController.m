//
//  XRAnnularPieSingleViewController.m
//  XRAnimationSets
//
//  Created by brave on 2017/9/19.
//  Copyright © 2017年 brave. All rights reserved.
//

#import "XRAnnularPieSingleViewController.h"
#import "XRAnnularPieSingleView.h"


@interface XRAnnularPieSingleViewController ()

@end

@implementation XRAnnularPieSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
        
    XRAnnularPieSingleView *annularView = [[XRAnnularPieSingleView alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
    annularView.itemArray = [NSMutableArray arrayWithObjects:@"自己", nil];
    annularView.valueArray = [NSMutableArray arrayWithObjects:@"0.6", nil];
    annularView.colorArray = [NSMutableArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
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
