//
//  HospitalInfoTableViewCell.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 14/04/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "HospitalInfoTableViewCell.h"
#import "TOEConstants.h"

@implementation HospitalInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _shadowView.layer.cornerRadius= 2.0;
    _shadowView.layer.masksToBounds = NO;
    _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    _shadowView.layer.shadowOpacity = 0.5f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"HospitalInfoTableViewCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}

@end
