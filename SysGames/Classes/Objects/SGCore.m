//
//  SGCore.m
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import "SGCore.h"

static const float fSplitLeftWidth = 256.0f;

@interface SGCore () <UISplitViewControllerDelegate>


@end

@implementation SGCore

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)initValue
{
    [self initViewControllers];
    [self initSplitViewController];
}

#pragma mark -

- (void)initSplitViewController
{
    self.m_splitViewController = [[UISplitViewController alloc] init];
    self.m_splitViewController.viewControllers = @[self.m_listViewController, self.m_turnViewController];
    self.m_splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    self.m_splitViewController.maximumPrimaryColumnWidth = fSplitLeftWidth;
    self.m_splitViewController.delegate = self;
    
    self.m_splitViewController.view.opaque = NO;
    self.m_splitViewController.view.backgroundColor = [UIColor clearColor];
}

- (void)initViewControllers
{
    self.m_listViewController = [SGListViewController newBySelfClass];
    self.m_turnViewController = [SGTurnViewController newBySelfClass];
    self.m_scratchViewController = [SGScratchViewController newBySelfClass];
    self.m_cardViewController = [SGCardViewController newBySelfClass];
}

#pragma mark - UISplitViewController Delegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return YES;
}

- (void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode
{
    
}

@end
