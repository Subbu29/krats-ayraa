//
//  HospitalListViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 05/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "HospitalListViewController.h"

#import "TOEAPIConstants.h"
#import "TOECacheController.h"
#import "ContactAdminViewController.h"
#import "SafetyCenterViewController.h"
#import "EmergencyContactsViewController.h"
#import "FiltersViewController.h"
#import "SOSViewController.h"
#import "TOEConstants.h"
#import "HospitalDetailViewController.h"
#import "HospitalsListDataModal.h"
#import "FiltersObject.h"
#import "APILoaderView.h"
#import "UserLocationDataOBj.h"
#import "UserProfileViewController.h"


#define LATITUDE_KEY @"User_Location_Latitude"
#define LONGITUDE_KEY @"User_Location_Longitude"

#define PROFILE_PAGE_CENTER_TAG 9
#define SAFETY_CENTER_TAG 10
#define EMERGENCY_CONTACTS_TAG 11
#define NOTIFY_ADMIN_TAG 12
#define LOCATIONS_TAG 13
#define SETTINGS_TAG 14
#define ABOUT_US_TAG 15
#define HELP_TAG 16
#define TERMS_AND_CONDITIONS_TAG 17

@interface HospitalListViewController ()

@end

@implementation HospitalListViewController
{
    SideBarMenu *sideBarView;
    NSMutableArray *hospitalsArray;
    NSString *errorMessage;
    UIRefreshControl *refreshControl;
    
    CLLocationManager *locationManager;
    UserLocationDataOBj *userLocationData;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestAlwaysAuthorization];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    CLLocation *location = [locationManager location];
    
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    NSLog(@"MY HOME :%@", latitude);
    NSLog(@"MY HOME: %@ ", longitude);
    
    [self registerTableViewCells];
    [self setUpNavigationBar];
    
    [self setUpPulltoRefresh];
    
    userLocationData = [[UserLocationDataOBj alloc] init];
    userLocationData.latitude = latitude;
    userLocationData.longitude =longitude;
    
    if (userLocationData.latitude == 0 && userLocationData.longitude == 0) {
        errorMessage = [NSString stringWithFormat:@"Please Turn On Location Services"];
        [_cardsTableView reloadData];
    }
    else {
        [APILoaderView showLoaderInView:[UIApplication sharedApplication].keyWindow];
        [self downloadHospitalsData];
    }
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpPulltoRefresh
{
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor whiteColor];
    refreshControl.tintColor = [UIColor blackColor];
    [refreshControl addTarget:self
                            action:@selector(refreshHospitalsData)
                  forControlEvents:UIControlEventValueChanged];
    [_cardsTableView addSubview:refreshControl];
}

-(void)refreshHospitalsData
{
    [self downloadHospitalsData];
}

-(void)setUpNavigationBar
{
    BOOL isEmergency = [TOEConstants isInEmergencyMode];
    if (isEmergency) {
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    }
    else {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0/255.0f green:160.0/255.0f blue:223.0/255.0f alpha:1.0f];
    }
    self.navigationController.navigationBar.translucent = NO;
    
//
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    
//    UIButton *rightSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightSearchButton.frame = CGRectMake(5, 5, 30, 30);
//    [rightSearchButton setTitle:@"SE" forState:UIControlStateNormal];
//    
//    rightSearchButton.adjustsImageWhenHighlighted = NO;
    
    UIButton *rightSOSButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightSOSButton.frame = CGRectMake(40, 5, 30, 30);
    [rightSOSButton setTitle:@"SO" forState:UIControlStateNormal];
//    [rightSOSButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [rightSOSButton addTarget:self action:@selector(sosButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    rightSOSButton.adjustsImageWhenHighlighted = NO;
    
    
    UIButton *rightFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightFilterButton.frame = CGRectMake(75, 5, 30, 30);
    [rightFilterButton setTitle:@"F" forState:UIControlStateNormal];
    //    [rightFilterButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    //    [rightFilterButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightFilterButton addTarget:self action:@selector(filterButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    rightFilterButton.adjustsImageWhenHighlighted = NO;
//    [rightView addSubview:rightSearchButton];
    [rightView addSubview:rightSOSButton];
    [rightView addSubview:rightFilterButton];
    
    UIButton *leftSideBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftSideBarButton.frame = CGRectMake(5, 5, 30, 30);
    [leftSideBarButton setTitle:@"SB" forState:UIControlStateNormal];
//    [leftSideBarButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [leftSideBarButton addTarget:self action:@selector(sideBarButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    leftSideBarButton.adjustsImageWhenHighlighted = NO;
    
//    UIImage *billeasyIcon = [UIImage imageNamed:@""];
    
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:billeasyIcon];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftSideBarButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
}

-(void)sideBarButtonClicked
{
    sideBarView = [SideBarMenu showSideBarMenu];
    sideBarView.sideBarMenuDelegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:sideBarView];
}

-(void)filterButtonClicked
{
    FiltersViewController *filterViewController = [[FiltersViewController alloc] initWithNibName:@"FiltersViewController" bundle:nil];
    filterViewController.filtersDelegate = self;
    [self.navigationController presentViewController:filterViewController animated:YES completion:nil];
}

-(void)sosButtonClicked
{
    SOSViewController *sosViewController = [[SOSViewController alloc] initWithNibName:@"SOSViewController" bundle:nil];
    sosViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sosViewController animated:YES];
}

#pragma mark - Filters Delegate Method -

-(void)reloadViewAccordingToFilters
{
    [APILoaderView showLoaderInView:[UIApplication sharedApplication].keyWindow];
    [self downloadHospitalsData];
    // donwload data
}

#pragma mark - Download data -

-(void)downloadHospitalsData
{
    NSMutableDictionary *postDataDict = [[NSMutableDictionary alloc] init];
    NSString *urlString;
    if (![TOEConstants isInEmergencyMode]) {
        urlString = [NSString stringWithFormat:@"%@filterBrowseHospital",TOE_WEB_API_URL];
        FiltersObject *filterObj =  [FiltersObject sharedInstance];
        
        if (filterObj.hasParking) {
            [postDataDict setValue:@"true" forKey:@"parkingAvailable"];
        }
        else {
            [postDataDict setValue:@"false" forKey:@"parkingAvailable"];
        }
        
        if (filterObj.hasCashLessInsurance) {
            [postDataDict setValue:@"true" forKey:@"isCashless"];
        }
        else {
            [postDataDict setValue:@"false" forKey:@"isCashless"];
        }
        
        if (filterObj.hasHandleEmergencies) {
            [postDataDict setValue:@"true" forKey:@"handleEmergency"];
        }
        else {
            [postDataDict setValue:@"false" forKey:@"handleEmergency"];
        }
        
        if (filterObj.hospitalRadius>0) {
            [postDataDict setValue:filterObj.hospitalRadius forKey:@"radius"];
        }
        else {
            [postDataDict setValue:@"0" forKey:@"radius"];
        }
        [postDataDict setValue:userLocationData.latitude forKey:@"latitude"];
        [postDataDict setValue:userLocationData.longitude forKey:@"longitude"];
    }
    else {
        urlString = [NSString stringWithFormat:@"%@filterHospital",TOE_WEB_API_URL];
        //    https://taponemergency.com/web/m/v1/filterHospital
        //    {"userId":"45",
        //        "token": "",
        //        "problem":"Problem Name",
        //        "gender" : "Male/Female",
        //        "ageGroup":"age group",
        //        "latitude":"latitude from current location",
        //        "longitude":"longitude from current location"
        //    }
        FiltersObject *filterObj =  [FiltersObject sharedInstance];
        if (filterObj.gender.length>0) {
            [postDataDict setObject:filterObj.gender forKey:@"gender"];
        }
        else {
            [postDataDict setObject:@"" forKey:@"gender"];
        }
        if (filterObj.typeOfProblem.length>0) {
            [postDataDict setObject:filterObj.typeOfProblem forKey:@"problem"];
        }
        else {
            [postDataDict setObject:@"" forKey:@"problem"];
        }
        if (filterObj.age.length>0) {
            [postDataDict setObject:filterObj.age forKey:@"ageGroup"];
        }
        else {
            [postDataDict setObject:@"" forKey:@"ageGroup"];
        }
        if (filterObj.location!=nil) {
            
        }
        [postDataDict setObject:@"false" forKey:@"familymember"];
        [postDataDict setValue:@"18.5148473" forKey:@"latitude"];
        [postDataDict setValue:@"73.8164044" forKey:@"longitude"];
    }
    
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    [userData objectForKey:USER_ACCESS_TOKEN];

    NSString *accesToken = [userData objectForKey:USER_ACCESS_TOKEN];
    [postDataDict setValue:accesToken forKey:@"token"];
    
    [[TOECacheController sharedInstance] getHospitalsInBrowsingModeWithUrl:urlString andPostData:postDataDict WithCompletionBlock:^(NSArray *filterBrowsingData, NSInteger statusCode) {
        [refreshControl endRefreshing];
        hospitalsArray = [[NSMutableArray alloc] init];
        switch (statusCode) {
            case 200:
                if ((filterBrowsingData.count>0)&&[filterBrowsingData isKindOfClass:[NSArray class]]) {
                    errorMessage = @"";
                    hospitalsArray = [HospitalsListDataModal arrayOfModelsFromDictionary:filterBrowsingData];
                }
                else {
                    errorMessage = @"No Hospitals found nearby";
                }
                break;
            case 404:
                errorMessage = @"No Hospitals found nearby";
                break;
            case 0:
                errorMessage = @"No internet connection \n please check your internet connection and Pull to refresh";
            default:
                errorMessage = @"Server Error \n sorry, some thing went wrong";
                break;
        }
        [_cardsTableView reloadData];
        [APILoaderView hideLoaderInView:[UIApplication sharedApplication].keyWindow];
    }];
}

#pragma mark - Side Bar Delegate Methods -

-(void)pushToViewControllerWithTag:(NSInteger)nextControllerTag
{
    [UIView transitionWithView:sideBarView duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
        sideBarView.frame = CGRectMake(-sideBarView.frame.size.width+2, sideBarView.frame.origin.y, sideBarView.frame.size.width, sideBarView.frame.size.height);
        sideBarView.tapGestureButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        [sideBarView removeFromSuperview];
        switch (nextControllerTag) {
            case PROFILE_PAGE_CENTER_TAG:
            {
                UserProfileViewController *profileVC = [[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:nil];
                profileVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:profileVC animated:YES];
                break;
            }
            case SAFETY_CENTER_TAG:
            {
                SafetyCenterViewController *safetyViewController = [[SafetyCenterViewController alloc] initWithNibName:@"SafetyCenterViewController" bundle:nil];
                safetyViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:safetyViewController animated:YES];
                break;
            }
            case EMERGENCY_CONTACTS_TAG:
            {
                EmergencyContactsViewController *emergencyViewController = [[EmergencyContactsViewController alloc] initWithNibName:@"EmergencyContactsViewController" bundle:nil];
                emergencyViewController.viewType = EMERGENCY_CONTACTS_TYPE;
                emergencyViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:emergencyViewController animated:YES];
                
                break;
            }
            case LOCATIONS_TAG:
            {
                EmergencyContactsViewController *locationsViewController = [[EmergencyContactsViewController alloc] initWithNibName:@"EmergencyContactsViewController" bundle:nil];
                locationsViewController.viewType = LOCATIONS_TYPE;
                locationsViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:locationsViewController animated:YES];
                break;
            }
            case SETTINGS_TAG:
            {
                break;
            }
            case ABOUT_US_TAG:
            {
                break;
            }
            case TERMS_AND_CONDITIONS_TAG:
            {
                break;
            }
            case HELP_TAG:
            {
                
                break;
            }
            case NOTIFY_ADMIN_TAG:
            {
                ContactAdminViewController *contactAdminViewController = [[ContactAdminViewController alloc] initWithNibName:@"ContactAdminViewController" bundle:nil];
                contactAdminViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:contactAdminViewController animated:YES];
            }
                
            default:
                break;
        }
    }];
    // push to the view controller after hidding
}

-(void)registerTableViewCells
{
    [self.cardsTableView registerNib:[UINib nibWithNibName:@"CardsTableViewCell" bundle:nil] forCellReuseIdentifier:@"HostipalsTabelViewCell"];
    [self.cardsTableView registerClass:[CardsTableViewCell class] forCellReuseIdentifier:@"HostipalsTabelViewCell"];
}

#pragma mark - table view delegate methods -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (hospitalsArray.count>0) {
        return 1;
    }
    else {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = errorMessage;
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f];
        [messageLabel sizeToFit];
        
        tableView.backgroundView = messageLabel;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return hospitalsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostipalsTabelViewCell"];
    HospitalsListDataModal *hospitalData = [hospitalsArray objectAtIndex:indexPath.row];
    cell.hospitalNameLabel.text = hospitalData.hospitalName;
    cell.distanceLabel.text = hospitalData.distance;
    cell.cellRow  = indexPath.row;
    // pull to refresh
    // offline button
    // loadmore if there
    cell.cellDelegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HospitalsListDataModal *hospitalData = [hospitalsArray objectAtIndex:indexPath.row];
    
    HospitalDetailViewController *detailView = [[HospitalDetailViewController alloc] initWithNibName:@"HospitalDetailViewController" bundle:nil];
    detailView.hospitalData =hospitalData;
    detailView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailView animated:YES];
}

#pragma mark - Cell Delegates -

-(void)olaButtonClickedWithRow:(NSInteger)row
{
    HospitalsListDataModal *hospitalData = [hospitalsArray objectAtIndex:row];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"olacabs://app/launch?lat=%@&lng=%@&utm_source=%@&landing_page=bk&drop_lat=%@&drop_lng=%@",userLocationData.latitude,userLocationData.longitude,@"551614a24d3c4d1cb438002b03cc878c", hospitalData.latitude,hospitalData.longitude]];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:
         url];
    }
    else {
        [TOEConstants showAlertWithTitle:@"cant open Ola Cabs" andMessage:@"" inView:self];
    }
}

-(void)callButtonClickedWithRow:(NSInteger)row
{
    if (hospitalsArray.count>row) {
        HospitalsListDataModal *hospitalData = [hospitalsArray objectAtIndex:row];
        NSString *phoneNumber = [@"tel:" stringByAppendingString:hospitalData.contact1];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phoneNumber]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        }
        else {
            [TOEConstants showAlertWithTitle:@"Error in call" andMessage:@"cant make a call sorry for inconvience" inView:self];
        }
    }
}

-(void)directionButtonClickedWithRow:(NSInteger)row
{
    HospitalsListDataModal *hospitalData = [hospitalsArray objectAtIndex:row];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?center=%@,%@&q=%@,%@",userLocationData.latitude,userLocationData.longitude, hospitalData.latitude,hospitalData.longitude]];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:
         url];
    }
    else {
        [TOEConstants showAlertWithTitle:@"cant open google maps" andMessage:@"" inView:self];
    }
}

#pragma mark - Emergency Button -

- (IBAction)emergencyButtonClicked:(id)sender
{
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    NSString *emergency = [userData objectForKey:IS_EMERGENCY];
    if ([emergency isEqualToString:@"YES"]) {
        [userData setObject:@"NO" forKey:IS_EMERGENCY];
        [FiltersObject resetEmergencyFilters];
    }
    else {
        [userData setObject:@"YES" forKey:IS_EMERGENCY];
        [FiltersObject resetNormalFilters];
        // download emergency data
    }
    [self setUpNavigationBar];
    [APILoaderView showLoaderInView:[UIApplication sharedApplication].keyWindow];
    [self downloadHospitalsData];
}


@end
