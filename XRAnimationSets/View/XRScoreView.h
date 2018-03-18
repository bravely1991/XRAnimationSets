//
//  XRScoreView.h
//  XRAnimationSets
//
//  Created by brave on 2018/3/18.
//  Copyright © 2018年 brave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRScoreView : UIView

@property (nonatomic, assign) BOOL showAnimation;
@property (nonatomic, assign) CGFloat animationDuration;

@property (nonatomic, assign) CGFloat maxScore;
@property (nonatomic, assign) CGFloat score;

- (void)strokePath;

@end
