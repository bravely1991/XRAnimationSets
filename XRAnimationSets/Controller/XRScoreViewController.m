//
//  XRScoreViewController.m
//  XRAnimationSets
//
//  Created by brave on 2018/3/18.
//  Copyright © 2018年 brave. All rights reserved.
//

#import "XRScoreViewController.h"
#import "XRScoreView.h"

@interface XRScoreViewController ()

@property (nonatomic, strong) XRScoreView *scoreView;

@end

@implementation XRScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.scoreView = [[XRScoreView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.scoreView.center = self.view.center;
    self.scoreView.animationDuration = 0.5f;
    [self.view addSubview:self.scoreView];
    
    self.scoreView.score = 70;
    [self.scoreView strokePath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
}

@end
