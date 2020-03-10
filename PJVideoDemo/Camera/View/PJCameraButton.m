//
//  PJCameraButton.m
//  PJVideoDemo
//
//  Created by LuckyPan on 2020/3/9.
//  Copyright © 2020 潘伟建. All rights reserved.
//

#import "PJCameraButton.h"

static const CGFloat PJCircleInsetWidth = 9.0f;

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
    UIColor * circleColor    = _cameraType == PJCameraModelCamera ? [UIColor redColor] : [UIColor whiteColor];
    CALayer * circleLayer    = [CALayer layer];
    circleLayer.backgroundColor = circleColor.CGColor;
    circleLayer.bounds          = CGRectInset(self.bounds, PJCircleInsetWidth, PJCircleInsetWidth);
    circleLayer.position        = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    circleLayer.cornerRadius    = circleLayer.bounds.size.width / 2.0;
    
    [self.layer addSublayer:circleLayer];
    _circleLayer = circleLayer;
}

#pragma mark - setter

-(void)setCameraType:(PJCameraModelType)cameraType
{
    if (_cameraType == cameraType) {
        return;
    }
    _cameraType = cameraType;
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
  
    [self scaleAnimation];
    
    [self setNeedsDisplay];

}

#pragma mark - animation

-(void)scaleAnimation
{
    CGFloat scale = (PJCircleInsetWidth * 2) / self.bounds.size.width + 1.1;
    CAKeyframeAnimation * frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSValue * value1 = [NSValue valueWithCATransform3D:CATransform3DScale(_circleLayer.transform, 1.0, 1.0, 0)];
    NSValue * value2 = [NSValue valueWithCATransform3D:CATransform3DScale(_circleLayer.transform, scale, scale, 0)];
    NSValue * value3 = [NSValue valueWithCATransform3D:CATransform3DScale(_circleLayer.transform, 1.0, 1.0, 0)];
    NSArray * values = @[value1,value2,value3];
    frameAnimation.values = values;
    frameAnimation.duration = 0.3f;
    [_circleLayer addAnimation:frameAnimation forKey:@"GGKeyframeAnimation"];
    
}

#pragma mark - core Graphics

-(UIColor *)strokeColor
{
    UIColor * color ;
    switch (_cameraType) {
        case PJCameraModelCamera:
            color = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
            break;
        case PJCameraModelVideo:
            color = [[UIColor redColor] colorWithAlphaComponent:0.5];
            break;
        default:
            break;
    }
    return color;
}

-(void)drawRect:(CGRect)rect
{
    UIColor * strokeColor = [self strokeColor];
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
