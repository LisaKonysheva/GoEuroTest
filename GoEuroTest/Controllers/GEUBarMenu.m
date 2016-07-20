//
//  GEUBarMenu.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/16/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUBarMenu.h"
#import "GEUUtils.h"

static const CGFloat GEUIndicatorHeight = 4;
static const NSTimeInterval GEUIAnimationDuration = 0.3;
static const CGFloat GEUIIndicatorMargin = 10;

@interface GEUBarMenu ()

@property (nonatomic) NSArray<UIButton *> *menuButtons;
@property (nonatomic) UIView *indicatorView;

@end

@implementation GEUBarMenu

- (void)layoutSubviews {
    if (self.menuButtons) {
        CGFloat currentX = 0;
        CGFloat buttonWidth = self.frame.size.width / self.menuButtons.count;
        CGFloat buttonHeight = self.frame.size.height;
        
        for (UIButton *button in self.menuButtons) {
            [button removeFromSuperview];
            [self addSubview:button];
            button.frame = (CGRect){currentX, 0, buttonWidth, buttonHeight};
            currentX += buttonWidth;
        }
        
        if (!self.indicatorView && self.showIndicator) {
            self.indicatorView = [[UIView alloc] initWithFrame:(CGRect){GEUIIndicatorMargin, self.frame.size.height - GEUIndicatorHeight, (self.frame.size.width / self.menuButtons.count) - 2*GEUIIndicatorMargin, GEUIndicatorHeight}];
            self.indicatorView.backgroundColor = [UIColor GEUOrangeColor];
            [self addSubview:self.indicatorView];
        }
    }
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    if (_titles != titles) {
        _titles = titles;
    }
    NSMutableArray *mutableButtons = [NSMutableArray array];
    NSInteger index = 0;
    for (NSString *title in titles) {
        index++;
        UIButton *button = [[UIButton alloc] init];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.textColor = [UIColor whiteColor];
        [button setTitle:title forState:UIControlStateNormal];
        button.tag = index;
        [button addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [mutableButtons addObject:button];
    }
    self.menuButtons = [mutableButtons copy];
    [self selectItemAtIndex:1];
    [self setNeedsLayout];
}

- (void)menuButtonAction:(UIButton *)sender {
    NSInteger index = sender.tag;
    [self selectItemAtIndex:index];
    if ([self.delegate respondsToSelector:@selector(didTappedMenuItemAtIndex:)]) {
        [self.delegate didTappedMenuItemAtIndex:index];
    }
}

- (void)selectItemAtIndex:(NSInteger)index {
    for (UIButton *button in self.menuButtons) {
        if (button.tag == index) {
            UIFont *selectedFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
            if (self.applyUnderlineStyle) {
                NSAttributedString *attString = [[NSAttributedString alloc] initWithString:self.titles[button.tag - 1] attributes:@{NSFontAttributeName : selectedFont, NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle), NSUnderlineColorAttributeName : [UIColor whiteColor]}];
                [button setAttributedTitle:attString forState:UIControlStateNormal];
            } else {
                button.titleLabel.font = selectedFont;
            }
        } else {
            UIFont *normalFont = [UIFont fontWithName:@"HelveticaNeue" size:15];
            if (self.applyUnderlineStyle) {
                NSAttributedString *attString = [[NSAttributedString alloc] initWithString:self.titles[button.tag - 1] attributes:@{NSFontAttributeName : normalFont}];
               [button setAttributedTitle:attString forState:UIControlStateNormal];
            } else {
                button.titleLabel.font = normalFont;
            }
        }
    }
    
    if (self.showIndicator) {
        [UIView animateWithDuration:GEUIAnimationDuration animations:^{
            CGFloat updatedOrigin = (index - 1) * self.frame.size.width / self.menuButtons.count + GEUIIndicatorMargin;
            CGRect oldFrame = self.indicatorView.frame;
            self.indicatorView.frame = (CGRect){updatedOrigin, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height};
        }];
    }
}

@end
