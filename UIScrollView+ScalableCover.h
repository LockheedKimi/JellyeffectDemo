//
//  UIScrollView+ScalableCover.h
//  JellyeffectDemo
//
//  Created by kimi.zhang on 16/4/25.
//  Copyright © 2016年 kimi.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat MaxHeight = 200;

@interface UIScrollView_ScalableCover : UIImageView
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@interface UIScrollView (ScalableCover)

@property (nonatomic, weak) UIScrollView_ScalableCover *scalableCover;

- (void)addScalableCoverWithImage:(UIImage *)image;
- (void)removeScalableCover;

@end
