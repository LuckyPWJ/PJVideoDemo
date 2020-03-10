//
//  PJCameraTypeView.m
//  PJVideoDemo
//
//  Created by LuckyPan on 2020/3/10.
//  Copyright © 2020 潘伟建. All rights reserved.
//

#import "PJCameraTypeView.h"
#import "UIView+PJFrame.h"

@interface PJCameraTypeView(){
    UIView *_backgroundView;
    CGPoint _prePoint;
    CGPoint _startPoint;
    CGFloat _buttonWidth;
    NSArray *_titles;
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
    
    UIPanGestureRecognizer * panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesAction:)];
    [self addGestureRecognizer:panGes];
}

-(void)setUpBackgroundView
{
    CGFloat backgroundViewWidth = _buttonWidth * [self titleCount];
    UIView * backgroundView     = [UIView new];
    backgroundView.frameWidth   = backgroundViewWidth;
    backgroundView.frameHeight  = self.frameHeight;
    backgroundView.frameY       = 0;
    backgroundView.frameX       = ([UIScreen mainScreen].bounds.size.width - backgroundViewWidth) / 2 + _buttonWidth;
    [self addSubview:backgroundView];
    _backgroundView = backgroundView;
}

-(void)setUpModelButton
{
    CGFloat buttonWidth  = _buttonWidth;
    CGFloat buttonHeight = _backgroundView.frameHeight;
    
    for (NSUInteger i = 0; i < [self titleCount]; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame      = CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight);
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView addSubview:button];
    }
}

-(void)typeButtonAction:(id)sender
{
    
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
    NSInteger n = (NSInteger)transformX / (_buttonWidth / 2);

    if (ges.state == UIGestureRecognizerStateEnded){
        NSInteger titleCount = [self titleCount];
        if (n >= 0) {
               _backgroundView.transform = CGAffineTransformTranslate(_backgroundView.transform, -transformX, 0);
          }else if (n < -(titleCount - 1)){
                _backgroundView.transform = CGAffineTransformTranslate(_backgroundView.transform, -transformX - _buttonWidth * (titleCount - 1), 0);
          }else{
              //判断滑动方向，进行处理
              NSInteger direction = touchPoint.x - _startPoint.x;
              NSInteger m = direction > 0 ? n + 1 : n;
              _backgroundView.transform = CGAffineTransformTranslate(_backgroundView.transform, -transformX + _buttonWidth * m , 0);
          }
    }
}

-(NSInteger)titleCount
{
    return _titles.count;
}

@end

