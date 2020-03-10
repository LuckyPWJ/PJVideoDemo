//
//  PJCameraTypeView.m
//  PJVideoDemo
//
//  Created by LuckyPan on 2020/3/10.
//  Copyright © 2020 潘伟建. All rights reserved.
//

#import "PJCameraTypeView.h"
#import "UIView+PJFrame.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface PJCameraTypeView(){
    UIView *_backgroundView;
    CGPoint _prePoint;
    CGPoint _startPoint;
    CGFloat _buttonWidth;
    NSArray *_titles;
    CGAffineTransform _transform;
    NSUInteger _currentIndex;
}

@end

@implementation PJCameraTypeView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUpView];
}

-(void)setUpView
{
    NSArray * titles = @[@"拍照",@"拍15秒",@"拍30秒"];
    _titles = titles;
    _buttonWidth = 80;

    [self setUpBackgroundView];
    
    [self setUpModelButton];
    
    [self setUpDotView];
    
    UIPanGestureRecognizer * panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesAction:)];
    [self addGestureRecognizer:panGes];
}

-(void)setUpBackgroundView
{
    CGFloat backgroundViewWidth = _buttonWidth * [self titleCount];
    UIView * backgroundView     = [UIView new];
    backgroundView.frameWidth   = backgroundViewWidth;
    backgroundView.frameHeight  = self.frameHeight - 5;
    backgroundView.frameY       = 0;
    backgroundView.frameX       = (kScreenWidth - backgroundViewWidth) / 2 + _buttonWidth;
    [self addSubview:backgroundView];
    _backgroundView = backgroundView;
    _transform      = _backgroundView.transform;
}

-(void)setUpModelButton
{
    CGFloat buttonWidth  = _buttonWidth;
    CGFloat buttonHeight = _backgroundView.frameHeight;
    
    for (NSUInteger i = 0; i < [self titleCount]; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag        = 10 + i;
        button.frame      = CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight);
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView addSubview:button];
    }
}

-(void)setUpDotView
{
    CGFloat dotWidth = 5.f;
    CALayer * dotLayer = [CALayer layer];
    dotLayer.backgroundColor = [UIColor whiteColor].CGColor;
    dotLayer.frame           = CGRectMake((kScreenWidth - dotWidth) / 2 ,_backgroundView.frameHeight, dotWidth, dotWidth);
    dotLayer.cornerRadius    = dotWidth / 2;
    [self.layer addSublayer:dotLayer];
}

-(void)typeButtonAction:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    NSInteger i = btn.tag - 10;
    _backgroundView.transform = CGAffineTransformTranslate(_transform, - i * _buttonWidth, 0);
    [self respondToDelegateWithIndex:i];

}

-(void)panGesAction:(UIPanGestureRecognizer *)ges
{
    CGPoint touchPoint = [ges locationInView:self];
    //获取手势刚开始时的坐标
    if (ges.state == UIGestureRecognizerStateBegan) {
        //记录上一个触摸点
        _prePoint   = touchPoint;
        //记录刚开始时的坐标点，用于判断方向
        _startPoint = touchPoint;
    }
    CGFloat offSetX = touchPoint.x - _prePoint.x;
    
    _backgroundView.transform = CGAffineTransformTranslate(_backgroundView.transform, offSetX, 0);
    _prePoint = touchPoint;
   
    CGFloat transformX = _backgroundView.transform.tx;

    if (ges.state == UIGestureRecognizerStateEnded) {
        NSInteger titleCount = [self titleCount];
        NSInteger n = (NSInteger)transformX / (_buttonWidth / 2);
        CGAffineTransform transform;
        if (n >= 0) {
            transform = CGAffineTransformTranslate(_transform,0, 0);
            _currentIndex = 0;
        }else if (n <= -titleCount) {
            transform = CGAffineTransformTranslate(_transform,-_buttonWidth * (titleCount - 1), 0);
            _currentIndex = 2;
        }else{
            NSInteger direction = touchPoint.x - _startPoint.x;
            NSInteger m = direction > 0 ? n + 1 : n;
            transform = CGAffineTransformTranslate(_transform,_buttonWidth * m, 0);
            _currentIndex = labs(m);
        }
        _backgroundView.transform = transform;
        [self respondToDelegateWithIndex:_currentIndex];
    }
}

-(void)respondToDelegateWithIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(cameraTypeViewSelectIndex:)]) {
        [self.delegate cameraTypeViewSelectIndex:index];
    }
}

-(NSInteger)titleCount
{
    return _titles.count;
}

@end

