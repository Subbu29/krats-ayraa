//
//  UserProfileViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 23/08/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "UserProfileViewController.h"
#import "LoginDataModal.h"
#import "TOEConstants.h"

#define EDIT_BUTTON_TAG 140
#define DONE_BUTTON_TAG 141

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController
{
    BOOL editMode;
    LoginDataModal *userData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    editMode = NO;
    [self loadViewData];
    [self setUpNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidLayoutSubviews
{
    
}

-(void)setUpNavigationBar
{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(50, 5, 30, 30);
    [editButton setTitle:@"E" forState:UIControlStateNormal];
    editButton.tag = EDIT_BUTTON_TAG;
    [editButton addTarget:self action:@selector(editButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    editButton.adjustsImageWhenHighlighted = NO;
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(50, 5, 30, 30);
    doneButton.tag = DONE_BUTTON_TAG;
    [doneButton setTitle:[NSString stringWithFormat:@"DO"] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(editingDoneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    doneButton.adjustsImageWhenHighlighted = NO;
    
    [rightView addSubview:doneButton];
    [rightView addSubview:editButton];
    doneButton.hidden = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
}

-(void)editButtonClicked
{
    _editView.hidden = NO;
    _nonEditView.hidden = YES;
}

-(void)editingDoneButtonClicked
{
    //  after api hit
    _editView.hidden = YES;
    _nonEditView.hidden = NO;
}

-(void)loadViewData
{
    userData = [TOEConstants getUserData];
//    _userProfileImage
    _userName.text = [NSString stringWithFormat:@"%@ %@",userData.firstName,userData.lastName];
    _emailIdLabel.text = userData.emailId;
    _phoneNoLabel.text = userData.mobileNumber;
    
    _phoneNoTextField.text = userData.mobileNumber;
    _emailIdTextField.text = userData.emailId;
}

- (IBAction)logoutButtonClicked:(id)sender
{
    // logout user
    
}

@end
