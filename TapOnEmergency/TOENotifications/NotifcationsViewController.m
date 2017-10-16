//
//  NotifcationsViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/06/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "NotifcationsViewController.h"
#import "NotifcationsTableViewCell.h"
#import "TOEConstants.h"
#import "ContactAdminViewController.h"
#import "SafetyCenterViewController.h"
#import "EmergencyContactsViewController.h"
#import "FiltersViewController.h"
#import "SOSViewController.h"
#import "NotificationsDetailViewController.h"
#import "UserProfileViewController.h"

#define PROFILE_PAGE_CENTER_TAG 9
#define SAFETY_CENTER_TAG 10
#define EMERGENCY_CONTACTS_TAG 11
#define NOTIFY_ADMIN_TAG 12
#define LOCATIONS_TAG 13
#define SETTINGS_TAG 14
#define ABOUT_US_TAG 15
#define HELP_TAG 16
#define TERMS_AND_CONDITIONS_TAG 17


@interface NotifcationsViewController ()

@end

@implementation NotifcationsViewController
{
    LoginDataModal *userData;
    SideBarMenu *sideBarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sosButton.hidden = ![TOEConstants isInEmergencyMode];
//    [self setUpNavigationBar];
    [self registerTableViewCells];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;

    _notificationsTableView.estimatedRowHeight = _notificationsTableView.rowHeight;
    _notificationsTableView.rowHeight = UITableViewAutomaticDimension;
    userData = [TOEConstants getUserData];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setUpNavigationBar];
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
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    
//    UIButton *rightSOSButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightSOSButton.frame = CGRectMake(40, 5, 30, 30);
//    [rightSOSButton setTitle:@"SO" forState:UIControlStateNormal];
//    //    [rightSOSButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    [rightSOSButton addTarget:self action:@selector(sosButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    rightSOSButton.adjustsImageWhenHighlighted = NO;
    
    
    
    UIButton *leftSideBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftSideBarButton.frame = CGRectMake(5, 5, 30, 30);
    [leftSideBarButton setTitle:@"SB" forState:UIControlStateNormal];
    //    [leftSideBarButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [leftSideBarButton addTarget:self action:@selector(sideBarButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    leftSideBarButton.adjustsImageWhenHighlighted = NO;
    
    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:billeasyIcon];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftSideBarButton];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
}

-(void)sideBarButtonClicked
{
    sideBarView = [SideBarMenu showSideBarMenu];
    sideBarView.sideBarMenuDelegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:sideBarView];
}

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
                emergencyViewController.hidesBottomBarWhenPushed = YES;
                emergencyViewController.viewType = EMERGENCY_CONTACTS_TYPE;
                [self.navigationController pushViewController:emergencyViewController animated:YES];
                
                break;
            }
            case LOCATIONS_TAG:
            {
                EmergencyContactsViewController *locationsViewController = [[EmergencyContactsViewController alloc] initWithNibName:@"EmergencyContactsViewController" bundle:nil];
                locationsViewController.hidesBottomBarWhenPushed = YES;
                locationsViewController.viewType = LOCATIONS_TYPE;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerTableViewCells
{
    [self.notificationsTableView registerNib:[UINib nibWithNibName:@"NotifcationsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NotifcationsTableViewCell"];
    [self.notificationsTableView registerClass:[NotifcationsTableViewCell class] forCellReuseIdentifier:@"NotifcationsTableViewCell"];
}

-(CGFloat)heightOfLabelWithText:(NSString *)string
{
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16.0f];
    tempLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tempLabel.numberOfLines = 0;
    tempLabel.text = string;
    CGSize size = [tempLabel sizeThatFits:CGSizeMake(self.view.frame.size.width-30, FLT_MAX)];
    NSLog(@"%@%f",string,size.height);
    return size.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Incidents *incidentData = [userData.incidents objectAtIndex:indexPath.row];
    return ([self heightOfLabelWithText:incidentData.incidentDescription]+50);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return userData.incidents.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifcationsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotifcationsTableViewCell"];
    
    Incidents *incidentData = [userData.incidents objectAtIndex:indexPath.row];
    cell.incidentTitleLabel.text =incidentData.title;
    cell.incidentDescription.text =incidentData.incidentDescription;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Incidents *incidentData = [userData.incidents objectAtIndex:indexPath.row];
    NotificationsDetailViewController *detailView = [[NotificationsDetailViewController alloc] initWithNibName:@"NotificationsDetailViewController" bundle:nil];
    detailView.incidentData =incidentData;
    detailView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailView animated:YES];
}

- (IBAction)sosButtonClicked:(id)sender
{
    
}
@end
