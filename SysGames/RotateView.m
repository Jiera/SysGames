//
//  RotateView.m
//  spinDemo
//
//  Created by Chen Yu-Chun on 2015/11/12.
//  Copyright (c) 2015年 GivingJan. All rights reserved.
//

#import "RotateView.h"

typedef enum {
    SwipeDirectionRightTop = 0,
    SwipeDirectionRight = 1,
    SwipeDirectionRightBottom = 2,
    SwipeDirectionLeftTop = 3 ,
    SwipeDirectionLeft = 4,
    SwipeDirectionLeftBottom = 5,
}SwipeDirection;

@interface ArcItems()

@end

@interface RotateView()

// Data
@property (assign, nonatomic) int m_iRotateCount;
@property (assign, nonatomic) int m_iCurrentRotateCount;
@property (assign, nonatomic) int m_iNextIndex;
@property (assign, nonatomic) CGFloat m_fRadius;
@property (assign, nonatomic) CGFloat m_fEndAngle;
@property (assign, nonatomic) CGPoint m_pCenterPoint;
@property (assign, nonatomic) CGFloat m_fRadiansDiff;
@property (assign, nonatomic) CGFloat m_fSpinDuration;
@property (assign, nonatomic) CGFloat m_fSpinRadians;
@property (strong, nonatomic) NSMutableArray *m_aryShapeAngle;
@property (strong, nonatomic) NSMutableArray *m_aryShapeLayer;
@property (strong, nonatomic) NSMutableArray *m_aryTimeInterval;
@property (strong, nonatomic) NSArray *m_aryItems;
@property (assign, nonatomic) CGPoint m_touchPoint;
@property (assign, nonatomic) SwipeDirection m_swipeDirection;
@property (assign, nonatomic) CGFloat m_fromValue;


// UI
@property (strong, nonatomic) UIView *m_vShape;
@property (nonatomic, strong) UIView *m_vCoverView;
@property (nonatomic, strong) UIView *m_vCoverViewLeft;
@property (nonatomic, strong) UIView *m_vCoverViewRight;
@property (nonatomic, strong) UIView *m_vCoverViewTop;
@property (nonatomic, strong) UIView *m_vCoverViewBottom;

@end

@implementation ArcItems

- (void)itemSetupWithDegees:(CGFloat)degrees color:(UIColor *)color text:(NSString *)strText index:(int)index{
    self.strText = strText;
    self.degrees = degrees;
    self.color = color;
    self.index = index;
}

@end

@interface RotateView()<CAAnimationDelegate>

@end
@implementation RotateView

#pragma mark - Init
- (void)configureRotateView:(NSArray*)aryItems {
    self.m_aryItems = aryItems;
    self.m_fromValue = 0.0f;
    self.m_aryShapeAngle = [[NSMutableArray alloc]init];
    self.m_aryShapeLayer = [[NSMutableArray alloc]init];
    self.m_vShape = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.m_vShape.backgroundColor = [UIColor grayColor];
    self.m_fRadius = self.m_vShape.frame.size.height/2;
    self.m_vShape.layer.cornerRadius =self.m_fRadius-1;
    self.m_iRotateCount = 10*4; // 必須為4的倍數
    self.m_fEndAngle = 0.0f;
    self.m_pCenterPoint = CGPointMake(self.m_vShape.bounds.origin.x+self.m_vShape.bounds.size.height/2, self.m_vShape.bounds.origin.y+self.m_vShape.bounds.size.width/2);
    
    for (int i =0 ; i < aryItems.count ; i++) {
        ArcItems *item = aryItems[i];
        [self drawShapeLayerWithRotateItem:item];
    }
    
    [self addSubview:self.m_vShape];
    
    [self initCoverView];
}

-(void)initCoverView {
    self.m_vCoverView = [[UIView alloc]initWithFrame:self.m_vShape.frame];
    [self addSubview:self.m_vCoverView];
}

#pragma mark - Private Method
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch= [touches anyObject];
    if ([touch view] == self.m_vCoverView)
    {
        NSArray *touchesArray = [touches allObjects];
        for(int i=0; i<[touchesArray count]; i++)
        {
            UITouch *touch = (UITouch *)[touchesArray objectAtIndex:i];
            CGPoint point = [touch locationInView:self.m_vCoverView];
            NSLog(@"x:%f,  y:%f",point.x,point.y);
            self.m_touchPoint = point;
            // do something with 'point'
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *touchesArray = [touches allObjects];
    for (int i = 0 ; i < touchesArray.count ; i++ ) {
        UITouch *touch = (UITouch*)[touchesArray objectAtIndex:i];
        CGPoint point = [touch locationInView:self.m_vCoverView];
        //        NSLog(@"end x:%f , end y:%f",point.x,point.y);
        [self calculatorPoint:self.m_touchPoint endPoint:point];
    }
}

- (NSString*)convertToString:(SwipeDirection) direction {
    NSString *result = nil;
    /*
     SwipeDirectionRightTop = 0,
     SwipeDirectionRight = 1,
     SwipeDirectionRightBottom = 2,
     SwipeDirectionLeftTop = 3 ,
     SwipeDirectionLeft = 4,
     SwipeDirectionLeftBottom = 5,
     */
    switch(direction) {
        case 0:
            result = @"RightTop";
            break;
        case 1:
            result = @"Right";
            break;
        case 2:
            result = @"RightBottom";
            break;
            
        case 3:
            result = @"LeftTop";
            break;
        case 4:
            result = @"Left";
            break;
        case 5:
            result = @"LeftBottom";
            break;
            
            
        default:
            result = @"unknown";
    }
    
    return result;
}


- (void)calculatorPoint:(CGPoint)beganPoint endPoint:(CGPoint)endPoint {
    CGFloat xDiff = endPoint.x - beganPoint.x;
    CGFloat yDiff = endPoint.y - beganPoint.y;
    RotateDirection rotateDirection = RotateDirectionClockwise;;
    
    if (xDiff > 0) {
        NSLog(@"right");
        self.m_swipeDirection = SwipeDirectionRight;
    }else {
        self.m_swipeDirection = SwipeDirectionLeft;
        NSLog(@"left");
    }
    
    if (yDiff > 0) {
        self.m_swipeDirection+=1;
        NSLog(@"bottom");
    }
    else {
        self.m_swipeDirection-=1;
        NSLog(@"top");
    }
    
    
    NSLog(@"%@",[self convertToString:self.m_swipeDirection]);
    // 右下
    if (beganPoint.x > self.m_pCenterPoint.x &&
        beganPoint.y > self.m_pCenterPoint.y) {
        NSLog(@"起始位置:右下");
        if (self.m_swipeDirection == SwipeDirectionRightBottom) {
            NSLog(@"No");
            return;
        }
        if (self.m_swipeDirection == SwipeDirectionRightTop ) {
            NSLog(@"逆時");
            rotateDirection = RotateDirectionCunterClockwise;
        }
        else if (self.m_swipeDirection == SwipeDirectionLeftTop) {
            if (endPoint.y < self.m_pCenterPoint.y) {
                rotateDirection = RotateDirectionCunterClockwise;
            }
            else {
                rotateDirection = RotateDirectionClockwise;
            }
        }
        else {
            NSLog(@"順時");
        }
        
    }
    // 右上
    else if (beganPoint.x > self.m_pCenterPoint.x &&
             beganPoint.y < self.m_pCenterPoint.y) {
        NSLog(@"起始位置:右上");
        
        if (self.m_swipeDirection == SwipeDirectionRightTop ) {
            NSLog(@"No");
            return;
        }
        
        if (self.m_swipeDirection == SwipeDirectionLeftTop) {
            NSLog(@"逆時");
            rotateDirection = RotateDirectionCunterClockwise;

        }else if (self.m_swipeDirection == SwipeDirectionLeftBottom) {
                // 滑到左上
                if (endPoint.x < self.m_pCenterPoint.x) {
                    rotateDirection = RotateDirectionCunterClockwise;
                }
                else {
                    rotateDirection = RotateDirectionClockwise;
                }
        }
        else {
            NSLog(@"順時");
        }
        
    }
    // 左上
    else if (beganPoint.x < self.m_pCenterPoint.x &&
             beganPoint.y < self.m_pCenterPoint.y) {
        if (self.m_swipeDirection == SwipeDirectionLeftTop ) {
            NSLog(@"No");
            return;
        }
        
        NSLog(@"起始位置:左上");
        if (self.m_swipeDirection == SwipeDirectionLeftBottom ) {
            NSLog(@"逆時");
            rotateDirection = RotateDirectionCunterClockwise;
        }
        else if (self.m_swipeDirection == SwipeDirectionRightBottom) {
            // 滑到右上
            if (endPoint.x > self.m_pCenterPoint.x) {
                rotateDirection = RotateDirectionClockwise;
            }
            else {
                rotateDirection = RotateDirectionCunterClockwise;
            }
        }
        
        else {
            NSLog(@"順時");
        }
    }
    // 左下
    else if (beganPoint.x < self.m_pCenterPoint.x &&
             beganPoint.y > self.m_pCenterPoint.y) {
        if (self.m_swipeDirection == SwipeDirectionLeftBottom) {
            NSLog(@"No");
            return;
        }
        
        NSLog(@"起始位置:左下");
        if (self.m_swipeDirection == SwipeDirectionRightBottom ) {
            NSLog(@"逆時");
            rotateDirection = RotateDirectionCunterClockwise;

        }
        else {
            NSLog(@"順時");
        }
    }
    
    [self spinDirection:rotateDirection];
    
}


#pragma mark - DrawShape
- (void)drawShapeLayerWithRotateItem:(ArcItems*)item {
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    UIColor *color = item.color;
    
    [shapeLayer setStrokeColor:[color CGColor]];
    [shapeLayer setFillColor:[color CGColor]];
    
    // get center point.
    CGFloat radius = self.m_fRadius;
    CGFloat startAngle = self.m_fEndAngle;
    // radians = degree * (Math.PI / 180)
    CGFloat endAngle = item.degrees * (M_PI/180) + self.m_fEndAngle;
    CGFloat midAngle = (startAngle + endAngle)/2;
    [self.m_aryShapeAngle addObject:[NSNumber numberWithFloat:midAngle]];
    
    NSLog(@"Middle Anggle:%f",(startAngle + endAngle)/2 );
    
    self.m_fEndAngle = endAngle;
    NSLog(@"endAngle:%f",endAngle);
    CGPathRef path = CGPathCreateArc(self.m_pCenterPoint, radius, startAngle, endAngle);
    
    [shapeLayer setPath:path];
    
    [self.m_aryShapeLayer addObject:shapeLayer];
    [self.m_vShape.layer addSublayer:shapeLayer];
    
    CFRelease(path);
    
    [self addTextLayerWithArcItems:item.strText angle:midAngle layer:shapeLayer]; // adding Text
}

-(void)addTextLayerWithArcItems:(NSString*)strText angle:(CGFloat)fAngle layer:(CAShapeLayer*)shapeLayer{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.contentsScale = [[UIScreen mainScreen]scale];
    [textLayer setString:strText];
    [textLayer setFontSize:15.0f];
    [textLayer setBackgroundColor:[UIColor clearColor].CGColor];
    [textLayer setAlignmentMode:@"center"];
    [textLayer setShadowColor:[UIColor blackColor].CGColor];
    [textLayer setShadowOffset:CGSizeMake(0, 0)];
    [textLayer setShadowOpacity:0.95f];
    [textLayer setShadowRadius:0.9f];
    [textLayer setForegroundColor:[UIColor whiteColor].CGColor];
    [CATransaction setDisableActions:YES];
    [textLayer setFrame:CGRectMake(0, 0, self.m_fRadius, 20)];
    textLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(fAngle));
    [CATransaction setDisableActions:NO];
    [textLayer setPosition:CGPointMake(self.m_pCenterPoint.x + ((self.m_fRadius * cos(fAngle))/1.6), self.m_pCenterPoint.y + (self.m_fRadius * sin(fAngle))/1.6)];

    
    [shapeLayer addSublayer:textLayer];
}

static CGPathRef CGPathCreateArc(CGPoint center, CGFloat radius, CGFloat startAngle, CGFloat endAngle)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, center.x, center.y);
    
    CGPathAddArc(path, NULL, center.x, center.y, radius, startAngle, endAngle, 0);
    CGPathCloseSubpath(path);
    
    return path;
}

#pragma mark - Spin Configure
- (void)configurateFinalRotateWithDirection:(RotateDirection)direction {
    CGFloat random = (arc4random()%60 +10) * 0.1 + (arc4random()%(2))+8;
    
    if (direction == RotateDirectionClockwise) {
        [self runSpinAnimationOnView:self.m_vShape duration:2.0 rotations:random repeat:0];
    } else {
        [self runSpinAnimationOnView:self.m_vShape duration:2.0 rotations:0-random repeat:0];
    }
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    
    CABasicAnimation* rotationAnimation;
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:self.m_fromValue];
    rotationAnimation.toValue = [NSNumber numberWithFloat: rotations + self.m_fromValue];
    rotationAnimation.duration = duration;
    rotationAnimation.delegate = self;
    rotationAnimation.cumulative = YES;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.repeatCount = repeat;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;

    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    self.m_fromValue = rotations + self.m_fromValue;
}


-(void)handleSpinClockwise {
    [self spinDirection:RotateDirectionClockwise];
}

-(void)handleSpinCounterClockwise {
    [self spinDirection:RotateDirectionCunterClockwise];
}

#pragma mark - Public Method
- (void)enableView {
    self.userInteractionEnabled = YES;
    self.m_btSpin.userInteractionEnabled = YES;
}

-(void)spinDirection:(RotateDirection)direction {
    
    if(self.m_iNextIndex < 0 || self.m_iNextIndex > self.m_aryItems.count-1 ) {
        NSLog(@"[spinAtIndex] index is out of bounds.");
    }
    
    if (self.handleStartSpin) {
        self.handleStartSpin(); // UI disable
    }
    
    self.userInteractionEnabled = NO;
    self.m_fSpinDuration = 0.03f;
    self.m_fSpinRadians = direction == RotateDirectionClockwise?M_PI/2:-(M_PI/2);
    self.m_iCurrentRotateCount = 0;
    self.m_iRotateCount = 10*4; // 必須為4的倍數
    
    [self spin:direction];
}

- (void)spin:(RotateDirection)direction {
    self.m_btSpin.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    
    CGFloat random = (arc4random()%60 +16) * 0.1 + (arc4random()%(2))+8;
    
    if (direction == RotateDirectionClockwise) {
        [self runSpinAnimationOnView:self.m_vShape duration:3.5 rotations:random * 8 repeat:0];
    } else {
        [self runSpinAnimationOnView:self.m_vShape duration:3.5 rotations:0 - (random * 8) repeat:0];
    }
}

#pragma mark - CAAnimationDelegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag == YES) {
        [self enableView];
    }
}
@end








