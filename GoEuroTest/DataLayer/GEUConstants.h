//
//  GEUConstants.h
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/12/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GEUConstants : NSObject

extern NSString *const GEUViewControllerViewDidLayoutSubviews;

extern NSString * const GEUFlightsUrl;
extern NSString * const GEUTrainsUrl;
extern NSString * const GEUBusesUrl;

typedef NS_ENUM (NSUInteger, GEUTravelMode) {
    GEUTravelModeFlight = 1,
    GEUTravelModeTrain,
    GEUTravelModeBus
};

typedef NS_ENUM (NSUInteger, GEUSorting) {
    GEUSortingDeparture = 1,
    GEUSortingArrival,
    GEUSortingDuration
};

@end
