//
//  UIScrollView+ScalableCover.m
//  JellyeffectDemo
//
//  Created by kimi.zhang on 16/4/25.
//  Copyright © 2016年 kimi.zhang. All rights reserved.
//

#import "UIScrollView+ScalableCover.h"
#import <objc/runtime.h>

static NSString * const kContentOffset = @"contentOffset";
static NSString * const kScalableCover = @"scalableCover";

@implementation UIScrollView (ScalableCover)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setScalableCover:(UIScrollView_ScalableCover *)scalableCover
{
    [self willChangeValueForKey:kScalableCover];
    objc_setAssociatedObject(self, @selector(scalableCover),
                             scalableCover,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kScalableCover];
}

- (UIScrollView_ScalableCover *)scalableCover
{
    return objc_getAssociatedObject(self, &kScalableCover);
}

- (void)addScalableCoverWithImage:(UIImage *)image
{
    UIScrollView_ScalableCover *cover = [[UIScrollView_ScalableCover alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, MaxHeight)];
    
    cover.backgroundColor = [UIColor clearColor];
    cover.image = image;
    cover.scrollView = self;
    
    [self addSubview:cover];
    [self sendSubviewToBack:cover];
    
    self.scalableCover = cover;
}

- (void)removeScalableCover
{
    [self.scalableCover removeFromSuperview];
    self.scalableCover = nil;
}


@end




@interface UIScrollView_ScalableCover (){
    
}



@end


@implementation UIScrollView_ScalableCover

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
    }
    
    return self;
}


- (void)setScrollView:(UIScrollView *)scrollView
{
    
    [_scrollView removeObserver:scrollView forKeyPath:kContentOffset];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}




- (void)removeFromSuperview
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    NSLog(@"😄----removeed");
    [super removeFromSuperview];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.scrollView.contentOffset.y < 0) {
        CGFloat offset = -self.scrollView.contentOffset.y;
        
        self.frame = CGRectMake(-offset, -offset, _scrollView.bounds.size.width + offset * 2, MaxHeight + offset);
    } else {
        self.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, MaxHeight);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsLayout];
}



@end
