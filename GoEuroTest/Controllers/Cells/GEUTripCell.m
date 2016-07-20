//
//  GEUTripCell.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 14/07/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUTripCell.h"
#import "GEUTripCellVM.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GEUTripCell ()

@property (nonatomic, weak) IBOutlet UIImageView *logoView;
@property (nonatomic, weak) IBOutlet UILabel *timingLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *durationLabel;

@end

@implementation GEUTripCell

- (void)setCellViewModel:(GEUTripCellVM *)cellViewModel {
    if (_cellViewModel != cellViewModel) {
        _cellViewModel = cellViewModel;
        [self.logoView sd_setImageWithURL:cellViewModel.logoUrl];
        self.timingLabel.text = cellViewModel.tripTiming;
        self.priceLabel.attributedText = [self attributedStringForPrice:cellViewModel.price];
        self.durationLabel.text = cellViewModel.duration;
    }
}

- (NSAttributedString *)attributedStringForPrice:(NSString *)price {
    if (!price) {
        return nil;
    }

    NSArray *components = [price componentsSeparatedByString:@"."];
    if (components.count != 2) {
        return nil;
    }

    NSString *decimalPart = components[1];
    NSMutableAttributedString *atString = [[NSMutableAttributedString alloc] initWithString:price];
    [atString setAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:14]} range:[price rangeOfString:decimalPart]];
    return [atString copy];
}

@end
