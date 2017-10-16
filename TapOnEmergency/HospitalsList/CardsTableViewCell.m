//
//  CardsTableViewCell.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 05/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "CardsTableViewCell.h"

@implementation CardsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpViews];
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
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"CardsTableViewCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}


-(void)setUpViews
{
    _cardsView.layer.masksToBounds = NO;
    _cardsView.layer.shadowColor = [UIColor blackColor].CGColor;
    _cardsView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    _cardsView.layer.shadowOpacity = 0.5f;
}

- (IBAction)callButtonClicked:(id)sender {
    if ([self.cellDelegate respondsToSelector:@selector(callButtonClickedWithRow:)]) {
        [self.cellDelegate callButtonClickedWithRow:_cellRow];
    }
}
- (IBAction)directionButtonsClicked:(id)sender {
    if ([self.cellDelegate respondsToSelector:@selector(directionButtonClickedWithRow:)]) {
        [self.cellDelegate directionButtonClickedWithRow:_cellRow];
    }
}
- (IBAction)olaButtonClicked:(id)sender {
    if ([self.cellDelegate respondsToSelector:@selector(olaButtonClickedWithRow:)]) {
        [self.cellDelegate olaButtonClickedWithRow:_cellRow];
    }
}
@end
