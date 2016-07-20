//
//  GEUDataService.h
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/12/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GEUConstants.h"

@interface GEUDataService : NSObject

- (BOOL)isNetworkAvailable;
- (void)getTripsWithTravelMode:(GEUTravelMode)mode
                    completion:(void(^)(NSArray *trips))completion
                       failure:(void(^)(NSError *error))failure;

@end
