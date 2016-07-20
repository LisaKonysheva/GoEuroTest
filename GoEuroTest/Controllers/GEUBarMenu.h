//
//  GEUBarMenu.h
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/16/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GEUTopMenuDelegate.h"

IB_DESIGNABLE

@interface GEUBarMenu : UIView

@property (nonatomic) NSArray<NSString *> * titles;
@property (nonatomic) IBInspectable BOOL showIndicator;
@property (nonatomic) IBInspectable BOOL applyUnderlineStyle;
@property (nonatomic, weak) id<GEUTopMenuDelegate> delegate;

- (void)selectItemAtIndex:(NSInteger)index;

@end
