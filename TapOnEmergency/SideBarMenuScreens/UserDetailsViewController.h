//
//  UserDetailsViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDataModal.h"

typedef enum : NSUInteger {
    UpdateUserDetails,
    UpdateRelativeDetails,
    AddNewRelative,
}ViewType;


@interface UserDetailsViewController : UIViewController<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic) ViewType detailsType;

@property (strong,nonatomic) UserRelatives *relativeData;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UIView *userDetailsView;

@property (weak, nonatomic) IBOutlet UIView *userInfoView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthDateTextField;
@property (weak, nonatomic) IBOutlet UIButton *bloodGroupButton;
- (IBAction)bloodGroupButtonclicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *relativeInfoView;

@property (weak, nonatomic) IBOutlet UITextField *relativeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *relativeMobileNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *relativeRelationTextField;
@property (weak, nonatomic) IBOutlet UITextField *relativeBirthDataTextField;

@property (weak, nonatomic) IBOutlet UIButton *relativeBloodGroupButton;
- (IBAction)relativeBloodGroupButtonclicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *genderView;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UIButton *maleButton;
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
- (IBAction)maleButtonClicked:(id)sender;
- (IBAction)femaleButtonClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *medicalView;
@property (weak, nonatomic) IBOutlet UILabel *medicalLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *medicalOptionsCollectionView;

@property (weak, nonatomic) IBOutlet UITextField *majorSurgeriesTextField;
@property (weak, nonatomic) IBOutlet UITextField *currentMedicationTextField;

@property (weak, nonatomic) IBOutlet UIButton *tapGestureButton;
- (IBAction)tapGestureButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end
