//
//  GEUTravelModeVM.h
//  GoEuroTest
//
//  Created by Lisa Konysheva on 13/07/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GEUConstants.h"

@interface GEUTravelModeVM : NSObject

- (instancetype)initWithMode:(GEUTravelMode)mode
                     sorting:(GEUSorting)sorting;

- (BOOL)isNetworkAvailable;
- (void)loadTrips;
- (void)updateSortingWithMode:(GEUSorting)sorting;

@property (nonatomic, copy) void(^tripsChanged)(NSArray *trips);
@property (nonatomic, copy) void(^errorChanged)(NSError *error);
@property (nonatomic, copy) void(^loadingChanged)(BOOL loading);

@end
