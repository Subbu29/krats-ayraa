//
//  RelativesListViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 20/08/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "RelativesListViewController.h"
#import "LoginDataModal.h"
#import "UserDetailsViewController.h"
#import "TOEConstants.h"

@interface RelativesListViewController ()

@end

@implementation RelativesListViewController
{
    LoginDataModal *userData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    userData = [TOEConstants getUserData];
    [_listTableView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpNavigationBar
{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(5, 5, 30, 30);
    [addButton setTitle:[NSString stringWithFormat:@"AD"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addRelativeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    addButton.adjustsImageWhenHighlighted = NO;
    
    [rightView addSubview:addButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
}

-(void)addRelativeButtonClicked
{
    UserDetailsViewController *relativeDetailsViewController = [[UserDetailsViewController alloc] initWithNibName:@"UserDetailsViewController" bundle:nil];
    
    relativeDetailsViewController.relativeData = [[UserRelatives alloc] init];
    relativeDetailsViewController.detailsType = AddNewRelative;
    
    [self.navigationController pushViewController:relativeDetailsViewController animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return userData.relatives.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    UserRelatives *relativeData = [userData.relatives objectAtIndex:indexPath.row];
    cell.textLabel.text = relativeData.relativeName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserRelatives *relativeData = [userData.relatives objectAtIndex:indexPath.row];
    
    UserDetailsViewController *relativeDetailsViewController = [[UserDetailsViewController alloc] initWithNibName:@"UserDetailsViewController" bundle:nil];
    relativeDetailsViewController.relativeData = relativeData.copy;
    relativeDetailsViewController.detailsType = UpdateRelativeDetails;
    [self.navigationController pushViewController:relativeDetailsViewController animated:YES];
}

@end
