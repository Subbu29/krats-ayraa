//
//  NotificationsDetailViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 01/07/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "NotificationsDetailViewController.h"

@interface NotificationsDetailViewController ()

@end

@implementation NotificationsDetailViewController
{
    BOOL didViewsSetup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    didViewsSetup = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    if (!didViewsSetup) {
        [self setUpViews];
        didViewsSetup = YES;
    }
}

-(void)setUpViews
{
    _notificationTitleLabel.text = [_incidentData.userStatus integerValue]==0?@"You have not yet marked your User Status":@"You have marked your User Status";
    
    _notificationTitleLabel.frame = CGRectMake(20, 40, self.view.frame.size.width-40, [self getHeightforLabel:_notificationTitleLabel]);
    
    // add layer
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[_incidentData.body dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
     [attrStr addAttributes:@{NSFontAttributeName: _notificationDescription.font} range:NSMakeRange(0, attrStr.length)];
    
    _notificationDescription.attributedText = attrStr;
    
    _notificationDescription.frame = CGRectMake(_notificationTitleLabel.frame.origin.x, _notificationTitleLabel.frame.origin.y+_notificationTitleLabel.frame.size.height+20, _notificationTitleLabel.frame.size.width, [self getHeightforAttributedLabel:_notificationDescription]);
    
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, _notificationDescription.frame.size.height+_notificationDescription.frame.origin.y);
    
    if ([_incidentData.userStatus integerValue]==0) {
        _bottomButtonsView.hidden = NO;
        _iamSafeButton.frame = CGRectMake(10, 10, (_bottomButtonsView.frame.size.width-30)/2, 40);
        _needHelpButton.frame = CGRectMake(_iamSafeButton.frame.origin.x+_iamSafeButton.frame.size.width+10, _iamSafeButton.frame.origin.y, (_bottomButtonsView.frame.size.width-30)/2, _iamSafeButton.frame.size.height);
    }
    else {
        _bottomButtonsView.hidden = YES;
    }
}

-(CGFloat)getHeightforLabel:(UILabel *)label
{
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel.font = label.font;
    tempLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tempLabel.numberOfLines = label.numberOfLines;
    CGFloat width= label.frame.size.width;
    tempLabel.attributedText = label.attributedText;
    CGSize size = [tempLabel sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}

-(CGFloat)getHeightforAttributedLabel:(UILabel *)label
{
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel.font = label.font;
    tempLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tempLabel.numberOfLines = label.numberOfLines;
    CGFloat width= label.frame.size.width;
    tempLabel.attributedText = label.attributedText;
    CGSize size = [tempLabel sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}

- (IBAction)needHelpButtonClicked:(id)sender
{
    
}

- (IBAction)iamSafeButtonClicked:(id)sender
{
    
}

@end
