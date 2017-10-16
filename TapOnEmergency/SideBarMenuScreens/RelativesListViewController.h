//
//  RelativesListViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 20/08/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RelativesListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end
