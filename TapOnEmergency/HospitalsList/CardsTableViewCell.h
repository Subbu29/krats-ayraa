//
//  CardsTableViewCell.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 05/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardsCellProtocol <NSObject>

-(void)olaButtonClickedWithRow:(NSInteger)row;
-(void)directionButtonClickedWithRow:(NSInteger)row;
-(void)callButtonClickedWithRow:(NSInteger)row;

@end

@interface CardsTableViewCell : UITableViewCell

@property(strong,nonatomic) id <CardsCellProtocol> cellDelegate;

@property (weak, nonatomic) IBOutlet UIView *cardsView;
@property(nonatomic) NSInteger cellRow;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *hospitalNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UIButton *olaButton;
- (IBAction)olaButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *directionsButton;
- (IBAction)directionButtonsClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *callButton;
- (IBAction)callButtonClicked:(id)sender;

@end
