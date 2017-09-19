//
//  XRSuccessView.h
//  XRAnnularPieView
//
//  Created by brave on 2017/9/19.
//  Copyright © 2017年 brave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRSuccessView : UIView

@property (nonatomic, assign) BOOL showAnimation;
@property (nonatomic, assign) CGFloat animationDuration;

- (void)strokePath;

@end
