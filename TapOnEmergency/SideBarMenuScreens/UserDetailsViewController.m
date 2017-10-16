//
//  UserDetailsViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "TOEConstants.h"
#import "MedicalOptionsCollectionViewCell.h"
#import "TOECacheController.h"
#import "TOEAPIConstants.h"
#import "APILoaderView.h"

#define TOTAL_NO_OF_MEDICALS 6

#define HYPERTENSION_INDEX 0
#define HYPERTENSION_TITLE @"Hypertension"

#define ASTHAMA_INDEX 1
#define ASTHAMA_TITLE @"Asthama"

#define DIABETES_INDEX 2
#define DIABETES_TITLE @"Diabetes"

#define BLOOD_PRESSURE_INDEX 3
#define BLOOD_PRESSURE_TITLE @"Bloodpressure"

#define EPILEPSY_INDEX 4
#define EPILEPSY_TITLE @"Epilepsy"

#define THYROID_INDEX 5
#define THYROID_TITLE @"Thyroid"

#define MEDICAL_OPTION_CELL_IDENTIFIER @"MedicalOptionCellIdentifier"


#define SELECTED_CHECK_BOX @"Checked_Checkbox"
#define UNSELECTED_CHECK_BOX @"Unchecked_Checkbox"

#define SELECTED_CIRCLE @"Checked_Circle"
#define UNSELECTED_CIRCLE @"Unchecked_Circle"


#define EDIT_BUTTON_TAG 110
#define DELETE_BUTTON_TAG 111
#define DONE_BUTTON_TAG 112



#define TOTAL_NO_OF_BLOOD_GROUPS 8

#define A_POSITIVE_INDEX 0
#define A_POSITIVE_TITLE @"A+"

#define A_NEGATIVE_INDEX 1
#define A_NEGATIVE_TITLE @"A-"

#define B_POSITIVE_INDEX 2
#define B_POSITIVE_TITLE @"B+"

#define B_NEGATIVE_INDEX 3
#define B_NEGATIVE_TITLE @"B-"

#define AB_POSITIVE_INDEX 4
#define AB_POSITIVE_TITLE @"AB+"

#define AB_NEGATIVE_INDEX 5
#define AB_NEGATIVE_TITLE @"AB-"

#define O_POSITIVE_INDEX 6
#define O_POSITIVE_TITLE @"O+"

#define O_NEGATIVE_INDEX 7
#define O_NEGATIVE_TITLE @"O-"

@interface UserDetailsViewController ()

@end

@implementation UserDetailsViewController
{
    LoginDataModal *userData;
    UITextField *activeTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self populateData];
    [self registerCells];
    _tapGestureButton.hidden = YES;
    _listTableView.hidden = YES;
    if (_detailsType == AddNewRelative) {
        _userDetailsView.userInteractionEnabled = YES;
    }
    else {
        _userDetailsView.userInteractionEnabled = NO;
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [self setUpViews];
}

#pragma mark - Navigation bar Customisation -

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
    
    
    switch (_detailsType) {
        case UpdateRelativeDetails:
        {
            editButton.frame = CGRectMake(10, 5, 30, 30);
            
            UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            deleteButton.frame = CGRectMake(50, 5, 30, 30);
            [deleteButton setTitle:@"DE" forState:UIControlStateNormal];
            deleteButton.tag = DELETE_BUTTON_TAG;
            [deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            deleteButton.adjustsImageWhenHighlighted = NO;
            [rightView addSubview:editButton];
            [rightView addSubview:deleteButton];
            
            doneButton.hidden = YES;
        }
            break;
            
        case AddNewRelative:
            break;
        case UpdateUserDetails:
            [rightView addSubview:editButton];
            doneButton.hidden = YES;
            break;
            
        default:
            break;
    }
    [self textColorsInNonEditMode];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
}

-(void)editButtonClicked
{
    switch (_detailsType) {
        case UpdateUserDetails:
        {
            UIView *rightbarview = self.navigationItem.rightBarButtonItem.customView;
            UIButton *editButton  = [rightbarview viewWithTag:EDIT_BUTTON_TAG];
            UIButton *doneButton = [rightbarview viewWithTag:DONE_BUTTON_TAG];
            editButton.hidden = YES;
            doneButton.hidden = NO;
        }
            break;
            
        case UpdateRelativeDetails:
        {
            UIView *rightbarview = self.navigationItem.rightBarButtonItem.customView;
            UIButton *editButton  = [rightbarview viewWithTag:EDIT_BUTTON_TAG];
            UIButton *deleteButton = [rightbarview viewWithTag:DELETE_BUTTON_TAG];
            UIButton *doneButton = [rightbarview viewWithTag:DONE_BUTTON_TAG];
            editButton.hidden = YES;
            deleteButton.hidden = YES;
            doneButton.hidden = NO;
        }
            break;
        default:
            break;
    }
    // delete this lines and add in api responses
    _userDetailsView.userInteractionEnabled = YES;
    [self textColorsinEditMode];
}

-(void)editingDoneButtonClicked
{
    switch (_detailsType) {
        case UpdateUserDetails:
        {
            UIView *rightbarview = self.navigationItem.rightBarButtonItem.customView;
            UIButton *editButton  = [rightbarview viewWithTag:EDIT_BUTTON_TAG];
            UIButton *doneButton = [rightbarview viewWithTag:DONE_BUTTON_TAG];
            editButton.hidden = NO;
            doneButton.hidden = YES;
        }
            break;
            
        case UpdateRelativeDetails:
        {
            UIView *rightbarview = self.navigationItem.rightBarButtonItem.customView;
            UIButton *editButton  = [rightbarview viewWithTag:EDIT_BUTTON_TAG];
            UIButton *deleteButton = [rightbarview viewWithTag:DELETE_BUTTON_TAG];
            UIButton *doneButton = [rightbarview viewWithTag:DONE_BUTTON_TAG];
            editButton.hidden = NO;
            deleteButton.hidden = NO;
            doneButton.hidden = YES;
//            [self updatingRelative];
        }
            break;
        case AddNewRelative:
            break;
        default:
            break;
    }
    // delete this lines and add in api responses
    _userDetailsView.userInteractionEnabled = NO;
    [self textColorsInNonEditMode];
    // hit api
}

-(void)deleteButtonClicked
{
    switch (_detailsType) {
        case UpdateRelativeDetails:
        {
            // hit api
        }
            break;
        default:
            break;
    }
    // pop the view if success else show popup
}

#pragma mark - Registering cells -

-(void)registerCells
{
    [_medicalOptionsCollectionView registerNib:[UINib nibWithNibName:@"MedicalOptionsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:MEDICAL_OPTION_CELL_IDENTIFIER];
    [_medicalOptionsCollectionView registerClass:[MedicalOptionsCollectionViewCell class] forCellWithReuseIdentifier:MEDICAL_OPTION_CELL_IDENTIFIER];
}

-(void)populateData
{
    switch (_detailsType) {
        case UpdateUserDetails:
            [self populateUserDetails];
            break;
        case UpdateRelativeDetails:
            [self populateRelativeDetails];
            break;
        case AddNewRelative:
            [self clearDetails];
            break;
            
        default:
            break;
    }
}

-(void)populateUserDetails
{
    userData = [TOEConstants getUserData];
    _firstNameTextField.text = userData.firstName;
    _lastNameTextField.text = userData.lastName;
    _birthDateTextField.text = userData.birthDate;
    [_bloodGroupButton setTitle:userData.bloodGroup forState:UIControlStateNormal];
    _majorSurgeriesTextField.text = userData.majorSurgeries;
    _currentMedicationTextField.text = userData.currentMedication;
    
    if ([[userData.gender lowercaseString] isEqualToString:[NSString stringWithFormat:@"male"]]) {
        [_maleButton setImage:[UIImage imageNamed:SELECTED_CIRCLE] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
    }
    else if ([[userData.gender lowercaseString] isEqualToString:[NSString stringWithFormat:@"female"]]) {
        [_maleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:SELECTED_CIRCLE] forState:UIControlStateNormal];
    }
    else {
        [_maleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
    }
}

-(void)populateRelativeDetails
{
    _relativeNameTextField.text = _relativeData.relativeName;
    _relativeMobileNoTextField.text = _relativeData.mobileNumber;
    _relativeRelationTextField.text = _relativeData.relation;
    _relativeBirthDataTextField.text = _relativeData.birthDate;
    if (_relativeData.bloodGroup.length>0) {
        [_relativeBloodGroupButton setTitle:_relativeData.bloodGroup forState:UIControlStateNormal];
    }
    else {
        [_relativeBloodGroupButton setTitle:@"Blood Group" forState:UIControlStateNormal];
    }
    _majorSurgeriesTextField.text = _relativeData.majorSurgeries;
    _currentMedicationTextField.text = _relativeData.currentMedication;
    
    if ([[_relativeData.gender lowercaseString] isEqualToString:[NSString stringWithFormat:@"male"]]) {
        [_maleButton setImage:[UIImage imageNamed:SELECTED_CIRCLE] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
    }
    else if ([[_relativeData.gender lowercaseString] isEqualToString:[NSString stringWithFormat:@"female"]]) {
        [_maleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:SELECTED_CIRCLE] forState:UIControlStateNormal];
    }
    else {
        [_maleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
    }
}

-(void)clearDetails
{
    _relativeNameTextField.text = @"";
    _relativeMobileNoTextField.text = @"";
    _relativeRelationTextField.text = @"";
    _relativeBirthDataTextField.text = @"";
    [_relativeBloodGroupButton setTitle:@"Blood Group" forState:UIControlStateNormal];
    _majorSurgeriesTextField.text = @"";
    _currentMedicationTextField.text = @"";
    [_maleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
    [_femaleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
}

#pragma mark - setting views -

-(void)setUpViews
{
    [self setUpDetailView];
    [self setUpGenderView];
    [self setUpMedicalView];
    
    _userDetailsView.frame  = CGRectMake(0, 0, self.view.frame.size.width, _medicalView.frame.size.height+_medicalView.frame.origin.y);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, _userDetailsView.frame.size.height);
    
    [self setUpNavigationBar];
}

-(void)setUpDetailView
{
    switch (_detailsType) {
        case UpdateUserDetails:
            [self setUpUserInfoView];
            break;
            
        case AddNewRelative:
            [self setUpRelativeInfoView];
            break;
            
        case UpdateRelativeDetails:
            [self setUpRelativeInfoView];
            break;
            
        default:
            break;
    }
}

-(void)setUpUserInfoView
{
    _userInfoView.hidden = NO;
    _relativeInfoView.hidden = YES;
    _userInfoView.frame = CGRectMake(0, PADDING_10, self.view.frame.size.width, PADDING_50+PADDING_50+PADDING_20);
    [self setUpfirstNameTextField];
    [self setUplastNameTextField];
    [self setUpbirthDateTextField];
    [self setUpbloodGroupButton];
}

-(void)setUpGenderView
{
    CGFloat genderViewY = _userInfoView.hidden?_relativeInfoView.frame.origin.y+_relativeInfoView.frame.size.height:_userInfoView.frame.origin.y+_userInfoView.frame.size.height;
    
    _genderView.frame = CGRectMake(0, genderViewY+PADDING_10, self.view.frame.size.width,PADDING_50);
    [self setUpgenderLabel];
    [self setUpmaleButton];
    [self setUpfemaleButton];
}

-(void)setUpMedicalView
{
    _medicalView.frame = CGRectMake(0, _genderView.frame.origin.y+_genderView.frame.size.height+PADDING_10, self.view.frame.size.width,310);
    
    [self setUpmedicalLabel];
    [self setUpMedicalOptionsCollectionView];
    [self setUpmajorSurgeriesTextField];
    [self setUpcurrentMedicationTextField];
}


-(void)setUpfirstNameTextField
{
    _firstNameTextField.frame = CGRectMake(PADDING_20, PADDING_20, (_userInfoView.frame.size.width - PADDING_40-PADDING_10)/2, PADDING_40);
    _firstNameTextField.delegate = self;
    [self addBottomBorderToTextField:_firstNameTextField andBorderColor:[UIColor lightGrayColor]];
}
-(void)setUplastNameTextField
{
    _lastNameTextField.frame = CGRectMake(_firstNameTextField.frame.origin.x+_firstNameTextField.frame.size.width+PADDING_5, PADDING_20, _firstNameTextField.frame.size.width, PADDING_40);
    _lastNameTextField.delegate = self;
    [self addBottomBorderToTextField:_lastNameTextField andBorderColor:[UIColor lightGrayColor]];
}

-(void)setUpbirthDateTextField
{
    _birthDateTextField.frame = CGRectMake(_firstNameTextField.frame.origin.x, _firstNameTextField.frame.origin.y+_firstNameTextField.frame.size.height+PADDING_10, _firstNameTextField.frame.size.width, PADDING_40);
    // add date picker to it and done button
    [self addBottomBorderToTextField:_birthDateTextField andBorderColor:[UIColor lightGrayColor]];
}

-(void)setUpbloodGroupButton
{
    _bloodGroupButton.frame = CGRectMake(_birthDateTextField.frame.origin.x+_birthDateTextField.frame.size.width+PADDING_5, _birthDateTextField.frame.origin.y, _birthDateTextField.frame.size.width, PADDING_40);
    [self addBottomBorderToTextField:_bloodGroupButton andBorderColor:[UIColor lightGrayColor]];
}

-(void)setUpRelativeInfoView
{
    _userInfoView.hidden = YES;
    _relativeInfoView.hidden = NO;
    
    _relativeInfoView.frame = CGRectMake(0, PADDING_10, self.view.frame.size.width, PADDING_40+PADDING_40+PADDING_40+PADDING_50);
    
    _relativeNameTextField.frame = CGRectMake(PADDING_20, PADDING_10, (_relativeInfoView.frame.size.width - PADDING_40-PADDING_10)/2, PADDING_40);
    _relativeMobileNoTextField.frame = CGRectMake(_relativeNameTextField.frame.origin.x+_relativeNameTextField.frame.size.width+PADDING_10, PADDING_10, _relativeNameTextField.frame.size.width, PADDING_40);
    
    _relativeRelationTextField.frame = CGRectMake(PADDING_20, _relativeNameTextField.frame.origin.y+_relativeNameTextField.frame.size.height+PADDING_10, _relativeNameTextField.frame.size.width, PADDING_40);
    _relativeBirthDataTextField.frame = CGRectMake(_relativeRelationTextField.frame.origin.x+_relativeRelationTextField.frame.size.width+PADDING_10, _relativeRelationTextField.frame.origin.y, _relativeNameTextField.frame.size.width, PADDING_40);
    
    _relativeBloodGroupButton.frame = CGRectMake(PADDING_20, _relativeRelationTextField.frame.origin.y+_relativeRelationTextField.frame.size.height+PADDING_10, _relativeInfoView.frame.size.width - PADDING_40, PADDING_40);
    
    [self addBottomBorderToTextField:_relativeBloodGroupButton andBorderColor:[UIColor lightGrayColor]];
    [self addBottomBorderToTextField:_relativeBirthDataTextField andBorderColor:[UIColor lightGrayColor]];
    [self addBottomBorderToTextField:_relativeRelationTextField andBorderColor:[UIColor lightGrayColor]];
    [self addBottomBorderToTextField:_relativeMobileNoTextField andBorderColor:[UIColor lightGrayColor]];
    [self addBottomBorderToTextField:_relativeNameTextField andBorderColor:[UIColor lightGrayColor]];
}

-(void)setUpgenderLabel
{
    _genderLabel.frame = CGRectMake(PADDING_20,PADDING_10, 70, PADDING_30);
}

-(void)setUpmaleButton
{
    _maleButton.frame = CGRectMake(_genderLabel.frame.origin.x+_genderLabel.frame.size.width+PADDING_5, _genderLabel.frame.origin.y, 90, PADDING_30);
    _maleButton.imageEdgeInsets = UIEdgeInsetsMake(8, 5, 8, _maleButton.frame.size.width-19);
    _maleButton.titleEdgeInsets = UIEdgeInsetsMake(5, -10, 5, 0);
}

-(void)setUpfemaleButton
{
    _femaleButton.frame = CGRectMake(_maleButton.frame.origin.x+_maleButton.frame.size.width+PADDING_5, _maleButton.frame.origin.y, 110,PADDING_30);
    
    _femaleButton.imageEdgeInsets = UIEdgeInsetsMake(8, 5, 8, _femaleButton.frame.size.width-19);
    _femaleButton.titleEdgeInsets = UIEdgeInsetsMake(5, -10, 5, 0);
}

-(void)setUpmedicalLabel
{
    _medicalLabel.frame = CGRectMake(PADDING_20,PADDING_10, _medicalView.frame.size.width-PADDING_40, PADDING_30);
}

-(void)setUpMedicalOptionsCollectionView
{
    _medicalOptionsCollectionView.frame = CGRectMake(PADDING_20, _medicalLabel.frame.origin.y+_medicalLabel.frame.size.height+PADDING_10, _medicalView.frame.size.width-PADDING_40, 150);
}

-(void)setUpmajorSurgeriesTextField
{
    _majorSurgeriesTextField.frame = CGRectMake(PADDING_20, _medicalOptionsCollectionView.frame.origin.y+_medicalOptionsCollectionView.frame.size.height+PADDING_20, _medicalView.frame.size.width - PADDING_40, PADDING_40);
    [self addBottomBorderToTextField:_majorSurgeriesTextField andBorderColor:[UIColor lightGrayColor]];
    _majorSurgeriesTextField.delegate = self;
}

-(void)setUpcurrentMedicationTextField
{
    _currentMedicationTextField.frame = CGRectMake(PADDING_20, _majorSurgeriesTextField.frame.origin.y+_majorSurgeriesTextField.frame.size.height+PADDING_10, self.view.frame.size.width - PADDING_40, PADDING_40);
    [self addBottomBorderToTextField:_currentMedicationTextField andBorderColor:[UIColor lightGrayColor]];
    _currentMedicationTextField.delegate = self;
}

#pragma mark -  textfield delegate methods -

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeTextField = textField;
    NSLog(@"%@",textField.text);
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
}

#pragma mark - Action Button methods -

- (IBAction)bloodGroupButtonclicked:(id)sender
{
    _tapGestureButton.hidden = NO;
    _listTableView.hidden = NO;
    
    CGFloat restHeight = self.mainScrollView.frame.size.height - (_bloodGroupButton.frame.origin.y+_bloodGroupButton.frame.size.height+_userInfoView.frame.origin.y);
    restHeight = (restHeight>(44.0*9))?(44.0*9):restHeight;
    
    _listTableView.frame = CGRectMake(_bloodGroupButton.frame.origin.x, _bloodGroupButton.frame.origin.y+_bloodGroupButton.frame.size.height+_userInfoView.frame.origin.y, _bloodGroupButton.frame.size.width, restHeight);
    [_listTableView reloadData];
}

- (IBAction)maleButtonClicked:(id)sender
{
    
}

- (IBAction)femaleButtonClicked:(id)sender
{
    
}

- (IBAction)relativeBloodGroupButtonclicked:(id)sender
{
    _tapGestureButton.hidden = NO;
    _listTableView.hidden = NO;
    
    CGFloat restHeight = self.mainScrollView.frame.size.height - (_relativeBloodGroupButton.frame.origin.y+_relativeBloodGroupButton.frame.size.height+_relativeInfoView.frame.origin.y);
    restHeight = (restHeight>(44.0*9))?(44.0*9):restHeight;
    
    _listTableView.frame = CGRectMake(_relativeBloodGroupButton.frame.origin.x, _relativeBloodGroupButton.frame.origin.y+_relativeBloodGroupButton.frame.size.height+_relativeInfoView.frame.origin.y, _relativeBloodGroupButton.frame.size.width, restHeight);
    [_listTableView reloadData];
}

#pragma mark  - adding date picker -

-(void)addDatePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [self addDoneButton];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    
    [_birthDateTextField setInputView:datePicker];
}

-(void)addDoneButton
{
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    
    toolBar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)],nil];
    
    [toolBar sizeToFit];
    _birthDateTextField.inputAccessoryView = toolBar;
}

-(void)doneButtonClicked
{
    [_birthDateTextField resignFirstResponder];
}

-(void)dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker *)_birthDateTextField.inputView;
    [self removeErrorViewForTextfield:_birthDateTextField];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _birthDateTextField.text = [NSString stringWithFormat:@"%@",dateString];
}

#pragma mark - collection view delegate and data source -

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0f;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width-PADDING_40-PADDING_20)/2, PADDING_40);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return TOTAL_NO_OF_MEDICALS;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalOptionsCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:MEDICAL_OPTION_CELL_IDENTIFIER forIndexPath:indexPath];
    switch (indexPath.row) {
        case HYPERTENSION_INDEX:
            cell.medicalTitleLabel.text = HYPERTENSION_TITLE;
            switch (_detailsType) {
                case UpdateUserDetails:
                    cell.medicalImageView.image = [userData.hypertension integerValue] == 0 ? [UIImage imageNamed:UNSELECTED_CHECK_BOX]:[UIImage imageNamed:SELECTED_CHECK_BOX];
                    break;
                case UpdateRelativeDetails:
                    cell.medicalImageView.image = _relativeData.hypertension ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                case AddNewRelative:
                    cell.medicalImageView.image =  [UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case ASTHAMA_INDEX:
            cell.medicalTitleLabel.text = ASTHAMA_TITLE;
            switch (_detailsType) {
                case UpdateUserDetails:
                    cell.medicalImageView.image = [userData.asthama integerValue] == 0 ? [UIImage imageNamed:UNSELECTED_CHECK_BOX]:[UIImage imageNamed:SELECTED_CHECK_BOX];
                    break;
                case UpdateRelativeDetails:
                    cell.medicalImageView.image = _relativeData.asthama ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                case AddNewRelative:
                    cell.medicalImageView.image =  [UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case DIABETES_INDEX:
            cell.medicalTitleLabel.text = DIABETES_TITLE;
            switch (_detailsType) {
                case UpdateUserDetails:
                    cell.medicalImageView.image = [userData.diabetes integerValue] == 0 ? [UIImage imageNamed:UNSELECTED_CHECK_BOX]:[UIImage imageNamed:SELECTED_CHECK_BOX];
                    break;
                case UpdateRelativeDetails:
                    cell.medicalImageView.image = _relativeData.diabetes ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                case AddNewRelative:
                    cell.medicalImageView.image =  [UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case BLOOD_PRESSURE_INDEX:
            cell.medicalTitleLabel.text = BLOOD_PRESSURE_TITLE;
            switch (_detailsType) {
                case UpdateUserDetails:
                    cell.medicalImageView.image = [userData.bloodpressure integerValue] == 0 ? [UIImage imageNamed:UNSELECTED_CHECK_BOX]:[UIImage imageNamed:SELECTED_CHECK_BOX];
                    break;
                case UpdateRelativeDetails:
                    cell.medicalImageView.image = _relativeData.bloodpressure ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                case AddNewRelative:
                    cell.medicalImageView.image =  [UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case EPILEPSY_INDEX:
            cell.medicalTitleLabel.text = EPILEPSY_TITLE;
            switch (_detailsType) {
                case UpdateUserDetails:
                    cell.medicalImageView.image = [userData.epilepsy integerValue] == 0 ? [UIImage imageNamed:UNSELECTED_CHECK_BOX]:[UIImage imageNamed:SELECTED_CHECK_BOX];
                    break;
                case UpdateRelativeDetails:
                    cell.medicalImageView.image = _relativeData.epilepsy ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                case AddNewRelative:
                    cell.medicalImageView.image =  [UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case THYROID_INDEX:
            cell.medicalTitleLabel.text = THYROID_TITLE;
            switch (_detailsType) {
                case UpdateUserDetails:
                    cell.medicalImageView.image = [userData.thyroid integerValue] == 0 ? [UIImage imageNamed:UNSELECTED_CHECK_BOX]:[UIImage imageNamed:SELECTED_CHECK_BOX];
                    break;
                case UpdateRelativeDetails:
                    cell.medicalImageView.image = _relativeData.thyroid ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                case AddNewRelative:
                    cell.medicalImageView.image =  [UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
    cell.medicalTitleLabel.textColor = _userDetailsView.userInteractionEnabled?[UIColor blackColor]:[UIColor lightGrayColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalOptionsCollectionViewCell *cell = (MedicalOptionsCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    switch (indexPath.row) {
        case HYPERTENSION_INDEX:
            cell.medicalTitleLabel.text = HYPERTENSION_TITLE;
            switch (_detailsType) {
                case UpdateUserDetails:
                    userData.hypertension = [userData.hypertension integerValue]==0?@"1":@"0";
                    cell.medicalImageView.image = [userData.hypertension integerValue] == 0 ? [UIImage imageNamed:UNSELECTED_CHECK_BOX]:[UIImage imageNamed:SELECTED_CHECK_BOX];
                    break;
                case UpdateRelativeDetails:
                    _relativeData.hypertension = !_relativeData.hypertension;
                    cell.medicalImageView.image = _relativeData.hypertension ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                case AddNewRelative:
                    _relativeData.hypertension = !_relativeData.hypertension;
                    cell.medicalImageView.image =  [UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case ASTHAMA_INDEX:
            cell.medicalTitleLabel.text = ASTHAMA_TITLE;
            switch (_detailsType) {
                case UpdateUserDetails:
                    cell.medicalImageView.image = [userData.asthama integerValue] == 0 ? [UIImage imageNamed:UNSELECTED_CHECK_BOX]:[UIImage imageNamed:SELECTED_CHECK_BOX];
                    break;
                case UpdateRelativeDetails:
                    _relativeData.asthama = !_relativeData.asthama;
                    cell.medicalImageView.image = _relativeData.asthama ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                case AddNewRelative:
                    _relativeData.asthama = !_relativeData.asthama;
                    cell.medicalImageView.image = _relativeData.asthama ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case DIABETES_INDEX:
            cell.medicalTitleLabel.text = DIABETES_TITLE;
            switch (_detailsType) {
                case UpdateUserDetails:
                    cell.medicalImageView.image = [userData.diabetes integerValue] == 0 ? [UIImage imageNamed:UNSELECTED_CHECK_BOX]:[UIImage imageNamed:SELECTED_CHECK_BOX];
                    break;
                case UpdateRelativeDetails:
                    _relativeData.diabetes = !_relativeData.diabetes;
                    cell.medicalImageView.image = _relativeData.diabetes ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                case AddNewRelative:
                    _relativeData.diabetes = !_relativeData.diabetes;
                    cell.medicalImageView.image = _relativeData.diabetes ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case BLOOD_PRESSURE_INDEX:
            cell.medicalTitleLabel.text = BLOOD_PRESSURE_TITLE;
            switch (_detailsType) {
                case UpdateUserDetails:
                    cell.medicalImageView.image = [userData.bloodpressure integerValue] == 0 ? [UIImage imageNamed:UNSELECTED_CHECK_BOX]:[UIImage imageNamed:SELECTED_CHECK_BOX];
                    break;
                case UpdateRelativeDetails:
                    _relativeData.bloodpressure = !_relativeData.bloodpressure;
                    cell.medicalImageView.image = _relativeData.bloodpressure ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                case AddNewRelative:
                    _relativeData.bloodpressure = !_relativeData.bloodpressure;
                    cell.medicalImageView.image = _relativeData.bloodpressure ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case EPILEPSY_INDEX:
            cell.medicalTitleLabel.text = EPILEPSY_TITLE;
            switch (_detailsType) {
                case UpdateUserDetails:
                    cell.medicalImageView.image = [userData.epilepsy integerValue] == 0 ? [UIImage imageNamed:UNSELECTED_CHECK_BOX]:[UIImage imageNamed:SELECTED_CHECK_BOX];
                    break;
                case UpdateRelativeDetails:
                    _relativeData.epilepsy = !_relativeData.epilepsy;
                    cell.medicalImageView.image = _relativeData.epilepsy ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                case AddNewRelative:
                    _relativeData.epilepsy = !_relativeData.epilepsy;
                    cell.medicalImageView.image = _relativeData.epilepsy ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case THYROID_INDEX:
            cell.medicalTitleLabel.text = THYROID_TITLE;
            switch (_detailsType) {
                case UpdateUserDetails:
                    cell.medicalImageView.image = [userData.thyroid integerValue] == 0 ? [UIImage imageNamed:UNSELECTED_CHECK_BOX]:[UIImage imageNamed:SELECTED_CHECK_BOX];
                    break;
                case UpdateRelativeDetails:
                    _relativeData.thyroid = !_relativeData.thyroid;
                    cell.medicalImageView.image = _relativeData.thyroid ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                case AddNewRelative:
                    _relativeData.thyroid = !_relativeData.thyroid;
                    cell.medicalImageView.image = _relativeData.thyroid ? [UIImage imageNamed:SELECTED_CHECK_BOX]:[UIImage imageNamed:UNSELECTED_CHECK_BOX];
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - Handling Edit and Non Edit Mode -

-(void)textColorsInNonEditMode
{
    switch (_detailsType) {
        case UpdateUserDetails:
            _firstNameTextField.textColor = [UIColor lightGrayColor];
            _lastNameTextField.textColor= [UIColor lightGrayColor];
            _birthDateTextField.textColor= [UIColor lightGrayColor];
             [_bloodGroupButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            break;
        case UpdateRelativeDetails:
            _relativeNameTextField.textColor = [UIColor lightGrayColor];
            _relativeMobileNoTextField.textColor = [UIColor lightGrayColor];
            _relativeRelationTextField.textColor = [UIColor lightGrayColor];;
            _relativeBirthDataTextField.textColor = [UIColor lightGrayColor];
            [_relativeBloodGroupButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    [_maleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_femaleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_medicalOptionsCollectionView reloadData];
    _majorSurgeriesTextField.textColor = [UIColor lightGrayColor];
    _currentMedicationTextField.textColor = [UIColor lightGrayColor];
}

-(void)textColorsinEditMode
{
    switch (_detailsType) {
        case UpdateUserDetails:
            _firstNameTextField.textColor = [UIColor blackColor];
            _lastNameTextField.textColor= [UIColor blackColor];
            _birthDateTextField.textColor= [UIColor blackColor];
            [_bloodGroupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case UpdateRelativeDetails:
            _relativeNameTextField.textColor = [UIColor blackColor];
            _relativeMobileNoTextField.textColor = [UIColor blackColor];
            _relativeRelationTextField.textColor = [UIColor blackColor];;
            _relativeBirthDataTextField.textColor = [UIColor blackColor];
            [_relativeBloodGroupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    [_maleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_femaleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_medicalOptionsCollectionView reloadData];
    
    _majorSurgeriesTextField.textColor = [UIColor blackColor];
    _currentMedicationTextField.textColor = [UIColor blackColor];
}

#pragma mark - Adjusting Scroll View Contents -

-(void)adjustScrollViewForEditing
{
    
}

-(void)scrollViewForEditing
{
    
}

#pragma mark - API's Hitting -

-(void)addingRelative
{
    NSMutableDictionary *postDataDict = [self getRelativeDataDictionary];
    NSString *urlString = [NSString stringWithFormat:@"%@addRelative",TOE_WEB_API_URL];
    
    [[TOECacheController sharedInstance] addRelativeForUserWithUrl:urlString andPostData:postDataDict WithCompletionBlock:^(id addRelativeResponse, NSInteger statusCode) {
        switch (statusCode) {
            case STATUS_OK:
                
                break;
                
            default:
                break;
        }
    }];
}

-(void)deleteRelative
{
    
//        "relativeId": "11",
//        "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE0ODYyNzYwNjcsImp0aSI6InliZEo5OUdoNzRHOURNTDJ5dXRPeFYyYXFPNldEZXZBR1VPTHZPVldzV3c9IiwiaXNzIjoibG9jYWxob3N0IiwibmJmIjoxNDg2Mjc2MDY3LCJ1c2VySWQiOiI0NyJ9.JpB9SjPaW-bAJQWAlBonik5CxTdI-3KD2_fKubAfx6vynkApsuFMVUubf8UpIvR60khDeEFhr0PnEv7hrcdPdA",
//        "userId": "47"
    
//    http://taponemergency.com/web/m/v1/deleteRelative

    NSMutableDictionary *postDataDict =[[NSMutableDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithObjects:@[_relativeData.relativeId,userData.token,userData.userId] forKeys:@[@"relativeId",@"token",@"userId"]]];
    NSString *urlString = [NSString stringWithFormat:@"%@deleteRelative",TOE_WEB_API_URL];

    [[TOECacheController sharedInstance] deleteRelativeForUserWithUrl:urlString andPostData:postDataDict WithCompletionBlock:^(id deleteRelativeResponse, NSInteger statusCode) {
        switch (statusCode) {
            case STATUS_OK:
                
                break;
                
            default:
                break;
        }
    }];
}

-(void)updatingRelative
{
    NSMutableDictionary *postDataDict = [self getRelativeDataDictionary];
    [postDataDict setValue:_relativeData.relativeId forKey:@"relativeId"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@updateRelative",TOE_WEB_API_URL];
    
    [[TOECacheController sharedInstance] updateRelativeForUserWithUrl:urlString andPostData:postDataDict WithCompletionBlock:^(id updateRelativeResponse, NSInteger statusCode) {
        switch (statusCode) {
            case STATUS_OK:
                
                break;
                
            default:
                break;
        }
    }];
}

-(NSMutableDictionary *)getRelativeDataDictionary
{
    
    //    {
    //        "asthama": false,
    //        "birthDate": "2017-2-5",
    //        "bloodGroup": "AB-",
    //        "bloodpressure": false,
    //        "currentMedication": "",
    //        "diabetes": false,
    //        "epilepsy": false,
    //        "gender": "Male",
    //        "hypertension": true,
    //        "majorSurgeries": "",
    //        "mobileNumber": "7028942127",
    //        "relation": "Bro",
    //        "relativeName": "Anurag",
    //        "thyroid": false,
    //        "relativeId": "11",
    //        "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE0ODYyNzYwNjcsImp0aSI6InliZEo5OUdoNzRHOURNTDJ5dXRPeFYyYXFPNldEZXZBR1VPTHZPVldzV3c9IiwiaXNzIjoibG9jYWxob3N0IiwibmJmIjoxNDg2Mjc2MDY3LCJ1c2VySWQiOiI0NyJ9.JpB9SjPaW-bAJQWAlBonik5CxTdI-3KD2_fKubAfx6vynkApsuFMVUubf8UpIvR60khDeEFhr0PnEv7hrcdPdA",
    //        "userId": "47"
    //    }
    
    NSMutableDictionary *filledDataDict = [[NSMutableDictionary alloc] init];
    
    [filledDataDict setValue:_relativeData.birthDate forKey:@"birthDate"];
    [filledDataDict setValue:_relativeData.bloodGroup forKey:@"bloodGroup"];
    
    [filledDataDict setValue:_relativeData.currentMedication forKey:@"currentMedication"];
    [filledDataDict setValue:_relativeData.gender forKey:@"gender"];
    [filledDataDict setValue:_relativeData.majorSurgeries forKey:@"majorSurgeries"];
    [filledDataDict setValue:_relativeData.mobileNumber forKey:@"mobileNumber"];
    [filledDataDict setValue:_relativeData.relation forKey:@"relation"];
    [filledDataDict setValue:_relativeData.relativeName forKey:@"relativeName"];
    [filledDataDict setValue:userData.token forKey:@"token"];
    [filledDataDict setValue:userData.userId forKey:@"userId"];
    
    [filledDataDict setValue:_relativeData.asthama?@"true":@"false" forKey:@"asthama"];
    [filledDataDict setValue:_relativeData.bloodpressure?@"true":@"false" forKey:@"bloodpressure"];
    [filledDataDict setValue:_relativeData.diabetes?@"true":@"false" forKey:@"diabetes"];
    [filledDataDict setValue:_relativeData.epilepsy?@"true":@"false" forKey:@"epilepsy"];
    [filledDataDict setValue:_relativeData.hypertension?@"true":@"false" forKey:@"hypertension"];
    [filledDataDict setValue:_relativeData.thyroid?@"true":@"false" forKey:@"thyroid"];
    
    return filledDataDict;
}

#pragma mark - Error States -

-(void)showErrorForView:(UITextField *)textfield withText:(NSString *)errorMessage
{
    UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(textfield.frame.origin.x, textfield.frame.origin.y+textfield.frame.size.height + PADDING_2, textfield.frame.size.width, PADDING_15)];
    //    errorLabel.tag = textfield.tag + ERROR_LABELS_TAG_CONSTANT;
    errorLabel.text = errorMessage;
    errorLabel.font = [UIFont fontWithName:[NSString stringWithFormat:@"Helvetica Neue"] size:12.0];
    errorLabel.textColor = [UIColor redColor];
    errorLabel.textAlignment = NSTextAlignmentRight;
    [self addBottomBorderToTextField:textfield andBorderColor:[UIColor redColor]];
    [self.view addSubview:errorLabel];
}

-(void)addTopBorderToTextField:(UILabel *)errorLabel
{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 0.0f, errorLabel.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [errorLabel.layer addSublayer:bottomBorder];
}

-(void)removeErrorViewForTextfield:(UITextField *)textfield
{
    //    if ([self.view viewWithTag:(textfield.tag + ERROR_LABELS_TAG_CONSTANT)]!=nil) {
    //        [[self.view viewWithTag:(textfield.tag+ERROR_LABELS_TAG_CONSTANT)] removeFromSuperview];
    //    }
}

-(void)addBottomBorderToTextField:(UIView *)textField andBorderColor:(UIColor *)color
{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, textField.frame.size.height - 1.0f, textField.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = color.CGColor;
    [textField.layer addSublayer:bottomBorder];
}

#pragma mark - Gesture Button -

- (IBAction)tapGestureButtonClicked:(id)sender
{
    _tapGestureButton.hidden = YES;
    _listTableView.hidden = YES;
}

#pragma mark - TableView Delegate and Datasource methods -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TOTAL_NO_OF_BLOOD_GROUPS;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    switch (indexPath.row) {
        case A_POSITIVE_INDEX:
            cell.textLabel.text = A_POSITIVE_TITLE;
            break;
        case A_NEGATIVE_INDEX:
            cell.textLabel.text = A_NEGATIVE_TITLE;
            break;
        case B_POSITIVE_INDEX:
            cell.textLabel.text = B_POSITIVE_TITLE;
            break;
        case B_NEGATIVE_INDEX:
            cell.textLabel.text = B_NEGATIVE_TITLE;
            break;
        case AB_POSITIVE_INDEX:
            cell.textLabel.text = AB_POSITIVE_TITLE;
            break;
        case AB_NEGATIVE_INDEX:
            cell.textLabel.text = AB_NEGATIVE_TITLE;
            break;
        case O_POSITIVE_INDEX:
            cell.textLabel.text = O_POSITIVE_TITLE;
            break;
        case O_NEGATIVE_INDEX:
            cell.textLabel.text = O_NEGATIVE_TITLE;
            break;
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedBloodGroup;
    switch (indexPath.row) {
        case A_POSITIVE_INDEX:
            selectedBloodGroup = A_POSITIVE_TITLE;
            break;
        case A_NEGATIVE_INDEX:
            selectedBloodGroup = A_NEGATIVE_TITLE;
            break;
        case B_POSITIVE_INDEX:
            selectedBloodGroup = B_POSITIVE_TITLE;
            break;
        case B_NEGATIVE_INDEX:
            selectedBloodGroup = B_NEGATIVE_TITLE;
            break;
        case AB_POSITIVE_INDEX:
            selectedBloodGroup = AB_POSITIVE_TITLE;
            break;
        case AB_NEGATIVE_INDEX:
            selectedBloodGroup = AB_NEGATIVE_TITLE;
            break;
        case O_POSITIVE_INDEX:
            selectedBloodGroup = O_POSITIVE_TITLE;
            break;
        case O_NEGATIVE_INDEX:
            selectedBloodGroup = O_NEGATIVE_TITLE;
            break;
        default:
            break;
    }
    
    switch (_detailsType) {
        case AddNewRelative:
            _relativeData.bloodGroup = selectedBloodGroup;
            [_relativeBloodGroupButton setTitle:selectedBloodGroup forState:UIControlStateNormal];
            break;
        case UpdateRelativeDetails:
            _relativeData.bloodGroup = selectedBloodGroup;
            [_relativeBloodGroupButton setTitle:selectedBloodGroup forState:UIControlStateNormal];
            break;
        case UpdateUserDetails:
            [_bloodGroupButton setTitle:selectedBloodGroup forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    _tapGestureButton.hidden = YES;
    _listTableView.hidden = YES;
}

@end
