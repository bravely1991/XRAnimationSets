//
//  XRInstumentBoardViewController.m
//  XRAnimationSets
//
//  Created by 邵勇 on 2018/3/20.
//  Copyright © 2018年 brave. All rights reserved.
//

#import "XRInstumentBoardViewController.h"
#import "XRInstrumentBoard.h"


@interface XRInstumentBoardViewController ()

@property (nonatomic, strong) XRInstrumentBoard *instrumentBoard;

@end

@implementation XRInstumentBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.instrumentBoard = [[XRInstrumentBoard alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    self.instrumentBoard.center = self.view.center;
    [self.view addSubview:self.instrumentBoard];
    
    self.instrumentBoard.value = 75;
    [self.instrumentBoard strokePath];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
