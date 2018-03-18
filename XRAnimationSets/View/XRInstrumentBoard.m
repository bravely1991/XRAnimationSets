//
//  XRWorkMangeTableHeader.m
//  AutoPlus
//
//  Created by brave on 2017/10/1.
//  Copyright © 2017年 brave. All rights reserved.
//

#import "XRInstrumentBoard.h"

#define toRad(angle) ((angle) * M_PI / 180)

@interface XRInstrumentBoard ()

@property (nonatomic, assign) CGPoint dotCenter;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat pointLenth;
@property (nonatomic, strong) NSArray *stateArray;
@property (nonatomic, strong) CALayer *pointLayer;


@end

@implementation XRInstrumentBoard

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dotCenter = CGPointMake(frame.size.width/2.0, frame.size.height-20);
        self.radius = frame.size.height - 80;
        self.pointLenth = self.radius;
        self.stateArray = @[@"危险", @"普通", @"优秀"];
        self.value = 50;
        [self loadSubViews];
    }
    
    return self;
}

- (void)loadSubViews {
    
    [self drawPieWithStartAngle:-180 endAngle:-120 color:[UIColor redColor]];
    [self drawPieWithStartAngle:-120 endAngle:-60 color:[UIColor orangeColor]];
    [self drawPieWithStartAngle:-60 endAngle:0 color:XRColorRGB(142, 195, 92)];
    
    [self drawDot];
    [self drawText];
    
    [self drawPoint];

}

- (void)strokePath {
    
    CGFloat diff = (self.value - 50)/100*M_PI;
    self.pointLayer.transform = CATransform3DMakeRotation(diff, 0, 0, 1);

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 1.0f;
    animation.fromValue = @(diff);
    animation.toValue = @(M_PI_2);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.repeatCount = 1;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation2.duration = 1.0f;
    animation2.fromValue = @(M_PI_2);
    animation2.toValue = @(-M_PI_2);
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    animation2.repeatCount = 1;
    
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 1.0f;
    groupAnnimation.autoreverses = YES;
    groupAnnimation.animations = @[animation, animation2];
    groupAnnimation.repeatCount = 1;
    [self.pointLayer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
    
}

- (void)drawPieWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color {
    UIBezierPath *piePath = [UIBezierPath bezierPath];
    [piePath addArcWithCenter:self.dotCenter radius:self.radius startAngle:toRad(startAngle) endAngle:toRad(endAngle) clockwise:YES];
    
    CAShapeLayer *pieShapeLayer = [[CAShapeLayer alloc] init];
    pieShapeLayer.lineWidth = 10;
    pieShapeLayer.fillColor = nil;
    pieShapeLayer.strokeColor = color.CGColor;
    pieShapeLayer.path = [piePath CGPath];;
    [self.layer addSublayer:pieShapeLayer];
}


- (void)drawDot {
    UIBezierPath *piePath = [UIBezierPath bezierPath];
    [piePath addArcWithCenter:self.dotCenter radius:10 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer *pieShapeLayer = [[CAShapeLayer alloc] init];
    pieShapeLayer.strokeColor = nil;
    pieShapeLayer.fillColor = XRTextBlueColor.CGColor;
    pieShapeLayer.path = [piePath CGPath];;
    [self.layer addSublayer:pieShapeLayer];

}

- (void)drawPoint {
    
//    CGFloat diff = (self.value - 50)/100*M_PI;
    
    self.pointLayer = [CALayer layer];
    self.pointLayer.backgroundColor = XRTextBlueColor.CGColor;
    self.pointLayer.frame = CGRectMake(0, 0, 2, self.pointLenth);
    self.pointLayer.position = CGPointMake(self.dotCenter.x, self.dotCenter.y);
    self.pointLayer.anchorPoint = CGPointMake(0.8, 0.8);
//    self.pointLayer.transform = CATransform3DMakeRotation(diff, 0, 0, 1);
    [self.layer addSublayer:self.pointLayer];
    

    
}

- (void)drawText {
    
    for (NSInteger i=0; i<3; i++) {
        CGFloat startAngle = -150 + 60*i;
        CGPoint labelCenter = [self pointWithAngle:toRad(startAngle) radius:self.radius + 30];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        label.center = labelCenter;
        label.font = XRFont(14);
        label.backgroundColor = XRTextBlueColor;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.stateArray[i];
        label.layer.cornerRadius = 20;
        label.layer.masksToBounds = YES;
        [self addSubview:label];
    }

}

- (CGPoint)pointWithAngle:(CGFloat)angle radius:(CGFloat)radius {
    CGFloat x = self.dotCenter.x + cosf(angle) * radius;
    CGFloat y = self.dotCenter.y + sinf(angle) * radius;
    return CGPointMake(x, y);
}

@end
