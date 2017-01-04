//
//  SGBaseViewController.h
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SGDetailView_Scratch,
    SGDetailView_Card,
    SGDetailView_Turn
} SGDetailView;

@interface SGBaseViewController : UIViewController

- (void)switchDetailView:(SGDetailView)detailView;

@end
