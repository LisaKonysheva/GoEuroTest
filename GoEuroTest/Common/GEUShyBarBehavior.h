//
//  ShyBarBehavior.h
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/17/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GEUBaseBehavior.h"

@interface GEUShyBarBehavior : GEUBaseBehavior <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *bottomBar;


@end
