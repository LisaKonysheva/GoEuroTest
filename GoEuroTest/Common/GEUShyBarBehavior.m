//
//  ShyBarBehavior.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/17/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUShyBarBehavior.h"
#import "GEUConstants.h"

@interface GEUShyBarBehavior ()

@property (nonatomic) CGFloat previousContentOffset;
@property (nonatomic) CGFloat normalBottomBarHeight;
@property (nonatomic) BOOL animationIsRunning;

@end

@implementation GEUShyBarBehavior

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidLayoutSubviews:) name:GEUViewControllerViewDidLayoutSubviews object:self.owner];
}

- (void)viewDidLayoutSubviews:(NSNotification *)notification {
    if (!self.normalBottomBarHeight) {
        self.normalBottomBarHeight = self.bottomBar.frame.origin.y;
        self.scrollView.contentInset = (UIEdgeInsets){0,0,self.bottomBar.frame.size.height,0};
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentSize.height > 0 && scrollView.contentSize.height < scrollView.frame.size.height) {
        return;
    }

    if (self.previousContentOffset > 0) {
        if (scrollView.contentOffset.y > self.previousContentOffset && self.bottomBar.frame.origin.y == self.normalBottomBarHeight && !_animationIsRunning) {
            [self animateBottomBarToHeight:self.bottomBar.frame.size.height];
        } else if (scrollView.contentOffset.y < self.previousContentOffset && self.bottomBar.frame.origin.y != self.normalBottomBarHeight && !_animationIsRunning) {
            [self animateBottomBarToHeight:0];
        }
    }
    
    self.previousContentOffset = scrollView.contentOffset.y;
}

- (void)animateBottomBarToHeight:(CGFloat)height {
    self.animationIsRunning = YES;
    [UIView animateWithDuration:0.4 animations:^{
        self.bottomBar.frame = (CGRect){self.bottomBar.frame.origin.x, self.normalBottomBarHeight + height, self.bottomBar.frame.size.width, self.bottomBar.frame.size.height};
    } completion:^(BOOL finished) {
        self.animationIsRunning = NO;
    }];
}

@end
