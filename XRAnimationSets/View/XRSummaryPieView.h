//
//  XRSummaryPieView.h
//  XRAnimationSets
//
//  Created by brave on 2017/9/20.
//  Copyright © 2017年 brave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRSummaryPieView : UIView


@property (nonatomic, strong) NSMutableArray *valueArray;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) NSMutableArray *colorArray;

@property (nonatomic, assign) CGFloat totalDuration;
@property (nonatomic, assign) CGFloat startAngle;

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign, getter=isShowAnimation) BOOL showAnimation;
@property (nonatomic, assign, getter=isShowItemLabel) BOOL showitemLabel;


- (void)strokePath;


@end
