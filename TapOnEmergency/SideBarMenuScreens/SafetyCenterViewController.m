//
//  SafetyCenterViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 09/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "SafetyCenterViewController.h"
#import "UserDetailsViewController.h"
#import "LoginDataModal.h"
#import "RelativesListViewController.h"

@interface SafetyCenterViewController ()

@end

@implementation SafetyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)personalHealthButtonClicked:(id)sender
{
    // take to perosnal editingmode
    UserDetailsViewController *personalDetailsViewController = [[UserDetailsViewController alloc] initWithNibName:@"UserDetailsViewController" bundle:nil];
    personalDetailsViewController.detailsType = UpdateUserDetails;
    [self.navigationController pushViewController:personalDetailsViewController animated:YES];
}

- (IBAction)familyAndFriendsHealthButtonClicked:(id)sender
{
    //take to family groups
    RelativesListViewController *relativelistViewController = [[RelativesListViewController alloc] initWithNibName:@"RelativesListViewController" bundle:nil];
    [self.navigationController pushViewController:relativelistViewController animated:YES];
}

@end
