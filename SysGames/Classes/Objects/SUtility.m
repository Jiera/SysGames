//
//  SUtility.m
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import "SUtility.h"

@implementation UIButton (Custom)

- (void)updateGreenButton:(NSString *)text
{
    if (self) {
        [self setTitle:text forState:UIControlStateNormal];
        [self setBackgroundColor:kCustomColor_Green];
        self.layer.cornerRadius = 8.0f;
        self.layer.masksToBounds = YES;
    }
}

- (void)setTurnClicked:(BOOL)isClicked
{
    if (isClicked) {
        [self setImage:[UIImage imageNamed:kFile_TurnOn]
              forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageNamed:kFile_TurnOff]
              forState:UIControlStateNormal];
    }
}

- (void)setScratchClicked:(BOOL)isClicked
{
    if (isClicked) {
        [self setImage:[UIImage imageNamed:kFile_ScratchOn]
              forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageNamed:kFile_ScratchOff]
              forState:UIControlStateNormal];
    }
}

- (void)setCardClicked:(BOOL)isClicked
{
    if (isClicked) {
        [self setImage:[UIImage imageNamed:kFile_CardOn]
              forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageNamed:kFile_CardOff]
              forState:UIControlStateNormal];
    }
}

@end

@implementation UIView (Custom)

- (void)addShadowStyle
{
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowColor = [kCustomColor_Mask CGColor];
    self.layer.shadowRadius = 1.0f;
    self.layer.shadowOpacity = 0.80f;
}

@end

@implementation UIViewController (Custom)

+ (id)newBySelfClass
{
    NSString *nibName = NSStringFromClass([self class]);
    id vc = [[[self class] alloc] initWithNibName:nibName bundle:nil];
    
    return vc;
}

@end

@implementation SUtility

@end
