//
//  Trip.h
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/12/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GEUTrip : NSObject

@property (nonatomic, readonly) NSInteger tripId;
@property (nonatomic, readonly) NSString *arrivalString;
@property (nonatomic, readonly) NSString *departureString;
@property (nonatomic, readonly) NSDate *arrivalDate;
@property (nonatomic, readonly) NSDate *departureDate;
@property (nonatomic, readonly) NSURL *logoUrl;
@property (nonatomic, readonly) NSNumber *price;
@property (nonatomic, readonly) NSInteger numberOfChanges;
@property (nonatomic, readonly) NSTimeInterval durationInterval;
@property (nonatomic, readonly) NSString *durationString;

- (instancetype)initWithDictionary:(NSDictionary *)info;

@end
