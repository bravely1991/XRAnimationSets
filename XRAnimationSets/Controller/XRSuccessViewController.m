//
//  XRSuccessViewController.m
//  XRAnnularPieView
//
//  Created by brave on 2017/9/19.
//  Copyright © 2017年 brave. All rights reserved.
//

#import "XRSuccessViewController.h"
#import "XRSuccessView.h"
#import "Masonry.h"

@interface XRSuccessViewController ()

@property (nonatomic, strong) XRSuccessView *succesView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *doneBtn;

@end

@implementation XRSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.succesView = [[XRSuccessView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.succesView.center = self.view.center;
    self.succesView.animationDuration = 0.5f;
    [self.succesView strokePath];
    [self.view addSubview:self.succesView];
    
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.font = [UIFont boldSystemFontOfSize:18];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.textColor = [UIColor darkTextColor];
    self.messageLabel.text = self.message;
    [self.view addSubview:self.messageLabel];
    
    self.doneBtn = [[UIButton alloc] init];
    [self.doneBtn setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
    [self.doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.doneBtn addTarget:self action:@selector(doneBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
    
}

- (void)doneBtnEvent {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.succesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@150);
        make.height.equalTo(@150);
    }];
    
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.equalTo(self.succesView.mas_bottom).offset(10);
//        make.top.equalTo(@200);
        make.height.equalTo(@50);
    }];
    
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).offset(10);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.equalTo(@35);
    }];
    
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
