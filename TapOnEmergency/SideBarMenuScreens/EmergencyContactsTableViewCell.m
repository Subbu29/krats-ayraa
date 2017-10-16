//
//  EmergencyContactsTableViewCell.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 09/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "EmergencyContactsTableViewCell.h"

@implementation EmergencyContactsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapGestureRecognizer];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5; //seconds
    [self addGestureRecognizer:lpgr];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"EmergencyContactsTableViewCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}

-(void)handleLongPress:(UILongPressGestureRecognizer*)sender
{
    if ([_cellDelegate respondsToSelector:@selector(cellRespondedForLongPressWithIndexPath:)]&& (sender.state == UIGestureRecognizerStateBegan)) {
        NSLog(@"long press called");
        [_cellDelegate cellRespondedForLongPressWithIndexPath:_indexPathOfCell];
    }
}

-(void)cellTapped
{
    NSLog(@"tapped called");
    if ([_cellDelegate respondsToSelector:@selector(cellRespondsForTapWithIndexPath:)]) {
        [_cellDelegate cellRespondsForTapWithIndexPath:_indexPathOfCell];
    }

}


@end
