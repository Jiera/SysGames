//
//  SGCore.h
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SGListViewController.h"
#import "SGScratchViewController.h"
#import "SGCardViewController.h"
#import "SGTurnViewController.h"

@interface SGCore : NSObject
@property (strong, nonatomic) UISplitViewController *m_splitViewController;
@property (strong, nonatomic) SGListViewController *m_listViewController;
@property (strong, nonatomic) SGScratchViewController *m_scratchViewController;
@property (strong, nonatomic) SGCardViewController *m_cardViewController;
@property (strong, nonatomic) SGTurnViewController *m_turnViewController;

+ (instancetype)sharedInstance;
- (void)initValue;

@end
