//
//  ViewController.m
//  PJVideoDemo
//
//  Created by LuckyPan on 2020/3/7.
//  Copyright © 2020 潘伟建. All rights reserved.
//

#import "ViewController.h"
#import "PJCameraViewController.h"
#import "PJBaseNavigationController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Action

- (IBAction)toCameraVC:(id)sender {
    PJCameraViewController * cameraVC = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PJCameraViewController class]) owner:nil options:nil].lastObject;
    PJBaseNavigationController * navVC = [[PJBaseNavigationController alloc] initWithRootViewController:cameraVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

@end
