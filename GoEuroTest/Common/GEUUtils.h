//
//  GEUUtils.h
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/12/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GEUUtils : NSObject

@end

@interface NSArray (GEUUtils)

- (NSArray*)mapLike:(id(^)(id))mapBlock;

@end

@interface UIColor (GEUUtils)

+ (UIColor *)GEUOrangeColor;
+ (UIColor *)GEUBlueColor;

@end
