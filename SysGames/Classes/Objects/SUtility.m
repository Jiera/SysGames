//
//  SUtility.m
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import "SUtility.h"

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
