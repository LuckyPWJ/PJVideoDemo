//
//  PJCameraViewController.m
//  PJVideoDemo
//
//  Created by LuckyPan on 2020/3/7.
//  Copyright © 2020 潘伟建. All rights reserved.
//

#import "PJCameraViewController.h"

@interface PJCameraViewController ()<UINavigationControllerDelegate>

@end

@implementation PJCameraViewController

#pragma mark - LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - button Action

- (IBAction)closeVCAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
