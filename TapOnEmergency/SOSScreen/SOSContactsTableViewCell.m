//
//  SOSContactsTableViewCell.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 19/05/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "SOSContactsTableViewCell.h"

@implementation SOSContactsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SOSContactsTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

@end
