//
//  GEUUtils.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/12/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUUtils.h"

@implementation GEUUtils

@end

@implementation NSArray (GEUUtils)

- (NSArray*)mapLike:(id(^)(id))mapBlock {
    if (!mapBlock)
        return nil;
    NSMutableArray* mapped = [@[] mutableCopy];
    for (id obj in self) {
        if (obj) {
            [mapped addObject:mapBlock(obj)];
        }
    }
    return mapped;
}

@end

@implementation UIColor (GEUUtils)

+ (UIColor *)GEUOrangeColor {
    return [UIColor colorWithRed:252/255.f green:156/255.f blue:33/255.f alpha:1];
}

+ (UIColor *)GEUBlueColor {
    return [UIColor colorWithRed:15/255.f green:97/255.f blue:163/255.f alpha:1];
}

@end