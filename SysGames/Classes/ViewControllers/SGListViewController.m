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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction

- (IBAction)clickScratch:(UIButton *)sender {
    [self switchDetailView:SGDetailView_Scratch];
}

- (IBAction)clickCard:(UIButton *)sender {
    [self switchDetailView:SGDetailView_Card];
}

- (IBAction)clickTurn:(UIButton *)sender {
    [self switchDetailView:SGDetailView_Turn];
}

#pragma mark - Private Methods

@end
