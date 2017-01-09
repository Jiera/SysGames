//
//  HYScratchCardView.h
//  Test
//
//  Created by Shadow on 14-5-23.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kScratchOffRate 0.45

typedef void(^scratchCompletion)(NSString *scratchId);

@interface HYScratchCardView : UIView

@property (nonatomic, strong) NSString *scratchId;
@property (nonatomic, strong) UIImage *image;        //底圖
@property (nonatomic, strong) UIImage *surfaceImage; //塗層

@property (nonatomic, assign, readonly, getter = isOpen) BOOL open;
@property (nonatomic, assign) CGFloat openRange;

@property (nonatomic, strong) scratchCompletion begin;
@property (nonatomic, strong) scratchCompletion completion;


- (id)initWithFrame:(CGRect)frame;
- (void)reset;

@end
