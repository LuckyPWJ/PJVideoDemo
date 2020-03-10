//
//  PJBaseNavigationController.m
//  PJVideoDemo
//
//  Created by LuckyPan on 2020/3/9.
//  Copyright © 2020 潘伟建. All rights reserved.
//

#import "PJBaseNavigationController.h"

@interface PJBaseNavigationController ()<UINavigationControllerDelegate>
{
    NSArray *_barHiddenControllers;
}
@end

@implementation PJBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self initData];
}

-(void)initData
{
    //需要隐藏NavgationBar集合
    _barHiddenControllers = @[
        @"PJCameraViewController"
    ];
}

-(BOOL)isContainVC:(NSString *)vcName
{
    return [_barHiddenControllers containsObject:vcName];
}

#pragma mark - UINavigationControllerDelegate

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    BOOL isShowPage = [self isContainVC:NSStringFromClass([viewController class])];
    [self setNavigationBarHidden:isShowPage animated:YES];
}

#pragma mark - dealloc

-(void)dealloc
{
    self.navigationController.delegate = nil;
}

@end
