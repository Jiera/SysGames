//
//  SGScratchViewController.m
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import "SGScratchViewController.h"
#import "HYScratchCardView.h"

@interface SGScratchViewController ()
@property (nonatomic, strong) HYScratchCardView *m_scratchCardView;
@end

@implementation SGScratchViewController

#pragma mark - Life Cycles

- (void)initValue {
}

- (void)initView {
    [self initValue];
    
    self.m_ivBackground.image = [UIImage imageNamed:kFile_ScratchBackground];
    [self.m_btnReplay updateGreenButton:@"再玩一次"];
    [self setScratchView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction

- (IBAction)clickReplay:(UIButton *)sender {
    [self setScratchView];
}

#pragma mark - Private Methods

- (void)setScratchView {
    
    __block SGScratchViewController *weakSelf = self;
   
    int rndValue = 1 + arc4random() % (100 - 1);
    NSString *igName = kFile_ScratchImage1;
    
    if (1 == rndValue%2) {
        igName = kFile_ScratchImage2;
    }
    
    if (self.m_scratchCardView) {
        [self.m_scratchCardView removeFromSuperview];
    }
    
    self.m_btnReplay.hidden = YES;
    self.m_scratchCardView = [[HYScratchCardView alloc] initWithFrame:self.m_coverView.frame];
    self.m_scratchCardView.image = [UIImage imageNamed:igName];
    self.m_scratchCardView.surfaceImage = [UIImage imageNamed:kFile_ScratchMask];
    self.m_scratchCardView.completion = ^(NSString *scratchId) {
        weakSelf.m_btnReplay.hidden = NO;
    };
    
    [self.view addSubview:self.m_scratchCardView];
    [self.view bringSubviewToFront:self.m_scratchCardView];
}

@end
