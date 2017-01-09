//
//  RotateView.h
//  spinDemo
//
//  Created by Chen Yu-Chun on 2015/11/12.
//  Copyright (c) 2015年 GivingJan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HandleSpinCompletion)(void);
typedef void(^HandleStartSpin)(void);

typedef enum {
    RotateDirectionClockwise, // 順時針
    RotateDirectionCunterClockwise, // 逆時針
}RotateDirection;


@interface ArcItems : NSObject

@property (assign, nonatomic) CGFloat degrees;
@property (assign, nonatomic) int index;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSString *strText;

- (void)itemSetupWithDegees:(CGFloat)degrees color:(UIColor *)color text:(NSString *)strText index:(int)index;
@end

@interface RotateView : UIView
@property (copy, nonatomic) HandleSpinCompletion handleSpinCompletion;
@property (copy, nonatomic) HandleStartSpin handleStartSpin;
@property (strong, nonatomic) UIButton *m_btSpin;
- (void)configureRotateView:(NSArray*)aryItems;
- (void)spin:(RotateDirection)direction;
- (void)enableView;
@end
