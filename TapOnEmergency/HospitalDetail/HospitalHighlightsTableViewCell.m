//
//  HospitalHighlightsTableViewCell.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 14/04/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "HospitalHighlightsTableViewCell.h"

@implementation HospitalHighlightsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _shadowView.layer.cornerRadius= 5.0;
    _shadowView.layer.masksToBounds = NO;
    _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    _shadowView.layer.shadowOpacity = 0.5f;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"HospitalHighlightsTableViewCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}

@end
