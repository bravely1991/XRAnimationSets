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
@property (nonatomic, assign) CGFloat itemLabelRadius;

@property (nonatomic, strong) NSMutableArray *startAngleArray;
@property (nonatomic, strong) NSMutableArray *itemLabelCenterArray;
@property (nonatomic, strong) NSMutableArray *endAngleArray;

@property (nonatomic, strong) NSMutableArray *timeStartArray;
@property (nonatomic, strong) NSMutableArray *durationArray;

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
        self.lineWidth = 40;
        self.radius = 80;
        self.itemLabelRadius = self.radius + 50;
        self.startAngle = toRad(-90);
        self.totalDuration = 1.5f;
        
        self.showAnimation = YES;
        self.showitemLabel = YES;
    }
    
    return self;
}

- (void)strokePath {
    [self removeAllSubLayers];
    
    [self drawDefaultPie];
    [self loadSubviewLayers];
    
}

- (void)loadSubviewLayers {
    for (NSInteger i=0; i<self.itemArray.count; i++) {
        if (self.isShowAnimation) {
            NSDictionary * userInfo = @{@"index":@(i)};
            NSTimer * timer = [NSTimer timerWithTimeInterval:[self.timeStartArray[i] floatValue] target:self selector:@selector(timerAction:) userInfo:userInfo repeats:NO];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        }else {
            [self drawEachPieWithIndex:i];
        }
    }
}

#pragma mark - 定时器

- (void)timerAction:(NSTimer *)sender{
    NSInteger index = [[sender.userInfo objectForKey:@"index"] integerValue];
    [self drawEachPieWithIndex:index];
    
    [sender invalidate];
    sender = nil;
}

- (void)setValueArray:(NSMutableArray *)valueArray {
    _valueArray = valueArray;
    
    //计算开始和持续时间数组
    self.timeStartArray = [NSMutableArray array];
    self.durationArray = [NSMutableArray array];
    CGFloat startTime = 0.5f;
    [self.timeStartArray  addObject:[NSNumber numberWithFloat:startTime]];
    for (NSInteger i=0; i<valueArray.count; i++) {
        self.durationArray[i] = [NSNumber numberWithFloat:[valueArray[i] floatValue] * self.totalDuration];
        startTime += [valueArray[i] floatValue] * self.totalDuration;
        [self.timeStartArray  addObject:[NSNumber numberWithFloat:startTime]];
    }
    //计算开始和结束角度数组
    self.startAngleArray = [NSMutableArray array];
    self.endAngleArray = [NSMutableArray array];
    self.itemLabelCenterArray = [NSMutableArray array];
    CGFloat startAngle = self.startAngle, endAngle;
    for (NSInteger i=0; i<valueArray.count; i++) {
        [self.startAngleArray  addObject:[NSNumber numberWithFloat:startAngle]];
        endAngle = startAngle + [self.valueArray[i] floatValue] * 2 * M_PI;
        [self.endAngleArray  addObject:[NSNumber numberWithFloat:endAngle]];
        [self.itemLabelCenterArray addObject:[NSNumber numberWithFloat:(startAngle + (endAngle-startAngle)/2.0)]];
        
        startAngle = endAngle;
    }
}

- (void)drawDefaultPie {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = [path CGPath];
    shapeLayer.lineWidth = self.lineWidth;
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:shapeLayer];
}

- (void)drawEachPieWithIndex:(NSInteger)index {
    CGFloat startAngle = [self.startAngleArray[index] floatValue];
    CGFloat endAngle = [self.endAngleArray[index] floatValue];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:startAngle endAngle:endAngle  clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = [path CGPath];
    shapeLayer.lineWidth = self.lineWidth;
    shapeLayer.strokeColor = ((UIColor *)self.colorArray[index]).CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    if (self.isShowAnimation) {
        [shapeLayer addAnimation:[self animationWithDuration:[self.durationArray[index] floatValue]] forKey:nil];
    }
    [self.layer addSublayer:shapeLayer];
    
    if (self.isShowItemLabel) {
        [self drawEachItemLabelWithIndex:index];
    }
}

- (void)drawEachItemLabelWithIndex:(NSInteger)index {
    CGFloat centerAngle = [self.itemLabelCenterArray[index] floatValue];
    UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 45)];
    itemLabel.numberOfLines = 0;
    itemLabel.textAlignment = NSTextAlignmentCenter;
    itemLabel.font = [UIFont systemFontOfSize:14];
    itemLabel.center = [self pointWithAngle:centerAngle radius:self.itemLabelRadius];
    itemLabel.textColor = self.colorArray[index];
    
    NSString *text = [NSString stringWithFormat:@"%@\n%.2f%%",self.itemArray[index],[self.valueArray[index] floatValue]*100];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithString:text];
    [mutableString addAttribute:NSForegroundColorAttributeName
                          value:[UIColor darkGrayColor]
                          range:NSMakeRange(0, 3)];
    itemLabel.attributedText = mutableString;
    
    [self addSubview:itemLabel];
}

- (CGPoint)pointWithAngle:(CGFloat)angle radius:(CGFloat)radius {
    CGFloat x = self.centerPoint.x + cosf(angle) * radius;
    CGFloat y = self.centerPoint.y + sinf(angle) * radius;
    return CGPointMake(x, y);
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

@end
