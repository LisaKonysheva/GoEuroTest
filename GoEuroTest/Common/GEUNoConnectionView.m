//
//  GEUNoConnectionView.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/17/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUNoConnectionView.h"

@interface GEUNoConnectionView ()

@property (nonatomic) IBOutlet UILabel *label;

@end

@implementation GEUNoConnectionView

+ (void)show {
    GEUNoConnectionView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GEUNoConnectionView class]) owner:nil options:nil].firstObject;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
    
    CGRect hideFrame = (CGRect){0, -view.frame.size.height, view.frame.size.width, view.frame.size.height};
    view.frame = hideFrame;
    
    [UIView animateWithDuration:1.0 animations:^{
        view.frame = (CGRect){0, 0, view.frame.size.width, view.frame.size.height};
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8 delay:1 options:UIViewAnimationOptionTransitionFlipFromBottom
                         animations:^{
            view.frame = hideFrame;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.label.text = NSLocalizedString(@"Oops! The Internet connection appears to be offline.", nil);
}

@end
