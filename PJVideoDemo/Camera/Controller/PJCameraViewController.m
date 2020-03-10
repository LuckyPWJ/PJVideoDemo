//
//  PJCameraViewController.m
//  PJVideoDemo
//
//  Created by LuckyPan on 2020/3/7.
//  Copyright © 2020 潘伟建. All rights reserved.
//

#import "PJCameraViewController.h"
#import "PJCameraTypeView.h"
#import "PJCameraButton.h"

@interface PJCameraViewController ()<UINavigationControllerDelegate,PJCameraTypeViewDelegate>

@property (weak, nonatomic) IBOutlet PJCameraTypeView *cameraTypeView;

@property (weak, nonatomic) IBOutlet PJCameraButton *cameraButton;

@end

@implementation PJCameraViewController

#pragma mark - LifeCircle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cameraTypeView.delegate = self;

}

#pragma mark - button Action

- (IBAction)closeVCAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PJCameraTypeViewDelegate

-(void)cameraTypeViewSelectIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            _cameraButton.cameraType = PJCameraModelCamera;
            break;
        case 1:
        case 2:
            _cameraButton.cameraType = PJCameraModelVideo;
            break;
        default:
            break;
    }
}

@end
