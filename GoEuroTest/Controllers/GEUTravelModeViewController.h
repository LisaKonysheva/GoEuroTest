//
//  GEUTravelModeViewController.h
//  GoEuroTest
//
//  Created by Lisa Konysheva on 13/07/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GEUConstants.h"
#import "GEUContainerController.h"

@interface GEUTravelModeViewController : UIViewController

@property (nonatomic, weak) GEUContainerController *parent;
@property (nonatomic) GEUTravelMode travelMode;
@property (nonatomic) GEUSorting sortingMode;

- (void)updateSorting;
- (void)reloadTrips;

@end
