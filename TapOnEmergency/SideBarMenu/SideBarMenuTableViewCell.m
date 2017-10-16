//
//  SideBarMenuTableViewCell.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 05/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "SideBarMenuTableViewCell.h"

@implementation SideBarMenuTableViewCell

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
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"SideBarMenuTableViewCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}

@end
