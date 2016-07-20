//
//  GEUProxyBehavior.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/17/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUProxyBehavior.h"

@implementation GEUProxyBehavior

@synthesize targets = _targets;

- (NSArray *)targets {
    NSMutableArray *mutableResult = [@[] mutableCopy];
    for (NSValue *targetValue in _targets) {
        [mutableResult addObject:[targetValue nonretainedObjectValue]];
    }
    return [mutableResult copy];
}

- (void)setTargets:(NSArray *)targets {
    NSMutableArray *mutableResult = [@[] mutableCopy];
    for (id target in targets) {
        [mutableResult addObject:[NSValue valueWithNonretainedObject:target]];
    }
    _targets = [mutableResult copy];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature *sig = [super methodSignatureForSelector:sel];
    if (!sig) {
        for (NSValue *nonRetainedValue in _targets) {
            id obj = [nonRetainedValue nonretainedObjectValue];
            if ((sig = [obj methodSignatureForSelector:sel])) {
                break;
            }
        }
    }
    return sig;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL base = [super respondsToSelector:aSelector];
    if (base) {
        return base;
    }
    BOOL responds = NO;
    for (NSValue *nonRetainedValue in _targets) {
        id obj = [nonRetainedValue nonretainedObjectValue];
        if ([obj respondsToSelector:aSelector]) {
            responds = YES;
            break;
        }
    }
    return responds;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    for (NSValue *nonRetain in _targets) {
        id obj = [nonRetain nonretainedObjectValue];
        if ([obj respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:obj];
        }
    }
}

@end
