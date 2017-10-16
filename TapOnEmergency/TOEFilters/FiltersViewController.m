//
//  FiltersViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 12/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "FiltersViewController.h"
#import "TOEConstants.h"
#import "FiltersObject.h"

#define PROBLEM_TYPE_SELECTED 0
#define AGE_SELECTED 1
#define LOCATIONS_SELECTED 2


#define SELECTED_CHECK_BOX @"Checked_Checkbox"
#define UNSELECTED_CHECK_BOX @"Unchecked_Checkbox"

#define SELECTED_CIRCLE @"Checked_Circle"
#define UNSELECTED_CIRCLE @"Unchecked_Circle"

#define UNSELECTED_EMERGENCY_BUTTON_COLOR [UIColor colorWithRed:114.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:1.0f]

@interface FiltersViewController ()

@end

@implementation FiltersViewController
{
    BOOL setFramesFirstTime;
    NSMutableArray *tableViewDataArray;
    NSInteger selectedNumber;
    BOOL isEmergency;
    FiltersObject *filterObj;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    filterObj = [FiltersObject copyOfFilterObj];
    setFramesFirstTime  = YES;
    isEmergency = [TOEConstants isInEmergencyMode];
    if (isEmergency) {
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    }
    else {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0/255.0f green:160.0/255.0f blue:223.0/255.0f alpha:1.0f];
    }

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    if (setFramesFirstTime) {
        [self setUpViews];
        setFramesFirstTime = !setFramesFirstTime;
    }
}

#pragma mark - setup views -

-(void)setUpViews
{
    isEmergency?[self setupEmergencyFilterView]:[self setupNormalFilterView];
    [self setUpNavigationBar];
}

-(void)setUpNavigationBar
{
    if (isEmergency) {
        self.navigationBarView.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:67.0f/255.0f blue:52.0f/255.0f alpha:1.0f];
        self.titleLabel.text = [NSString stringWithFormat:@"Filter"];
        // blue color 2,169,242
        // emergency color 143 57,63
    }
    else
    {
        self.navigationBarView.backgroundColor = [UIColor colorWithRed:2.0f/255.0f green:169.0f/255.0f blue:242.0f/255.0f alpha:1.0f];        self.titleLabel.text = [NSString stringWithFormat:@"Filter in Browse Mode"];
    }
}

- (IBAction)backButtonClicked:(id)sender
{
    // dismiss view
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Normal Mode Filters -

-(void)setupNormalFilterView
{
    self.emergencyFiltersView.hidden = YES;
    self.normalFiltersView.hidden = NO;
    // add border to tf
    [self setUpKmTextfield];
    [self setUpFilterLabel];
    
    [TOEConstants setImageToRightForButton:_handleEmergenciesButton];
    [TOEConstants setImageToRightForButton:_parkingButton];
    [TOEConstants setImageToRightForButton:_cashlessInsuranceButton];
    
    [self updateHasCashLessInsuranceButton];
    [self updateHasParkingButton];
    [self updateHandleEmergenciesButton];
    
    // keep search bar in position according to clear button
}

-(void)setUpFilterLabel
{
    [self addBottomBorderToTextField:_filterLabel andBorderColor:[UIColor colorWithRed:0.0/255.0f green:140.0/255.0f blue:124.0/255.0f alpha:1.0f]];
}

-(void)updateHasCashLessInsuranceButton
{
    if (filterObj.hasCashLessInsurance) {
        [_cashlessInsuranceButton setImage:[UIImage imageNamed:SELECTED_CHECK_BOX] forState:UIControlStateNormal];
    }
    else {
        [_cashlessInsuranceButton setImage:[UIImage imageNamed:UNSELECTED_CHECK_BOX] forState:UIControlStateNormal];
    }
}

-(void)updateHasParkingButton
{
    if (filterObj.hasParking) {
        [_parkingButton setImage:[UIImage imageNamed:SELECTED_CHECK_BOX] forState:UIControlStateNormal];
    }
    else {
        [_parkingButton setImage:[UIImage imageNamed:UNSELECTED_CHECK_BOX] forState:UIControlStateNormal];
    }
}

-(void)updateHandleEmergenciesButton
{
    if (filterObj.hasHandleEmergencies) {
        [_handleEmergenciesButton setImage:[UIImage imageNamed:SELECTED_CHECK_BOX] forState:UIControlStateNormal];
    }
    else {
        [_handleEmergenciesButton setImage:[UIImage imageNamed:UNSELECTED_CHECK_BOX] forState:UIControlStateNormal];
    }
}

-(void)setUpKmTextfield
{
    [self addBottomBorderToTextField:_kmTextField andBorderColor:[UIColor lightGrayColor]];
    [self addDoneButtonForKMSTextField];
    if (filterObj.hospitalRadius>0) {
        _kmTextField.text = filterObj.hospitalRadius;
    }
    _kmTextField.delegate = self;
}

-(void)addDoneButtonForKMSTextField
{
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    
    toolBar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)],nil];
    
    [toolBar sizeToFit];
    _kmTextField.inputAccessoryView = toolBar;
}

-(void)doneButtonClicked
{
    [self addBottomBorderToTextField:_kmTextField andBorderColor:[UIColor lightGrayColor]];
    filterObj.hospitalRadius = _kmTextField.text;
    [_kmTextField resignFirstResponder];
}

-(void)addBottomBorderToTextField:(UIView *)view andBorderColor:(UIColor *)color
{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, view.frame.size.height - 1.0f, view.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = color.CGColor;
    [view.layer addSublayer:bottomBorder];
}


#pragma mark - textfield delegate -

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self addBottomBorderToTextField:textField andBorderColor:[UIColor colorWithRed:0.0/255.0f green:140.0/255.0f blue:124.0/255.0f alpha:1.0f]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addBottomBorderToTextField:textField andBorderColor:[UIColor lightGrayColor]];
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length>1) {
        return NO;
    }
    
    if ((textField.text.length == 4) && (string.length > 0)) {
            return NO;
    }
    return YES;
}

#pragma mark - Normal Filter Action Methods -

- (IBAction)cashlessButtonClicked:(id)sender
{
    filterObj.hasCashLessInsurance = !filterObj.hasCashLessInsurance;
    [self updateHasCashLessInsuranceButton];
}

- (IBAction)parkingButtonClicked:(id)sender
{
    filterObj.hasParking = !filterObj.hasParking;
    [self updateHasParkingButton];
}

- (IBAction)handleEmergenciesButtonClicked:(id)sender
{
    filterObj.hasHandleEmergencies = !filterObj.hasHandleEmergencies;
    [self updateHandleEmergenciesButton];
}

- (IBAction)searchButtonClicked:(id)sender
{
//    isEmergency = YES;
//    [self setUpViews];
    if ([_filtersDelegate respondsToSelector:@selector(reloadViewAccordingToFilters)]) {
        [FiltersObject setFilterObjectAs:filterObj];
        [_filtersDelegate reloadViewAccordingToFilters];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Emergency Mode Filters -

-(void)setupEmergencyFilterView
{
    self.normalFiltersView.hidden = YES;
    self.emergencyFiltersView.hidden = NO;
    [self addBottomBorderToTextField:_typeOfProblemButton andBorderColor:[UIColor lightGrayColor]];
    [self addBottomBorderToTextField:_ageButton andBorderColor:[UIColor lightGrayColor]];
    [self addBottomBorderToTextField:_locationButton andBorderColor:[UIColor lightGrayColor]];
    [TOEConstants setImageToRightForButton:_familyMemberButton];
    
    _maleButton.imageEdgeInsets = UIEdgeInsetsMake(8, 5, 8, _maleButton.frame.size.width-19);
    _maleButton.titleEdgeInsets = UIEdgeInsetsMake(5, -10, 5, 0);
    
    _femaleButton.imageEdgeInsets = UIEdgeInsetsMake(8, 5, 8, _femaleButton.frame.size.width-19);
    _femaleButton.titleEdgeInsets = UIEdgeInsetsMake(5, -10, 5, 0);
    
    [self loadEmergencyFilterData];
}

-(void)loadEmergencyFilterData
{
    [self updateFamilyMemberData];
    [self updateTypeOfProblemData];
    [self updateAgeData];
    [self updateLocationData];
    [self updateGenderButtonData];
}

-(void)updateFamilyMemberData
{
    if (filterObj.isFamilyMember) {
        [_familyMemberButton setImage:[UIImage imageNamed:SELECTED_CHECK_BOX] forState:UIControlStateNormal];
    }
    else {
        [_familyMemberButton setImage:[UIImage imageNamed:UNSELECTED_CHECK_BOX] forState:UIControlStateNormal];
    }
}

-(void)updateTypeOfProblemData
{
    if (filterObj.typeOfProblem.length>0) {
        [_typeOfProblemButton setTitle:filterObj.typeOfProblem forState:UIControlStateNormal];
        [_typeOfProblemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else {
        [_typeOfProblemButton setTitle:[NSString stringWithFormat:@"Type Of Problem"] forState:UIControlStateNormal];
        [_typeOfProblemButton setTitleColor:UNSELECTED_EMERGENCY_BUTTON_COLOR forState:UIControlStateNormal];
    }
}

-(void)updateAgeData
{
    if (filterObj.age.length>0) {
        [_ageButton setTitle:filterObj.age forState:UIControlStateNormal];
        
        [_ageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else {
        [_ageButton setTitle:[NSString stringWithFormat:@"Age"] forState:UIControlStateNormal];
        
        [_ageButton setTitleColor:UNSELECTED_EMERGENCY_BUTTON_COLOR forState:UIControlStateNormal];
    }
}

-(void)updateLocationData
{
    if (filterObj.location.locationName.length>0) {
        [_locationButton setTitle:filterObj.location.locationName forState:UIControlStateNormal];
        [_locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else {
        [_locationButton setTitle:[NSString stringWithFormat:@"Locations"] forState:UIControlStateNormal];
        [_locationButton setTitleColor:UNSELECTED_EMERGENCY_BUTTON_COLOR forState:UIControlStateNormal];
    }
}

-(void)updateGenderButtonData
{
    if ([[filterObj.gender lowercaseString] isEqualToString:[NSString stringWithFormat:@"male"]]) {
        [_maleButton setImage:[UIImage imageNamed:SELECTED_CIRCLE] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
    }
    else if ([[filterObj.gender lowercaseString] isEqualToString:[NSString stringWithFormat:@"female"]]) {
        [_maleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:SELECTED_CIRCLE] forState:UIControlStateNormal];
    }
    else {
        [_maleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:UNSELECTED_CIRCLE] forState:UIControlStateNormal];
    }
}

-(void)setUpTypeOfProblemsTabeViewData
{
    _mainTableView.frame = CGRectMake(_typeOfProblemButton.frame.origin.x, _typeOfProblemButton.frame.origin.y+_typeOfProblemButton.frame.size.height+60, _typeOfProblemButton.frame.size.width, 200);
    selectedNumber = PROBLEM_TYPE_SELECTED;
    tableViewDataArray = [[NSMutableArray alloc] initWithArray:@[@"Chest Pain",@"Poisoning",@"Gynecological",@"High Fever",@"Unconsiousness",@"Fits",@"Coughing & Vomiting Blood",@"Accident",@"Sudden Behavioural Change",@"Breathlessness",@"Allergic Reaction",@"Intense Stomach Pain"]];
    
    _mainTableView.hidden = NO;
    _gestureButton.hidden = NO;
    [_mainTableView reloadData];
}

-(void)setUpAgeTabeViewData
{
    _mainTableView.frame = CGRectMake(_ageButton.frame.origin.x, _ageButton.frame.origin.y+_ageButton.frame.size.height+60, _ageButton.frame.size.width, 200);
    selectedNumber = AGE_SELECTED;
    tableViewDataArray = [[NSMutableArray alloc] initWithArray:@[@"Infant",@"Child",@"Adolescent",@"Adult",@"Senior"]];
    _mainTableView.hidden = NO;
    _gestureButton.hidden = NO;
    [_mainTableView reloadData];
}

-(void)setUpLocationTabeViewData
{
    _mainTableView.frame = CGRectMake(_locationButton.frame.origin.x, _locationButton.frame.origin.y+_locationButton.frame.size.height+60, _locationButton.frame.size.width, 200);
    
    LoginDataModal *userData = [TOEConstants getUserData];
    // add current location
    tableViewDataArray = [[NSMutableArray alloc] initWithArray:userData.locations];
    selectedNumber = LOCATIONS_SELECTED;
    _mainTableView.hidden = NO;
    _gestureButton.hidden = NO;
    [_mainTableView reloadData];
}

#pragma mark - Emergency filters Action Buttons -

- (IBAction)familyMemberButtonClicked:(id)sender
{
    filterObj.isFamilyMember = !filterObj.isFamilyMember;
    [self updateFamilyMemberData];
}

- (IBAction)typeOfProblemButtonClicked:(id)sender
{
    [self setUpTypeOfProblemsTabeViewData];
    // tableview
}

- (IBAction)ageButtonClicked:(id)sender
{
    [self setUpAgeTabeViewData];
    // tableview
}

- (IBAction)maleButtonClicked:(id)sender
{
    filterObj.gender = [NSString stringWithFormat:@"male"];
    [self updateGenderButtonData];
}

- (IBAction)femaleButtonClicked:(id)sender
{
    filterObj.gender = [NSString stringWithFormat:@"female"];
    [self updateGenderButtonData];
}

- (IBAction)locationButtonClicked:(id)sender
{
    [self setUpLocationTabeViewData];
    // tableview
}

- (IBAction)emergencySearchButtonClicked:(id)sender
{
    if ([_filtersDelegate respondsToSelector:@selector(reloadViewAccordingToFilters)]) {
        [FiltersObject setFilterObjectAs:filterObj];
        [_filtersDelegate reloadViewAccordingToFilters];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - table view delegate and data source -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (tableViewDataArray.count+1);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row==0) {
        switch (selectedNumber) {
            case PROBLEM_TYPE_SELECTED:
                cell.textLabel.text = @"Type of Problem";
                break;
            case LOCATIONS_SELECTED:
                cell.textLabel.text = @"Select Location";
                break;
            case AGE_SELECTED:
                cell.textLabel.text = @"Select Age Group";
                break;
                
            default:
                break;
        }
    }
    else{
        if (selectedNumber == LOCATIONS_SELECTED) {
            Locations *userLocationData = [tableViewDataArray objectAtIndex:(indexPath.row-1)];
            cell.textLabel.text = userLocationData.locationName;
        }
        else {
            NSString *cellText = (NSString *)[tableViewDataArray objectAtIndex:(indexPath.row-1)];
            cell.textLabel.text = cellText;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (selectedNumber) {
        case PROBLEM_TYPE_SELECTED:
        {
            if (indexPath.row==0) {
                filterObj.typeOfProblem = nil;
            }
            else {
                NSString *selectedText = (NSString *)[tableViewDataArray objectAtIndex:(indexPath.row-1)];
                filterObj.typeOfProblem = selectedText;
            }
            [self updateTypeOfProblemData];
            break;
            
        }
        case AGE_SELECTED:
        {
            if (indexPath.row==0) {
                filterObj.age = nil;
            }
            else {
                NSString *selectedText = (NSString *)[tableViewDataArray objectAtIndex:(indexPath.row-1)];
                filterObj.age = selectedText;
            }
            [self updateAgeData];
            break;
        }
        case LOCATIONS_SELECTED:
        {
            if (indexPath.row==0) {
                filterObj.location = nil;
            }
            else {
                Locations *userLocationData = [tableViewDataArray objectAtIndex:(indexPath.row-1)];
                filterObj.location = userLocationData;

            }
            [self updateLocationData];
            break;
        }
        default:
            
            break;
    }
    _mainTableView.hidden = YES;
    _gestureButton.hidden = YES;
}


- (IBAction)gestureButtonClicked:(id)sender
{
    _mainTableView.hidden = YES;
    _gestureButton.hidden = YES;
}

@end
