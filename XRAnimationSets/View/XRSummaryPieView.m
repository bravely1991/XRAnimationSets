//
//  XRSummaryPieView.m
//  XRAnimationSets
//
//  Created by brave on 2017/9/20.
//  Copyright © 2017年 brave. All rights reserved.
//

#import "XRSummaryPieView.h"

@interface XRSummaryPieView ()

@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, assign) CGFloat itemLabelRadius;

@property (nonatomic, strong) NSMutableArray *startAngleArray;
@property (nonatomic, strong) NSMutableArray *itemLabelCenterArray;
@property (nonatomic, strong) NSMutableArray *endAngleArray;

@property (nonatomic, strong) NSMutableArray *timeStartArray;
@property (nonatomic, strong) NSMutableArray *durationArray;

@property (nonatomic, strong) NSMutableArray *percentArray;

@end


#define toRad(angle) (angle * M_PI / 180)

@implementation XRSummaryPieView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        self.lineWidth = 30;
        self.radius = 40;
        self.centerPoint = CGPointMake(frame.size.width - self.radius - self.lineWidth/2 - 20, frame.size.height/2);

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
    [self drawPieLegend];
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
    
    double totalValue = 0;
    for (NSInteger i=0; i<valueArray.count; i++) {
        totalValue += [valueArray[i] floatValue];
    }
    
    self.percentArray = [NSMutableArray array];
    for (NSInteger i=0; i<valueArray.count; i++) {
        NSString *percent = [NSString stringWithFormat:@"%f",[valueArray[i] floatValue]/totalValue];
        [self.percentArray addObject:percent];
    }
    
    //计算开始和持续时间数组
    self.timeStartArray = [NSMutableArray array];
    self.durationArray = [NSMutableArray array];
    CGFloat startTime = 0.5f;
    [self.timeStartArray  addObject:[NSNumber numberWithFloat:startTime]];
    for (NSInteger i=0; i<valueArray.count; i++) {
        self.durationArray[i] = [NSNumber numberWithFloat:[self.percentArray[i] floatValue] * self.totalDuration];
        startTime += [self.percentArray[i] floatValue] * self.totalDuration;
        [self.timeStartArray  addObject:[NSNumber numberWithFloat:startTime]];
    }
    //计算开始和结束角度数组
    self.startAngleArray = [NSMutableArray array];
    self.endAngleArray = [NSMutableArray array];
    self.itemLabelCenterArray = [NSMutableArray array];
    CGFloat startAngle = self.startAngle, endAngle;
    for (NSInteger i=0; i<valueArray.count; i++) {
        [self.startAngleArray  addObject:[NSNumber numberWithFloat:startAngle]];
        endAngle = startAngle + [self.percentArray[i] floatValue] * 2 * M_PI;
        [self.endAngleArray  addObject:[NSNumber numberWithFloat:endAngle]];
        [self.itemLabelCenterArray addObject:[NSNumber numberWithFloat:(startAngle + (endAngle-startAngle)/2.0)]];
        
        startAngle = endAngle;
    }
    
}

- (void)drawPieLegend {
    CGFloat width = 100;
    CGFloat height = 25;
    CGFloat x = 20;
    CGFloat y = (self.bounds.size.height - self.itemArray.count*height)/2.0;
    for (NSInteger i = 0; i<self.itemArray.count; i++) {
        CGFloat itemY = y + height*i;
        
        CGFloat colorWidthHeight = 10;
        CGFloat maginY = (height - colorWidthHeight)/2.0;
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(x, itemY+maginY, colorWidthHeight, colorWidthHeight)];
        colorView.backgroundColor = self.colorArray[i];
        [self addSubview:colorView];
        
        CGFloat labelWidth = 50;
        CGFloat labelMaginX = 10;
        UILabel *legendLabel = [[UILabel alloc] initWithFrame:CGRectMake(x+colorWidthHeight+labelMaginX, itemY, labelWidth, height)];
//        legendLabel.text = self.itemArray[i];
        legendLabel.textColor = [UIColor darkGrayColor];
        legendLabel.font = XRFont(14);
        
        NSString *item = self.itemArray[i];
        CGSize size = [item boundingRectWithSize:CGSizeMake(labelWidth,MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName :legendLabel.font}  context:nil].size;
        CGFloat margin = (labelWidth - size.width)/(item.length - 1);
        NSNumber *number = [NSNumber  numberWithFloat:margin];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:item];
        [attribute  addAttribute:NSKernAttributeName value:number range:NSMakeRange(0,item.length -1 )];
        legendLabel.attributedText = attribute;
        [self addSubview:legendLabel];
        
        CGFloat valueLabelX = legendLabel.frame.origin.x + legendLabel.frame.size.width + 15;
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(valueLabelX, itemY, width, height)];
        valueLabel.text = self.valueArray[i];
        valueLabel.font = XRFont(14);
        valueLabel.textColor = [UIColor blackColor];
        [self addSubview:valueLabel];
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
