//
//  LCWaveView.h
//  LCWaveView
//
//  Created by 李新新 on 2016/12/23.
//  Copyright © 2016年 李新新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCWaveView : UIView

@property (nonatomic, assign) CGFloat waveAmlitude; //波浪浪高 默认 13
@property (nonatomic, assign) CGFloat waterLevel;   //水平面  默认 50 波浪与View底部偏移距离
@property (nonatomic, assign) CGFloat waveSpeed;    //波浪速度 默认 M_PI/4
@property (nonatomic, strong) UIColor *waveColor;   //波浪颜色 默认 rgba(255, 255, 255,0.1);

- (void)wave;
- (void)stop;

@end
