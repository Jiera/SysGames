//
//  SGListViewController.m
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import "SGListViewController.h"

@interface SGListViewController ()

@end

@implementation SGListViewController

#pragma mark - Life Cycles

- (void)initView {
    [self.m_btnTurn setTurnClicked:YES];
    [self.m_btnScratch setScratchClicked:NO];
    [self.m_btnCard setCardClicked:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction

- (IBAction)switchView:(UIButton *)sender {
    
    BOOL isTrunClicked = NO;
    BOOL isScratchClicked = NO;
    BOOL isCardClicked = NO;
    
    if ([sender isEqual:self.m_btnTurn]) {
        [self switchDetailView:SGDetailView_Turn];
        
        isTrunClicked = YES;
        
    } else if ([sender isEqual:self.m_btnScratch]) {
        [self switchDetailView:SGDetailView_Scratch];
        
        isScratchClicked = YES;
        
    } else if ([sender isEqual:self.m_btnCard]) {
        [self switchDetailView:SGDetailView_Card];
        
        isCardClicked = YES;
    }
    
    [self.m_btnTurn setTurnClicked:isTrunClicked];
    [self.m_btnScratch setScratchClicked:isScratchClicked];
    [self.m_btnCard setCardClicked:isCardClicked];
}

@end
