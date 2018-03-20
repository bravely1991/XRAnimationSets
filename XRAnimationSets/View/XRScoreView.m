//
//  XRScoreView.m
//  XRAnimationSets
//
//  Created by brave on 2018/3/18.
//  Copyright © 2018年 brave. All rights reserved.
//

#import "XRScoreView.h"

@interface XRScoreView ()

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGPoint centerPoint;

@property (nonatomic, strong) UILabel *scoreValueLabel;
@property (nonatomic, assign) CGFloat currentScore;

@end


@implementation XRScoreView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.radius = 100;
        self.centerPoint = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
        self.showAnimation = YES;
        self.animationDuration = 1.0f;
        self.maxScore = 100;
        self.score = 60;
    }
    return self;
}

- (void)strokePath {
    [self removeAllSubLayers];
    
    [self drawBackGrayCircle];
    [self drawCircle];
    [self loadNoteInfo];
}

- (void)drawBackGrayCircle {
    UIBezierPath *circlePath = [[UIBezierPath alloc] init];
    [circlePath addArcWithCenter:self.centerPoint radius:self.radius startAngle:-M_PI_2 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer *circleLayer = [[CAShapeLayer alloc] init];
    circleLayer.lineWidth = 10;
    circleLayer.fillColor = nil;
    circleLayer.strokeColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1].CGColor;
    circleLayer.path = circlePath.CGPath;
    
    [self.layer addSublayer:circleLayer];
}


- (void)drawCircle {
    UIBezierPath *circlePath = [[UIBezierPath alloc] init];
    CGFloat endAngle = self.score/self.maxScore * 2 * M_PI - M_PI_2;
    [circlePath addArcWithCenter:self.centerPoint radius:self.radius startAngle:-M_PI_2 endAngle:endAngle clockwise:YES];

    CAShapeLayer *circleLayer = [[CAShapeLayer alloc] init];
    circleLayer.lineWidth = 14;
    circleLayer.fillColor = nil;
    circleLayer.strokeColor = [UIColor redColor].CGColor;
    circleLayer.path = circlePath.CGPath;
    circleLayer.lineCap = kCALineCapRound;
    
    if (self.showAnimation) {
        CABasicAnimation *clockAnimation = [self animationWithDuration:self.animationDuration];
        [circleLayer addAnimation:clockAnimation forKey:nil];
    }
    
    [self.layer addSublayer:circleLayer];
}


- (void)loadNoteInfo {
    self.scoreValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.radius, 50)];
    self.scoreValueLabel.font = [UIFont systemFontOfSize:36];
    self.scoreValueLabel.textColor = [UIColor blackColor];
    self.scoreValueLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreValueLabel.center = self.centerPoint;
    [self addSubview:self.scoreValueLabel];
    
    if (self.showAnimation) {
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateScore:)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }else {
        self.scoreValueLabel.text = [NSString stringWithFormat:@"%.1f",self.score];
    }
}

- (void)updateScore:(CADisplayLink *)displayLink {
    self.currentScore += 1.0;
    
    if (self.currentScore >= self.score) {
        [displayLink invalidate];
        self.scoreValueLabel.text = [NSString stringWithFormat:@"%.1f",self.score];
    }else {
        self.scoreValueLabel.text = [NSString stringWithFormat:@"%.1f",self.currentScore];
    }
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

- (void)removeAllSubLayers{
    NSArray * subviews = [NSArray arrayWithArray:self.subviews];
    for (UIView * view in subviews) {
        [view removeFromSuperview];
    }
    
    NSArray * subLayers = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer * layer in subLayers) {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
}

@end
