//
//  Trip.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/12/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUTrip.h"

@interface GEUTrip ()

@property (nonatomic, readwrite) NSDate *arrivalDate;
@property (nonatomic, readwrite) NSDate *departureDate;

@end

@implementation GEUTrip

- (instancetype)initWithDictionary:(NSDictionary *)info {
    self = [super init];
    if (self) {
        _arrivalString = info[@"arrival_time"];
        _departureString = info[@"departure_time"];
        _price = @([info[@"price_in_euros"] doubleValue]);
        _numberOfChanges = [info[@"number_of_stops"] integerValue];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm";
        self.departureDate = [formatter dateFromString:_departureString];
        self.arrivalDate = [formatter dateFromString:_arrivalString];
        
        if (self.departureDate && self.arrivalDate) {
            NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitHour|NSCalendarUnitMinute
                                                                fromDate:self.departureDate
                                                                  toDate:self.arrivalDate
                                                                 options:0];
            _durationInterval = [self.arrivalDate timeIntervalSinceDate:self.departureDate];
            _durationString = [NSString stringWithFormat:@"%@:%@h", @(components.hour).stringValue, @(components.minute).stringValue];
        }
        
        if (info[@"provider_logo"]) {
            NSString *logoString = info[@"provider_logo"];
            logoString = [logoString stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
            _logoUrl = [NSURL URLWithString:logoString];
        }
    }
    return self;
}

@end
