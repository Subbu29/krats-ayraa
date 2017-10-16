//
//  FiltersViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 12/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FiltersProtocol <NSObject>

-(void)reloadViewAccordingToFilters;



@end

@interface FiltersViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) id<FiltersProtocol> filtersDelegate;

@property (weak, nonatomic) IBOutlet UIView *navigationBarView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)backButtonClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *normalFiltersView;
@property (weak, nonatomic) IBOutlet UILabel *filterLabel;
@property (weak, nonatomic) IBOutlet UITextField *kmTextField;
@property (weak, nonatomic) IBOutlet UIButton *cashlessInsuranceButton;
- (IBAction)cashlessButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *handleEmergenciesButton;
- (IBAction)handleEmergenciesButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *parkingButton;
- (IBAction)parkingButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
- (IBAction)searchButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *emergencyFiltersView;
@property (weak, nonatomic) IBOutlet UILabel *emergencyFiltersLabel;
@property (weak, nonatomic) IBOutlet UIButton *familyMemberButton;
- (IBAction)familyMemberButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *typeOfProblemButton;
- (IBAction)typeOfProblemButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ageButton;
- (IBAction)ageButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *maleButton;
- (IBAction)maleButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
- (IBAction)femaleButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
- (IBAction)locationButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *emergencySearchButton;
- (IBAction)emergencySearchButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *gestureButton;
- (IBAction)gestureButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;



@end
