//
//  MedicalOptionsCollectionViewCell.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/07/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "MedicalOptionsCollectionViewCell.h"

@implementation MedicalOptionsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MedicalOptionsCollectionViewCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}


@end
