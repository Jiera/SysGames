//
//  SGCardViewController.m
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import "SGCardViewController.h"
#import "CardGameView.h"


@interface SGCardViewController ()
@property (strong, nonatomic) IBOutlet UIButton *m_btnReplay;
@property (strong, nonatomic) IBOutlet UIView *m_cardView;
@property (strong, nonatomic) CardGameView *m_gameView;
@property (strong, nonatomic) NSMutableArray *m_aryCardItems;
@end

@implementation SGCardViewController

#pragma mark - Life Cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    self.m_aryCardItems = [[NSMutableArray alloc]init];
    
    [self.m_btnReplay updateGreenButton:@"再玩一次"];
    self.m_btnReplay.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.view layoutIfNeeded];
    [self.m_cardView layoutIfNeeded];
    
    if (self.m_aryCardItems.count == 0) {
        [self initCardView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods

- (void)shuffleList:(NSMutableArray *)ary {
    NSUInteger count = [ary count];
    if (count < 1) return;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [ary exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

- (void)configureItemList {
    [self.m_aryCardItems removeAllObjects];
    
    NSMutableArray *aryCardFileName = [[NSMutableArray alloc]init];
    
    for (int i = 1 ; i <= 4 ; i++) {
        [aryCardFileName addObject:[NSString stringWithFormat:@"%02d",i]];
        [aryCardFileName addObject:[NSString stringWithFormat:@"%02d",i]];
    }

    [self shuffleList:aryCardFileName];
    
    
    [aryCardFileName insertObject:@"00" atIndex:4];
    
    NSLog(@"%@",aryCardFileName);

    NSString *strFileName;
    CardItem *item;
    UIImage *front;
    UIImage *back;
    
    for (int i = 0 ; i < aryCardFileName.count ; i++) {
        strFileName = aryCardFileName[i];
        
        front = [UIImage imageNamed:strFileName];
        back = i == 4 ? [UIImage imageNamed:@"00"] : [UIImage imageNamed:@"cardback"];
        
        item = [[CardItem alloc]initCardItemWithCardImage:front coverImage:back cardID:[strFileName intValue]];
        
        if (i == 4) {
            item.userInteractionEnabled = NO;
        }
        
        [self.m_aryCardItems addObject:item];
    }
}

- (IBAction)handleRestart:(id)sender {
    [self initCardView];
}

- (void)initCardView {
    self.m_btnReplay.hidden = YES;
    
    if (self.m_gameView != nil) {
        [self.m_gameView removeFromSuperview];
    }

    self.m_gameView = [[CardGameView alloc]initWithFrame:CGRectMake(100, 0, self.m_cardView.frame.size.width, self.m_cardView.frame.size.height)];
    
    [self configureItemList];
    [self.m_gameView initCardGameViewWithImages:self.m_aryCardItems gameType:kCardMatch3x3];
    [self.m_cardView addSubview:self.m_gameView];
    
    __weak SGCardViewController *weakSelf = self;
    
    self.m_gameView.handleFinishedGame = ^ {
        weakSelf.m_btnReplay.hidden = NO;
    };
    
    self.m_gameView.handleFlipCard = ^(int cardId){
    };
}

@end
