//
//  GEUTripCellVM.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 14/07/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUTripCellVM.h"
#import "GEUTrip.h"

@implementation GEUTripCellVM

- (instancetype)initWithTrip:(GEUTrip *)trip {
    self = [super init];
    if (self) {
        _logoUrl = trip.logoUrl;
        _tripTiming = [NSString stringWithFormat:@"%@ - %@", trip.departureString, trip.arrivalString];
        _price = [NSString stringWithFormat:@"€ %.2f", [trip.price floatValue]];
        
        NSString *changesLocalized = [NSString stringWithFormat:NSLocalizedString(@"%d changes", nil), trip.numberOfChanges];
        _duration = [NSString stringWithFormat:@"%@ %@", changesLocalized, trip.durationString];
    }
    return self;
}


@end
