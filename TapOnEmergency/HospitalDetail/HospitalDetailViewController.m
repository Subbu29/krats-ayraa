//
//  HospitalDetailViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 14/04/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "HospitalDetailViewController.h"
#import "HospitalInfoTableViewCell.h"
#import "HospitalAddressTableViewCell.h"
#import "HospitalContactInfoTableViewCell.h"
#import "HospitalHighlightsTableViewCell.h"

#define CELL_BACKGROUND_COLOR [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f];

@interface HospitalDetailViewController ()

@end

@implementation HospitalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerTableViewCells];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerTableViewCells
{
    [self.mainTableView registerNib:[UINib nibWithNibName:@"HospitalInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"HospitalInfoTableViewCellIdentifier"];
    [self.mainTableView registerClass:[HospitalInfoTableViewCell class] forCellReuseIdentifier:@"HospitalInfoTableViewCellIdentifier"];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"HospitalAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"HospitalAddressTableViewCellIdentifier"];
    [self.mainTableView registerClass:[HospitalAddressTableViewCell class] forCellReuseIdentifier:@"HospitalAddressTableViewCellIdentifier"];
    
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"HospitalContactInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"HospitalContactInfoTableViewCellIdentifier"];
    [self.mainTableView registerClass:[HospitalContactInfoTableViewCell class] forCellReuseIdentifier:@"HospitalContactInfoTableViewCellIdentifier"];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"HospitalHighlightsTableViewCell" bundle:nil] forCellReuseIdentifier:@"HospitalHighlightsTableViewCellIdentifier"];
    [self.mainTableView registerClass:[HospitalHighlightsTableViewCell class] forCellReuseIdentifier:@"HospitalHighlightsTableViewCellIdentifier"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 140;
            break;
        case 1:
            return 300;
            break;
        case 2:
        {
            CGFloat heightOfcell = 60;
            if (_hospitalData.contact1.length!=0 && _hospitalData.contact2.length!=0 ) {
                heightOfcell = heightOfcell + 70+20;
            }
            else if (_hospitalData.contact1.length!=0 || _hospitalData.contact2.length!=0) {
                heightOfcell = heightOfcell+35+10;
            }
            if (_hospitalData.email1.length!=0) {
                heightOfcell = heightOfcell+30+10;
            }
            return heightOfcell;
        }
            break;
        case 3:
            return 100;
            break;
        default:
            return 150;
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            HospitalInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HospitalInfoTableViewCellIdentifier"];
            cell.hospitalNameLabel.text = _hospitalData.hospitalName;
            cell.hospitalCategoryLabel.text = _hospitalData.hospitalCategory;
            cell.hospitalSpecialityLabel.text = _hospitalData.coreSpeciality;
            cell.backgroundColor = CELL_BACKGROUND_COLOR;
            return cell;
            
        }
            break;
        case 1:
        {
            HospitalAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HospitalAddressTableViewCellIdentifier"];
            
            cell.addressLabel.text = _hospitalData.address;
            
            cell.backgroundColor =CELL_BACKGROUND_COLOR;
            return cell;
        }
            break;
        case 2:
        {
            HospitalContactInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HospitalContactInfoTableViewCellIdentifier"];
            cell.hospitalDetailData = _hospitalData;
            cell.backgroundColor = CELL_BACKGROUND_COLOR;
            return cell;
        }
            break;
        case 3:
        {
            HospitalHighlightsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HospitalHighlightsTableViewCellIdentifier"];
            cell.backgroundColor = CELL_BACKGROUND_COLOR;
            return cell;
        }
            break;
            
        default:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.textLabel.text = @"sample";
            return cell;

        }
            break;
    }
}

@end
