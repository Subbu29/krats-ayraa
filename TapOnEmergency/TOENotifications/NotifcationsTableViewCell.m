//
//  NotifcationsTableViewCell.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/06/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "NotifcationsTableViewCell.h"

@implementation NotifcationsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"NotifcationsTableViewCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}

@end
