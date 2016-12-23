//
//  LCWaveView.m
//  LCWaveView
//
//  Created by 李新新 on 2016/12/23.
//  Copyright © 2016年 李新新. All rights reserved.
//

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#import "LCWaveView.h"

@interface LCWaveView()

@property (nonatomic, strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer *secondWaveLayer;
@property (nonatomic, strong) CAShapeLayer *thirdWaveLayer;
@property (nonatomic, strong) CADisplayLink *waveDisplayLink;
@property (nonatomic, assign) CGFloat waveOffset;

@end

@implementation LCWaveView

- (CAShapeLayer *)firstWaveLayer {
    if (nil == _firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = self.waveColor.CGColor;
        [self.layer addSublayer:_firstWaveLayer];
    }
    return _firstWaveLayer;
}
- (CAShapeLayer *)secondWaveLayer {
    if (nil == _secondWaveLayer) {
        _secondWaveLayer = [CAShapeLayer layer];
        _secondWaveLayer.fillColor = self.waveColor.CGColor;
        [self.layer addSublayer:_secondWaveLayer];
    }
    return _secondWaveLayer;
}
- (CAShapeLayer *)thirdWaveLayer {
    if (nil == _thirdWaveLayer) {
        _thirdWaveLayer = [CAShapeLayer layer];
        _thirdWaveLayer.fillColor = self.waveColor.CGColor;
        [self.layer addSublayer:_thirdWaveLayer];
    }
    return _thirdWaveLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultSetup];
    }
    return self;
}
- (CADisplayLink *)waveDisplayLink  {
    if (nil == _waveDisplayLink) {
        _waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWaveCurve)];
    }
    return _waveDisplayLink;
}

- (void)getCurrentWaveCurve {
    _waveOffset += _waveSpeed;
    [self updateWaveCurve];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self defaultSetup];
}

- (void)defaultSetup {
    self.backgroundColor = [UIColor blackColor];
    _waveAmlitude = 13;
    _waveColor = rgba(255, 255, 255,0.1);
    _waveSpeed = 0.25 / M_PI;
    _waveOffset = 0;
    self.waterLevel = 50;
}

- (UIBezierPath *)wavePathWithWaveXOffset:(CGFloat)xOffset
                                  yOffSet:(CGFloat)yOffSet
                           amlitudeOffSet:(CGFloat)amlitudeOffSet{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, self.waterLevel)];
    for (CGFloat x = 0.0f; x < CGRectGetWidth(self.bounds); x++) {
        CGFloat y = (self.waveAmlitude + amlitudeOffSet) * sin(1.29 * M_PI / CGRectGetWidth(self.bounds) * x + _waveOffset + xOffset) + CGRectGetHeight(self.bounds) - self.waterLevel - self.waveAmlitude / 2.0 + yOffSet;
        [bezierPath addLineToPoint:CGPointMake(x, y)];
    }
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    [bezierPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
    [bezierPath closePath];
    return bezierPath;
}

- (void)updateWaveCurve {
    self.firstWaveLayer.path = [self wavePathWithWaveXOffset:-10 yOffSet:10 amlitudeOffSet: 0].CGPath;
    self.secondWaveLayer.path = [self wavePathWithWaveXOffset:0 yOffSet:0 amlitudeOffSet: -2].CGPath;
    self.thirdWaveLayer.path = [self wavePathWithWaveXOffset:20 yOffSet:-10 amlitudeOffSet: 2].CGPath;
}

#pragma mark
#pragma mark - 动画控制
- (void)wave {
    [self updateWaveCurve];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop {
    [self.waveDisplayLink invalidate];
    self.waveDisplayLink = nil;
}

@end
