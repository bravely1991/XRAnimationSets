//
//  XRSuccessView.m
//  XRAnnularPieView
//
//  Created by brave on 2017/9/19.
//  Copyright © 2017年 brave. All rights reserved.
//

#import "XRSuccessView.h"

@interface XRSuccessView ()

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGPoint centerPoint;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat hight;

@end

#define ToRad(angle) (angle*M_PI/180)

@implementation XRSuccessView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.radius = 55;
        self.centerPoint = self.center;
        self.width = frame.size.width;
        self.hight = frame.size.height;
        self.showAnimation = YES;
        self.animationDuration = 1.0f;

    }
    
    return self;
}

- (void)strokePath {
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    
    [self drawCircle];
    [self drawSuccess];

}

- (void)drawCircle {
    UIBezierPath *circlePath = [[UIBezierPath alloc] init];
    [circlePath addArcWithCenter:self.centerPoint radius:self.radius startAngle:-M_PI_2 endAngle:-(2*M_PI+M_PI_2) clockwise:NO];
    
    CAShapeLayer *circleLayer = [[CAShapeLayer alloc] init];
    circleLayer.lineWidth = 5;
    circleLayer.fillColor = nil;
    circleLayer.strokeColor = [UIColor colorWithRed:250/255.0 green:223/255.0 blue:226/255.0 alpha:1].CGColor;
    circleLayer.path = circlePath.CGPath;
    
    if (self.showAnimation) {
        CABasicAnimation *clockAnimation = [self animationWithDuration:self.animationDuration];
        [circleLayer addAnimation:clockAnimation forKey:nil];
    }
    
    [self.layer addSublayer:circleLayer];
}

- (void)drawSuccess {
    UIBezierPath *successPath = [[UIBezierPath alloc] init];
    [successPath moveToPoint:CGPointMake(self.width*0.33, self.hight*0.52)];
    [successPath addLineToPoint:CGPointMake(self.width*0.48, self.hight*0.65)];
    [successPath addLineToPoint:CGPointMake(self.width*0.7, self.hight*0.4)];
    
    CAShapeLayer *successLayer = [CAShapeLayer layer];
    successLayer.lineWidth = 15;
    successLayer.fillColor = nil;
    successLayer.strokeColor = [UIColor colorWithRed:211/255.0 green:57/255.0 blue:72/255.0 alpha:1].CGColor;
    successLayer.lineCap = kCALineCapRound;
    successLayer.lineJoin = kCALineJoinRound;
    successLayer.path = successPath.CGPath;
    
    if (self.showAnimation) {
        CABasicAnimation *clockAnimation = [self animationWithDuration:self.animationDuration];
        [successLayer addAnimation:clockAnimation forKey:nil];
    }
    
    [self.layer addSublayer:successLayer];

}


- (CABasicAnimation *)animationWithDuration:(CGFloat)duraton {
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillAnimation.duration = duraton;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue = @(0.f);
    fillAnimation.toValue = @(1.f);
    return fillAnimation;
}

@end
