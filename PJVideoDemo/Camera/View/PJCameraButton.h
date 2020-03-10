//
//  PJCameraButton.h
//  PJVideoDemo
//
//  Created by LuckyPan on 2020/3/9.
//  Copyright © 2020 潘伟建. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PJCameraModelType){
    PJCameraModelCamera = 0,
    PJCameraModelVideo
};

NS_ASSUME_NONNULL_BEGIN

@interface PJCameraButton : UIButton

@property(nonatomic, assign) PJCameraModelType cameraType;

@end

NS_ASSUME_NONNULL_END
