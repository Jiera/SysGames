//
//  HYScratchCardView.m
//  Test
//
//  Created by Shadow on 14-5-23.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "HYScratchCardView.h"

#define kPenWidth     30.0f
#define kCornerRadius 50.0f

@interface HYScratchCardView ()
@property (nonatomic, strong) UIImageView *surfaceImageView;
@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGMutablePathRef path;
@property (nonatomic, assign, getter = isOpen) BOOL open;

@property (nonatomic, assign) CGContextRef contextMask;
@property (nonatomic, assign) CGFloat pixel;
@end

@implementation HYScratchCardView

- (void)dealloc
{
    if (self.path) {
        CGPathRelease(self.path);
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = kCornerRadius;
        self.layer.masksToBounds = YES;
        
        self.surfaceImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.surfaceImageView.image = [self imageByColor:[UIColor darkGrayColor]];
        self.surfaceImageView.layer.cornerRadius = kCornerRadius;
        self.surfaceImageView.layer.masksToBounds = YES;
        [self addSubview:self.surfaceImageView];
        
        self.imageLayer = [CALayer layer];
        self.imageLayer.frame = self.bounds;
        [self.layer addSublayer:self.imageLayer];
        
        self.shapeLayer = [CAShapeLayer layer];
        self.shapeLayer.frame = self.bounds;
        self.shapeLayer.lineCap = kCALineCapRound;
        self.shapeLayer.lineJoin = kCALineJoinRound;
        self.shapeLayer.lineWidth = kPenWidth;
        self.shapeLayer.strokeColor = [UIColor blueColor].CGColor;
        self.shapeLayer.fillColor = nil;
        
        [self.layer addSublayer:self.shapeLayer];
        self.imageLayer.mask = self.shapeLayer;
        
        self.path = CGPathCreateMutable();
        self.openRange = 0;
        
        //
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        CGRect frameRect = self.surfaceImageView.frame;
        int imageWidth = frameRect.size.width;
        int imageHeight = frameRect.size.height;
        self.pixel = imageWidth*imageHeight;
        
        CFMutableDataRef pixels = CFDataCreateMutable(NULL, imageWidth * imageHeight);
        self.contextMask = CGBitmapContextCreate(CFDataGetMutableBytePtr(pixels), imageWidth, imageHeight , 8, imageWidth, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
        
        CGContextSetFillColorWithColor(self.contextMask, [UIColor blackColor].CGColor);
        CGContextFillRect(self.contextMask, self.frame);
        
        CGContextSetStrokeColorWithColor(self.contextMask, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(self.contextMask, kPenWidth);
        CGContextSetLineCap(self.contextMask, kCGLineCapRound);
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (!self.isOpen) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        CGPathMoveToPoint(self.path, NULL, point.x, point.y);
        CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
        self.shapeLayer.path = path;
        CGPathRelease(path);
    }
    
    if (self.begin) {
        self.begin(self.scratchId);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (!self.isOpen) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        CGPathAddLineToPoint(self.path, NULL, point.x, point.y);
        CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
        self.shapeLayer.path = path;
        CGPathRelease(path);
        
        CGPoint previousPoint = [touch previousLocationInView:self];
        [self scratchTheViewFrom:previousPoint to:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (!self.isOpen) {
        [self checkForOpen];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if (!self.isOpen) {
        [self checkForOpen];
    }
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageLayer.contents = (id)image.CGImage;
}

- (void)setSurfaceImage:(UIImage *)surfaceImage
{
    _surfaceImage = surfaceImage;
    self.surfaceImageView.image = surfaceImage;
}

- (void)reset
{
    if (self.path) {
        CGPathRelease(self.path);
    }
    self.open = NO;
    self.path = CGPathCreateMutable();
    self.shapeLayer.path = NULL;
    self.imageLayer.mask = self.shapeLayer;
}

- (void)checkForOpen
{
    double iSum = 0;
    double ired = 0;
    unsigned char* rawData = CGBitmapContextGetData (self.contextMask);
    
    for (int i = 0; i < self.pixel; i++) {
        ired = rawData[i];
        
        if (255 == ired){
            iSum++;
        }
    }

    [self setOpenRange:iSum/self.pixel];
    if (_openRange > kScratchOffRate) {
        self.open = YES;
        self.imageLayer.mask = NULL;
        
        if (self.completion) {
            self.completion(self.scratchId);
        }
    }
}

- (void)scratchTheViewFrom:(CGPoint)startPoint to:(CGPoint)endPoint
{
    CGContextMoveToPoint(self.contextMask, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(self.contextMask, endPoint.x, endPoint.y);
    CGContextStrokePath(self.contextMask);
    [self setNeedsDisplay];
}

- (NSArray *)getPointsArray
{
    NSMutableArray *array = [NSMutableArray array];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    CGPoint topPoint = CGPointMake(width/2, height/6);
    CGPoint leftPoint = CGPointMake(width/6, height/2);
    CGPoint bottomPoint = CGPointMake(width/2, height-height/6);
    CGPoint rightPoint = CGPointMake(width-width/6, height/2);
    
    [array addObject:[NSValue valueWithCGPoint:topPoint]];
    [array addObject:[NSValue valueWithCGPoint:leftPoint]];
    [array addObject:[NSValue valueWithCGPoint:bottomPoint]];
    [array addObject:[NSValue valueWithCGPoint:rightPoint]];
    
    return array;
}

- (UIImage *)imageByColor:(UIColor *)color
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
