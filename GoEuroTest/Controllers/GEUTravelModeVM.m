//
//  GEUTravelModeVM.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 13/07/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUTravelModeVM.h"
#import "GEUDataService.h"
#import "GEUTripCellVM.h"
#import "GEUUtils.h"

@interface GEUTravelModeVM ()

@property (nonatomic) GEUDataService *service;
@property (nonatomic) GEUTravelMode mode;
@property (nonatomic) GEUSorting sorting;
@property (nonatomic) NSArray *trips;

@end

@implementation GEUTravelModeVM

- (instancetype)initWithMode:(GEUTravelMode)mode
                     sorting:(GEUSorting)sorting {
    self = [super init];
    if (self) {
        // TODO later we can inject this property with some DI lib
        _service = [[GEUDataService alloc] init];
        _mode = mode;
        _sorting = sorting;
    }
    return self;
}

- (BOOL)isNetworkAvailable {
    return [self.service isNetworkAvailable];
}

- (void)loadTrips {
    __weak typeof(self) wself = self;
    
    if (self.loadingChanged) {
        self.loadingChanged(YES);
    }
    [self.service getTripsWithTravelMode:self.mode completion:^(NSArray *trips) {
        wself.trips = trips;
        NSArray *cellViewModels = [self sortedTripsWithMode:wself.sorting];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.loadingChanged) {
                self.loadingChanged(NO);
            }
            if (wself.tripsChanged) {
                wself.tripsChanged(cellViewModels);
            }
        });
        
    } failure:^(NSError *error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           if (self.loadingChanged) {
               self.loadingChanged(NO);
           }
           if (wself.errorChanged) {
               wself.errorChanged(error);
           }
       });
    }];
}

- (NSArray <GEUTripCellVM *>*)sortedTripsWithMode:(GEUSorting)sorting {
    NSString *sortingKey;
    switch (sorting) {
        case GEUSortingDeparture:
            sortingKey = @"departureDate";
            break;
        case GEUSortingArrival:
            sortingKey = @"arrivalDate";
            break;
        case GEUSortingDuration:
            sortingKey = @"durationInterval";
            break;
        default:
            break;
    }
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:sortingKey ascending:YES];
    self.trips = [self.trips sortedArrayUsingDescriptors:@[descriptor]];
    NSArray *cellViewModels = [self.trips mapLike:^id(GEUTrip *trip) {
        return [[GEUTripCellVM alloc] initWithTrip:trip];
    }];
    return cellViewModels;
}

- (void)updateSortingWithMode:(GEUSorting)sorting {
    NSArray *sortedArray = [self sortedTripsWithMode:sorting];
    if (self.tripsChanged) {
        self.tripsChanged(sortedArray);
    }
}

@end
