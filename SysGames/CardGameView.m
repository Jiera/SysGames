//
//  CardGameView.m
//  MemoryCardDemo
//
//  Created by Chen Yu-Chun on 2015/10/13.
//  Copyright (c) 2015年 JaN. All rights reserved.
//
#import "CardGameView.h"

@implementation CardItem


- (instancetype)initCardItemWithCardImage:(UIImage*)imageCard
                               coverImage:(UIImage*)imageCover
                                   cardID:(int)cardID
{
    
    if (self = [super init]) {
        self.m_iCardID = cardID;
        self.m_imageCard = imageCard;
        self.m_imageCover = imageCover;
        self.adjustsImageWhenHighlighted = NO;
    }
    
    return self;
}
@end


@interface CardGameView()
@property (strong, nonatomic) NSMutableArray *m_aryItems;
@property (strong, nonatomic) NSMutableArray *m_aryCompare;
@property (strong, nonatomic) NSMutableArray *m_aryFrontButtons;
@property (strong, nonatomic) UIImage *m_imageBackground;
@property (strong, nonatomic) CardItem *m_btCompare;
@property (assign, nonatomic) BOOL m_bIsOpenning;
@property (assign, nonatomic) int m_iLeftCard;

@end

@implementation CardGameView

#pragma mark - Init
- (void)initCardGameViewWithImages:(NSArray*)aryItems gameType:(int)iGameType
{
    // (320-(4*78+5*3))/2
    // (320-(3*width+5*2))/2
    self.m_aryCompare = [[NSMutableArray alloc]init];
    self.m_aryItems = [aryItems mutableCopy];
    self.m_iLeftCard = iGameType == kCardMatch3x3?(int)aryItems.count-1:(int)aryItems.count;
    
    CGFloat width  = iGameType == kCardMatch3x3?160:70;
    CGFloat height = iGameType == kCardMatch3x3?240:93;
    int iLine = iGameType == kCardMatch3x3?3:4;
    int iPadding = 5;
    CGFloat x = 0;
    CGFloat y = iGameType == kCardMatch3x3?0:20;
    CGFloat temp = 5 + width;
    CGFloat startX = 0;
    
    if (isLargerPhone() == NO) {
        width = (width*3.5)/4;
        height = (height*3.5)/4;
        iPadding = (iPadding*3.5)/4;
        startX = 18;
        temp = 5 + width;
    }
    
    int iCount = (int)self.m_aryItems.count;
    self.m_imageBackground = [UIImage imageNamed:@"cardback"];
    NSLog(@"count:%d",iCount);
    
    for (int i = 0 ; i < iCount ; i++) {
        
        CardItem *item = self.m_aryItems[i];
        x = i * temp + iPadding + startX;
        // 換行
        if(i >= iLine) {
            x = (i%iLine)*temp + iPadding + startX; //
            if(i%iLine==0) {
                y = y + height+2;
            }
        }
        
        CGRect cardFrame = CGRectMake(x, y, width, height);
        item.frame = cardFrame;
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [item addTarget:self action:@selector(handleOpen:) forControlEvents:UIControlEventTouchUpInside];
        
        [item setImage:item.m_imageCover forState:UIControlStateNormal];

        [self addSubview:item];
    }
}
#pragma mark - Private Method
- (void)handleOpen:(CardItem *)btn {
    if (self.m_btCompare == btn) {
        return;
    }
    
    if (self.m_bIsOpenning == YES) {
        return;
    }
    
    [self FlipCardToFront:btn WithCompletionHandler:^{
        [self.m_aryCompare addObject:[NSNumber numberWithInt:btn.m_iCardID]];
        
        if (self.m_aryCompare.count == 2) {
            int firstIndex  = [[self.m_aryCompare objectAtIndex:0]intValue];
            int secondIndex = [[self.m_aryCompare objectAtIndex:1]intValue];
            
            if (firstIndex == secondIndex) {
                NSLog(@"bingo !");
                [self.m_aryFrontButtons addObject:self.m_btCompare];
                [self.m_aryFrontButtons addObject:btn];
                self.m_btCompare.userInteractionEnabled = NO;
                btn.userInteractionEnabled = NO;
                
                if (self.handleFlipCard) {
                    self.handleFlipCard(firstIndex);
                }

                if (self.m_iLeftCard != 0) {
                    self.m_iLeftCard-=2;
                    NSLog(@"LeftCard = %d",self.m_iLeftCard);
                }
                
                if (self.m_iLeftCard == 0) {
                    if (self.handleFinishedGame) {
                        self.handleFinishedGame();
                    }
                }
            }
            else {
                [NSThread sleepForTimeInterval:0.4f];
                [self FlipCardToBack:btn];
                [self FlipCardToBack:self.m_btCompare];
            }
            
            [self.m_aryCompare removeAllObjects];
        }
        else {
            self.m_btCompare = btn;
        }
    }];

}
-(void)FlipCardToFront:(CardItem*)btn WithCompletionHandler:(void (^)(void))completion {
    
    self.m_bIsOpenning = YES;
    CABasicAnimation *animation = [CABasicAnimation   animationWithKeyPath:@"transform.rotation.y"];
    [CATransaction begin];
    
    [CATransaction setCompletionBlock:^{
        [btn setImage:btn.m_imageCard forState:UIControlStateNormal];
        [CATransaction begin];
        [btn.layer addAnimation:animation forKey:@"b"];
        [CATransaction setCompletionBlock:^{
            self.m_bIsOpenning = NO;
            
            if(completion != nil) {
                completion();
            }
        }];
        [CATransaction commit];

    }];
    
    animation.duration = 0.1;
    animation.additive = YES;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:M_PI/2+0.1f];
    
    [btn.layer addAnimation:animation forKey:@"c"];
    [CATransaction commit];
}

-(void)FlipCardToBack:(CardItem*)btn {
    
    self.m_bIsOpenning = YES;
    CABasicAnimation *animation = [CABasicAnimation   animationWithKeyPath:@"transform.rotation.y"];
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [btn setImage:self.m_imageBackground forState:UIControlStateNormal];
        [btn.layer addAnimation:animation forKey:@"b"];
        btn.userInteractionEnabled = YES;
        self.m_bIsOpenning = NO;
        self.m_btCompare = nil;
    }];
    
    animation.duration = 0.1;
    animation.additive = YES;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSNumber numberWithFloat:M_PI/2+0.1f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    
    [btn.layer addAnimation:animation forKey:@"c"];
    [CATransaction commit];
}

#pragma mark - Public Method

-(void)pause {
    if(self.m_aryItems != nil) {
        for(CardItem *btn in self.m_aryItems) {
            btn.userInteractionEnabled = NO;
        }
    }
}

-(void)resume {
    if(self.m_aryItems != nil) {
        for(CardItem *btn in self.m_aryItems) {
            btn.userInteractionEnabled = YES;
        }
    }
}

-(void)restart {
    if(self.m_bIsOpenning == YES) {
        return;
    }

    [self resetArray];

    if(self.m_aryItems != nil || self.m_aryItems.count != 0) {
        
        for( CardItem *btn in self.m_aryItems) {
            NSLog(@"item id : %d",btn.m_iCardID);
            if (btn.m_iCardID != 0) {
                [self FlipCardToBack:btn];
            }
        }
    }
    
    
}

-(void)resetArray {
    int count = (int)self.m_aryItems.count;
    for (int i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = (arc4random() % nElements) + i;
        
        [self.m_aryItems exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    CardItem *item;
    for (int i = 0 ; i < count ; i++) {
        item = self.m_aryItems[i];
        
        if (item.m_iCardID == 0) {
            [self.m_aryItems exchangeObjectAtIndex:i withObjectAtIndex:4];
            item.userInteractionEnabled = NO;
        } else {
            item.userInteractionEnabled = YES;
        }
        
    }
    
    NSLog(@"%@",self.m_aryItems);
}



@end
