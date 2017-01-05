//
//  SUtility.h
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton (Custom)
- (void)updateGreenButton:(NSString *)text;
- (void)setScratchClicked:(BOOL)isClicked;
- (void)setCardClicked:(BOOL)isClicked;
- (void)setTurnClicked:(BOOL)isClicked;
@end

@interface UIView (Custom)
- (void)addShadowStyle;
@end

@interface UIViewController (Custom)
+ (id)newBySelfClass;
@end

@interface SUtility : NSObject

@end
