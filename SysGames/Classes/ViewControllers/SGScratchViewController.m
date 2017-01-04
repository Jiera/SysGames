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
}

- (void)updateView {
    
    if (!self.m_scratchCardView) {
        self.m_scratchCardView = [[HYScratchCardView alloc] initWithFrame:self.m_coverView.frame];
        
        [self.view addSubview:self.m_scratchCardView];
        [self.view bringSubviewToFront:self.m_scratchCardView];
    }
    
    self.m_scratchCardView.image = [UIImage imageNamed:kFile_ScratchImage];
    self.m_scratchCardView.surfaceImage = [UIImage imageNamed:kFile_ScratchMask];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods

@end
