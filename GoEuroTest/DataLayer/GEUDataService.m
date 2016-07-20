//
//  GEUDataService.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/12/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

@import SystemConfiguration;
#import "GEUDataService.h"
#import "GEUConstants.h"
#import "GEUUtils.h"
#import "GEUTrip.h"
#import "Reachability.h"

@interface GEUDataService ()

@property (nonatomic) NSURLSession *session;

@end

@implementation GEUDataService

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return self;
}

- (BOOL)isNetworkAvailable {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

- (void)getTripsWithTravelMode:(GEUTravelMode)mode
               completion:(void(^)(NSArray *trips))completion
                  failure:(void(^)(NSError *error))failure {
    
    NSURL *url = [NSURL URLWithString:[self stringUrlForMode:mode]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (jsonObject) {
                if ([jsonObject isKindOfClass:[NSArray class]]) {
                    NSArray *travelItems = [NSArray new];
                    travelItems = [jsonObject mapLike:^id(id travelItem) {
                        if ([travelItem isKindOfClass:[NSDictionary class]]) {
                            return [[GEUTrip alloc] initWithDictionary:travelItem];
                        }
                        return nil;
                    }];
                    
                    
                    if (completion) {
                        completion(travelItems);
                    }
                }
            }
        } else {
            if (error.code == -1009) {
                
            }
        }

    }] resume];
}

- (NSString *)stringUrlForMode:(GEUTravelMode)mode {
    switch (mode) {
        case GEUTravelModeFlight:
            return GEUFlightsUrl;
            break;
        case GEUTravelModeTrain:
            return GEUTrainsUrl;
            break;
        case GEUTravelModeBus:
            return GEUBusesUrl;
            break;
        default:
            break;
    }
    return nil;
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    willCacheResponse:(NSCachedURLResponse *)proposedResponse
    completionHandler:(void (^)(NSCachedURLResponse * __nullable cachedResponse))completionHandler {
    
}



@end
