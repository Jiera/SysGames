//
//  SGBaseViewController.m
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import "SGBaseViewController.h"
#import "SGCore.h"

@interface SGBaseViewController ()

@end

@implementation SGBaseViewController

#pragma mark - Life Cycles

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Public Methods

- (void)switchDetailView:(SGDetailView)detailView
{
    if (SGDetailView_Scratch == detailView) {
        [[[SGCore sharedInstance] m_splitViewController] showDetailViewController:[[SGCore sharedInstance] m_scratchViewController] sender:self];
        
    } else if (SGDetailView_Card == detailView) {
        [[[SGCore sharedInstance] m_splitViewController] showDetailViewController:[[SGCore sharedInstance] m_cardViewController] sender:self];
        
    } else if (SGDetailView_Turn == detailView) {
        [[[SGCore sharedInstance] m_splitViewController] showDetailViewController:[[SGCore sharedInstance] m_turnViewController] sender:self];
    }
}

#pragma mark - Private Methods

@end
