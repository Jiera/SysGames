//
//  SGScratchViewController.h
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGScratchViewController : SGBaseViewController

@property (nonatomic, strong) IBOutlet UIImageView *m_ivBackground;
@property (nonatomic, strong) IBOutlet UIView *m_coverView;
@property (nonatomic, strong) IBOutlet UIButton *m_btnReplay;

- (IBAction)clickReplay:(UIButton *)sender;

@end
