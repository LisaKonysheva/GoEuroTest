//
//  GEUBaseBehaviour.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/17/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUBaseBehavior.h"
#import "objc/runtime.h"

@implementation GEUBaseBehavior

-(void)setOwner:(id)owner {
    if (_owner != owner) {
        [self releaseLifetimeFromObject:_owner];
        _owner = owner;
        [self bindLifetimeToObject:_owner];
    }
}

- (void)bindLifetimeToObject:(id)object {
    objc_setAssociatedObject(object, (__bridge void *)self, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)releaseLifetimeFromObject:(id)object {
    objc_setAssociatedObject(object, (__bridge void *)self, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
