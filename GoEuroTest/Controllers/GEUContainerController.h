//
//  GEUContainerController.h
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/13/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GEUConstants.h"

@interface GEUContainerController : UIViewController

@property (nonatomic, copy) void(^sortingChanged)(GEUSorting sorting);

@end
