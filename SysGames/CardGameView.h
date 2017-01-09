//
//  CardGameView.h
//  MemoryCardDemo
//
//  Created by Chen Yu-Chun on 2015/10/13.
//  Copyright (c) 2015年 JaN. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCardMatch3x3 8
#define kCardMatch4x3 12
#define isLargerPhone() (([UIScreen mainScreen].bounds.size.height > 480) && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

typedef void(^HandleFinishedGame)(void);
typedef void(^HandleFlipCard)(int cardId);

@interface CardItem : UIButton

@property (nonatomic, assign) int m_iCardID;
@property (nonatomic, strong) UIImage *m_imageCard;
@property (nonatomic, strong) UIImage *m_imageCover;

- (instancetype)initCardItemWithCardImage:(UIImage*)imageCard
                               coverImage:(UIImage*)imageCover
                                   cardID:(int)cardID;

@end

@interface CardGameView : UIView
@property (nonatomic, assign) int m_iCardType;
@property (copy ,nonatomic) HandleFinishedGame handleFinishedGame;
@property (copy ,nonatomic) HandleFlipCard handleFlipCard;

- (void)initCardGameViewWithImages:(NSArray*)aryItems gameType:(int)iGameType;
-(void)restart;
@end
