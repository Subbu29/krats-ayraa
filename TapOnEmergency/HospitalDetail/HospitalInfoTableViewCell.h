//
//  HospitalInfoTableViewCell.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 14/04/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *hospitalNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalSpecialityLabel;

@end
