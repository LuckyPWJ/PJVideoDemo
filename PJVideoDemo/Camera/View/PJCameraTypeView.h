//
//  PJCameraTypeView.h
//  PJVideoDemo
//
//  Created by LuckyPan on 2020/3/10.
//  Copyright © 2020 潘伟建. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PJCameraTypeViewDelegate <NSObject>

-(void)cameraTypeViewSelectIndex:(NSInteger)index;

@end

@interface PJCameraTypeView : UIView

@property(nonatomic, weak) id<PJCameraTypeViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
