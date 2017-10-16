//
//  SideBarMenu.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 05/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "SideBarMenu.h"
#import "SideBarMenuModal.h"
#import "SideBarMenuTableViewCell.h"
#import "ContactAdminViewController.h"



#define SAFETY_CENTER_TAG 10
#define EMERGENCY_CONTACTS_TAG 11
#define NOTIFY_ADMIN_TAG 12
#define LOCATIONS_TAG 13
#define SETTINGS_TAG 14
#define ABOUT_US_TAG 15
#define HELP_TAG 16
#define TERMS_AND_CONDITIONS_TAG 17

@implementation SideBarMenu


+(SideBarMenu *)showSideBarMenu
{
    SideBarMenu *sideBarMenuView =  [SideBarMenu findSideBarMenuCustomViewInWindow];
    if (sideBarMenuView == nil) {
        sideBarMenuView =  [[self alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    }
//    [sideBarMenuView resetAllViews];
    
    return sideBarMenuView;
}

+(SideBarMenu *)findSideBarMenuCustomViewInWindow
{
    for (SideBarMenu* subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isKindOfClass:[SideBarMenu class]]) {
            return subView;
        }
    }
    return nil;
}



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

-(void)resetAllViews
{
    
    /// check this
    
    [self.menuTableView reloadData];
//    if (_menuTableView.contentSize.height < (self.frame.size.height-self.profileView.frame.size.height)) {
//        CGRect frame = _menuTableView.frame;
//        frame.size.height = _menuTableView.contentSize.height;
//        _menuTableView.frame = frame;
//    }
}

-(void)setUpViews
{
    [[NSBundle mainBundle] loadNibNamed:@"SideBarMenu" owner:self options:nil];
    _sideBarMenuView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_sideBarMenuView];
    //    animate the view when
    [self addAnimationLayerFor:_sideBarView withDuration:0.2];
    [self registerTableViewCells];
    [self setDataForTableView];
//    _menuTableView.layer.borderColor = [UIColor colorWithRed:151.0f/255.0f green:151.0f/255.0f blue:151.0f/255.0f alpha:0.2f].CGColor;
//    _menuTableView.layer.borderWidth = 1.0f;
    
    //    [self reload];
}

-(void)registerTableViewCells
{
    [self.menuTableView registerNib:[UINib nibWithNibName:@"CardsTableViewCell" bundle:nil] forCellReuseIdentifier:@"SideBarCellIdentifier"];
    [self.menuTableView registerClass:[SideBarMenuTableViewCell class] forCellReuseIdentifier:@"SideBarCellIdentifier"];
}

-(void)setDataForTableView
{
    SideBarMenuModal *menuModal = [[SideBarMenuModal alloc] init];
    _menuArray = [[NSMutableArray alloc] init];
    
    menuModal.categoryTag = SAFETY_CENTER_TAG;
    menuModal.categoryIcon = [NSString stringWithFormat:@""];
    menuModal.categoryTitle = [NSString stringWithFormat:@"Safety Center"];
    [_menuArray addObject:menuModal];
    
    menuModal = [[SideBarMenuModal alloc] init];
    menuModal.categoryTag = EMERGENCY_CONTACTS_TAG;
    menuModal.categoryIcon = [NSString stringWithFormat:@""];
    menuModal.categoryTitle = [NSString stringWithFormat:@"Emergency Contacts"];
    [_menuArray addObject:menuModal];
    
    menuModal = [[SideBarMenuModal alloc] init];
    menuModal.categoryTag = NOTIFY_ADMIN_TAG;
    menuModal.categoryIcon = [NSString stringWithFormat:@""];
    menuModal.categoryTitle = [NSString stringWithFormat:@"Notify Admin"];
    [_menuArray addObject:menuModal];
    
    menuModal = [[SideBarMenuModal alloc] init];
    menuModal.categoryTag = LOCATIONS_TAG;
    menuModal.categoryIcon = [NSString stringWithFormat:@""];
    menuModal.categoryTitle = [NSString stringWithFormat:@"Locations"];
    [_menuArray addObject:menuModal];
    
    menuModal = [[SideBarMenuModal alloc] init];
    menuModal.categoryTag = SETTINGS_TAG;
    menuModal.categoryIcon = [NSString stringWithFormat:@""];
    menuModal.categoryTitle = [NSString stringWithFormat:@"Settings"];
    [_menuArray addObject:menuModal];
    
    menuModal = [[SideBarMenuModal alloc] init];
    menuModal.categoryTag = ABOUT_US_TAG;
    menuModal.categoryIcon = [NSString stringWithFormat:@""];
    menuModal.categoryTitle = [NSString stringWithFormat:@"AboutUs"];
    [_menuArray addObject:menuModal];
    
    menuModal = [[SideBarMenuModal alloc] init];
    menuModal.categoryTag = HELP_TAG;
    menuModal.categoryIcon = [NSString stringWithFormat:@""];
    menuModal.categoryTitle = [NSString stringWithFormat:@"Help"];
    [_menuArray addObject:menuModal];
    
    menuModal = [[SideBarMenuModal alloc] init];
    menuModal.categoryTag = TERMS_AND_CONDITIONS_TAG;
    menuModal.categoryIcon = [NSString stringWithFormat:@""];
    menuModal.categoryTitle = [NSString stringWithFormat:@"Terms and Conditions"];
    [_menuArray addObject:menuModal];
    [_menuTableView reloadData];
}

-(void)addAnimationLayerFor:(UIView *)view withDuration:(CGFloat)animationTime
{
    CATransition *transition = [CATransition animation];
    transition.duration = animationTime;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [view.layer addAnimation:transition forKey:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SideBarMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SideBarCellIdentifier"];
    
    SideBarMenuModal *cellData = [_menuArray objectAtIndex:indexPath.row];
    cell.categoryTitleLabel.text = cellData.categoryTitle;
    cell.categoryImageView.backgroundColor = [UIColor lightGrayColor];
//    if (cell.) {
//        <#statements#>
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // push to view controller
    SideBarMenuModal *cellData = [_menuArray objectAtIndex:indexPath.row];
    if ([_sideBarMenuDelegate respondsToSelector:@selector(pushToViewControllerWithTag:)]) {
        [_sideBarMenuDelegate pushToViewControllerWithTag:cellData.categoryTag];
    }
}
//
//ContactAdminViewController *billDetailView = [[ContactAdminViewController alloc] initWithNibName:@"ContactAdminViewController" bundle:nil];
//[self.navigationController pushViewController:billDetailView animated:YES];

-(IBAction)hideSideBarMenu:(id)sender
{
    [UIView transitionWithView:_sideBarView duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
        _sideBarView.frame = CGRectMake(-_sideBarView.frame.size.width+2, _sideBarView.frame.origin.y, _sideBarView.frame.size.width, _sideBarView.frame.size.height);
        _tapGestureButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)profileGestureButtonClicked:(id)sender
{
    if ([_sideBarMenuDelegate respondsToSelector:@selector(pushToViewControllerWithTag:)]) {
        [_sideBarMenuDelegate pushToViewControllerWithTag:9];
    }
}

@end
