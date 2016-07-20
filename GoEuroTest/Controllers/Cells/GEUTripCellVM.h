//
//  GEUTripCellVM.h
//  GoEuroTest
//
//  Created by Lisa Konysheva on 14/07/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GEUTrip;

@interface GEUTripCellVM : NSObject

@property (nonatomic, readonly) NSURL *logoUrl;
@property (nonatomic, readonly) NSString *tripTiming;
@property (nonatomic, readonly) NSString *price;
@property (nonatomic, readonly) NSString *duration;

- (instancetype)initWithTrip:(GEUTrip *)trip;

@end
