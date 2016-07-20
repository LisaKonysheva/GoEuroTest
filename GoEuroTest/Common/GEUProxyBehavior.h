//
//  GEUProxyBehavior.h
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/17/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUBaseBehavior.h"

@interface GEUProxyBehavior : GEUBaseBehavior

@property (nonatomic, strong) IBOutletCollection(id) NSArray *targets;

@end
