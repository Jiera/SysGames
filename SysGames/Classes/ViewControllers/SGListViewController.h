//
//  SGListViewController.h
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGListViewController : SGBaseViewController

@property (nonatomic, strong) IBOutlet UIButton *m_btnTurn;
@property (nonatomic, strong) IBOutlet UIButton *m_btnScratch;
@property (nonatomic, strong) IBOutlet UIButton *m_btnCard;

- (IBAction)switchView:(UIButton *)sender;

@end
