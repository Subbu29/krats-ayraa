//
//  FiltersObject.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 27/04/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginDataModal.h"

@interface FiltersObject : NSObject

+(instancetype)sharedInstance;

+(FiltersObject *)copyOfFilterObj;

+(void)setFilterObjectAs:(FiltersObject *)filterObj;

+(void)resetEmergencyFilters;

+(void)resetNormalFilters;

+(void)resetAllFilters;

@property (strong,nonatomic) NSString *hospitalRadius;
@property (nonatomic) BOOL hasCashLessInsurance;
@property (nonatomic) BOOL hasHandleEmergencies;
@property (nonatomic) BOOL hasParking;


@property (nonatomic) BOOL isFamilyMember;
@property (strong,nonatomic) NSString *typeOfProblem;
@property (strong,nonatomic) NSString *age;
@property (strong,nonatomic) NSString *gender;
@property (strong,nonatomic) Locations *location;

@end
