//
//  SGTurnViewController.m
//  SysGames
//
//  Created by Jiera on 2017/1/4.
//  Copyright © 2017年 software. All rights reserved.
//

#import "SGTurnViewController.h"
#import "RotateView.h"


#define kColor_Orange [UIColor orangeColor] // 橘
#define kColor_Red [UIColor colorWithRed:243/255.0f green:0 blue:6/255.0f alpha:1.0f] // 紅
#define kColor_Pink [UIColor colorWithRed:243/255.0f green:0.0f blue:210/255.0f alpha:1.0f] // 粉紅
#define kColor_Purple [UIColor colorWithRed:109/255.0f green:0.0f blue:253/255.0f alpha:1.0f] // 紫
#define kColor_Lightblue [UIColor colorWithRed:5/255.0f green:71/255.0f blue:254/255.0f alpha:1.0f]//淺藍
#define kColor_Darkblue [UIColor colorWithRed:0 green:32/255.0f blue:178/255.0f alpha:1.0f]//深藍
#define kColor_Green [UIColor colorWithRed:33/255.0f green:123/255.0f blue:8/255.0f alpha:1.0f]//綠
#define kColor_Yellow [UIColor colorWithRed:225/255.0f green:164/255.0f blue:0/255.0f alpha:1.0f]//黃


@interface SGTurnViewController ()
@property (strong, nonatomic) IBOutlet RotateView *m_rotateView;
@property (strong, nonatomic) IBOutlet UIButton *m_btnGo;
- (IBAction)handleSpin:(id)sender;

@end

@implementation SGTurnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.view layoutIfNeeded];
    [self.m_rotateView layoutIfNeeded];
    
    NSArray *aryDataList = [self getArrayOfRouletteItems];
    [self.m_rotateView configureRotateView:aryDataList];
}

#pragma mark - Private Methods

-(NSArray *)getArrayOfRouletteItems
{
    NSMutableArray *aryDataList = [[NSMutableArray alloc]init];
    NSArray *aryPrizeNames  = @[@"精誠集團",@"智慧金融",@"未來零售",@"新媒體",@"數據加值",@"趨勢接軌",@"Fintech服務",@"精誠隨想"];
    NSArray *aryColorList = @[kColor_Orange,kColor_Red,kColor_Pink,kColor_Purple,kColor_Lightblue,kColor_Darkblue,kColor_Green,kColor_Yellow];
    UIColor *color;
    CGFloat fDegree;
    
    for(int i =0 ; i < aryPrizeNames.count; i ++) {
        color = aryColorList[i];
        fDegree = 12.5 *3.6f; // WebService給的是百分比,所以*3.6. ex.10 = 36度
        ArcItems *item = [[ArcItems alloc]init];
        [item itemSetupWithDegees:fDegree color:color text:aryPrizeNames[i] index:i];
        
        [aryDataList addObject:item];
    }
    
    return [aryDataList copy];
}

- (IBAction)handleSpin:(id)sender {
}
@end
