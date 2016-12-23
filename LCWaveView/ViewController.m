//
//  ViewController.m
//  LCWaveView
//
//  Created by 李新新 on 2016/12/23.
//  Copyright © 2016年 李新新. All rights reserved.
//

#import "ViewController.h"
#import "LCWaveView.h"
@interface ViewController ()

@property (nonatomic, strong) LCWaveView *waveView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LCWaveView *waveView = [[LCWaveView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    waveView.waterLevel = 400;
    [self.view addSubview:waveView];
    self.waveView = waveView;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.waveView wave];

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.waveView.frame = self.view.bounds;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
