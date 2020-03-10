//
//  PJCameraButton.m
//  PJVideoDemo
//
//  Created by LuckyPan on 2020/3/9.
//  Copyright © 2020 潘伟建. All rights reserved.
//

#import "PJCameraButton.h"

@interface PJCameraButton(){
    CALayer *_circleLayer;
}
@end

@implementation PJCameraButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpView];
}

-(void)setUpView
{
    self.backgroundColor = [UIColor clearColor];
    _cameraType          = PJCameraModelCamera;

    [self setUpMidCircleView];
}

-(void)setUpMidCircleView
{
    CGFloat circleInsetWidth = 9.f;
    UIColor * circleColor    = _cameraType == PJCameraModelCamera ? [UIColor redColor] : [UIColor whiteColor];
    CALayer * circleLayer    = [CALayer layer];
    circleLayer.backgroundColor = circleColor.CGColor;
    circleLayer.bounds          = CGRectInset(self.bounds, circleInsetWidth, circleInsetWidth);
    circleLayer.position        = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    circleLayer.cornerRadius    = circleLayer.bounds.size.width / 2.0;
    
    [self.layer addSublayer:circleLayer];
}

#pragma mark - setter

-(void)setCameraType:(PJCameraModelType)cameraType
{
    UIColor * circleColor;
    switch (cameraType) {
        case PJCameraModelCamera:
        {
           circleColor = [UIColor whiteColor];
        }
            break;
        case PJCameraModelVideo:
        {
            circleColor = [UIColor redColor];
        }
            break;
        default:
            break;
    }
    _circleLayer.backgroundColor = circleColor.CGColor;
}

#pragma mark - core Graphics

-(void)drawRect:(CGRect)rect
{
    UIColor * strokeColor = [UIColor whiteColor];
    UIColor * fillColor   = [UIColor whiteColor];
    CGFloat lineWidth     = 4.f;
    CGFloat inset         = lineWidth / 2.f;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(contextRef, strokeColor.CGColor);
    CGContextSetFillColorWithColor(contextRef, fillColor.CGColor);
    CGContextSetLineWidth(contextRef, lineWidth);
    CGRect drawRect = CGRectInset(rect, inset, inset);
    CGContextStrokeEllipseInRect(contextRef, drawRect);
}

@end
