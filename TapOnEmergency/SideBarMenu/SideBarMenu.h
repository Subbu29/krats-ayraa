//
//  SideBarMenu.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 05/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SideBarMenuActionProtocol <NSObject>

-(void)pushToViewControllerWithTag:(NSInteger )nextControllerTag;

@end

@interface SideBarMenu : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) id<SideBarMenuActionProtocol> sideBarMenuDelegate;
@property (strong,nonatomic) NSMutableArray *menuArray;

+(SideBarMenu *)showSideBarMenu;

+(SideBarMenu *)findSideBarMenuCustomViewInWindow;

- (IBAction)profileGestureButtonClicked:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *sideBarMenuView;

@property (weak, nonatomic) IBOutlet UIButton *tapGestureButton;

@property (weak, nonatomic) IBOutlet UIView *sideBarView;

@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageview;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userEmailId;



@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

- (IBAction)hideSideBarMenu:(id)sender;

@end
