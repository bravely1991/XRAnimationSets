//
//  XRAnnularPieView.m
//  XRAnnularPieView
//
//  Created by brave on 2017/9/9.
//  Copyright © 2017年 brave. All rights reserved.
//

#import "XRAnnularPieView.h"

@interface XRAnnularPieView ()


@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat imageRadius;
@property (nonatomic, assign) CGFloat lineWidth;


@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;

@property (nonatomic, strong) CAShapeLayer *maskLayer;


@end


#define toRad(angle) (angle * M_PI / 180)

@implementation XRAnnularPieView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.centerPoint = CGPointMake(frame.size.width/2, frame.size.height/2);
        self.imageRadius = 40;
        self.lineWidth = 60;
        self.radius = self.imageRadius + self.lineWidth/2;
        self.startAngle = toRad(-90);
        
        self.colorArray = [NSMutableArray arrayWithObjects:[UIColor colorWithRed:241/255.0 green:90/255.0 blue:85/255.0 alpha:1], [UIColor colorWithRed:221/255.0 green:222/255.0 blue:223/255.0 alpha:1], nil];
    }
    
    return self;
}

- (void)strokePath {
    [self removeAllSubLayers];
    [self loadSubviewLayers];
}

- (void)loadSubviewLayers {
    
    [self drawDefaultPie];
    
    [self drawEachPieShapeLayer:0];

    
    [self drawImage];
    [self drawWhiteColor];
}

- (void)drawDefaultPie {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = [path CGPath];
    shapeLayer.lineWidth = self.lineWidth;
    shapeLayer.strokeColor = ((UIColor *)self.colorArray[1]).CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:shapeLayer];

}

- (void)drawEachPieShapeLayer:(NSInteger)index {
   _endAngle = _startAngle + [self.valueArray[index] floatValue] * 2 * M_PI;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:_startAngle endAngle:_endAngle  clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = [path CGPath];
    shapeLayer.lineWidth = self.lineWidth;
    shapeLayer.strokeColor = ((UIColor *)self.colorArray[index]).CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillAnimation.duration = 1.0f;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue = @(0.f);
    fillAnimation.toValue = @(1.f);
    
    [shapeLayer addAnimation:fillAnimation forKey:@"fillAnimation"];
    
    [self.layer addSublayer:shapeLayer];
    
    CGFloat centerAngle = _startAngle + (_endAngle - _startAngle)/2.0;
    [self drawEachItemLabelWithCenterAngle:centerAngle index:index];
    
    _startAngle = _endAngle;
    
    
    _endAngle = _startAngle + [self.valueArray[index] floatValue] * 2 * M_PI;
    CGFloat centerAngle2 = 2*M_PI - (toRad(-90) + _endAngle);
    [self drawEachItemLabelWithCenterAngle:centerAngle2 index:1];
    
}

- (void)drawEachPieWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle index:(NSInteger)index {
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:self.centerPoint];
    [bezier addArcWithCenter:self.centerPoint radius:self.radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = bezier.CGPath;
    shapeLayer.fillColor = ((UIColor *)self.colorArray[index]).CGColor;
    
    
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillAnimation.duration = 1.0f;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue = @(0.f);
    fillAnimation.toValue = @(1.f);
    
    [shapeLayer addAnimation:fillAnimation forKey:@"fillAnimation"];
    
    [self.layer addSublayer:shapeLayer];
    
    
}

- (void)drawEachItemLabelWithCenterAngle:(CGFloat)centerAngle index:(NSInteger)index {
    
    UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 45)];
    itemLabel.numberOfLines = 0;
//    itemLabel.textAlignment = index == 0 ? NSTextAlignmentRight:NSTextAlignmentLeft;
    itemLabel.textAlignment = NSTextAlignmentCenter;
    itemLabel.font = [UIFont systemFontOfSize:14];
    itemLabel.center = [self pointWithAngle:centerAngle radius:self.radius + 60];
    itemLabel.textColor = index == 0 ? self.colorArray[index]:[UIColor blackColor];
    
    NSString *text = [NSString stringWithFormat:@"%@\n%.2f%%",self.itemArray[index],[self.valueArray[index] floatValue]*100];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithString:text];
    [mutableString addAttribute:NSForegroundColorAttributeName
                          value:[UIColor darkGrayColor]
                          range:NSMakeRange(0, 3)];
    itemLabel.attributedText = mutableString;
    
    [self addSubview:itemLabel];
}

- (void)removeAllSubLayers{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    
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

- (void)drawImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imageRadius*2, self.imageRadius*2)];
    imageView.image = [UIImage imageNamed:@"60-2"];
    imageView.layer.cornerRadius = self.imageRadius;
    imageView.layer.masksToBounds = YES;
    imageView.center = self.centerPoint;
    [self addSubview:imageView];
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier addArcWithCenter:self.centerPoint radius:self.imageRadius+3 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = bezier.CGPath;
    shapeLayer.lineWidth = 6;
    shapeLayer.strokeColor = [UIColor colorWithWhite:1 alpha:0.3].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:shapeLayer];

}

- (void)drawWhiteColor {
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier addArcWithCenter:self.centerPoint radius:self.imageRadius+20 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = bezier.CGPath;
    shapeLayer.lineWidth = 2.5;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:shapeLayer];
}

- (CGPoint)pointWithAngle:(CGFloat)angle radius:(CGFloat)radius {
    CGFloat x = self.centerPoint.x + cosf(angle) * radius;
    CGFloat y = self.centerPoint.y + sinf(angle) * radius;
    return CGPointMake(x, y);
}

@end
