//
//  FiltersObject.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 27/04/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "FiltersObject.h"

@implementation FiltersObject

+(instancetype)sharedInstance
{
    static FiltersObject *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FiltersObject alloc] init];
        
    });
    return sharedInstance;
}

+(void)setFilterObjectAs:(FiltersObject *)filterObj
{
    FiltersObject *oldFilterObj = [FiltersObject sharedInstance];
    
    oldFilterObj.hospitalRadius = filterObj.hospitalRadius;
    oldFilterObj.hasCashLessInsurance = filterObj.hasCashLessInsurance;
    oldFilterObj.hasHandleEmergencies = filterObj.hasHandleEmergencies;
    oldFilterObj.hasParking = filterObj.hasParking;
    
    oldFilterObj.isFamilyMember = filterObj.isFamilyMember;
    oldFilterObj.typeOfProblem = filterObj.typeOfProblem;
    oldFilterObj.age = filterObj.age;
    oldFilterObj.gender = filterObj.gender;
    oldFilterObj.location = filterObj.location;
}

+(FiltersObject *)copyOfFilterObj
{
    
    FiltersObject *newFilterObj = [[FiltersObject alloc] init];
    
    FiltersObject *filterObj = [FiltersObject sharedInstance];
    
    newFilterObj.hospitalRadius = filterObj.hospitalRadius;
    newFilterObj.hasCashLessInsurance = filterObj.hasCashLessInsurance;
    newFilterObj.hasHandleEmergencies = filterObj.hasHandleEmergencies;
    newFilterObj.hasParking = filterObj.hasParking;
    
    newFilterObj.isFamilyMember = filterObj.isFamilyMember;
    newFilterObj.typeOfProblem = filterObj.typeOfProblem;
    newFilterObj.age = filterObj.age;
    newFilterObj.gender = filterObj.gender;
    newFilterObj.location = filterObj.location;
    
    return newFilterObj;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.hospitalRadius=nil;
        self.hasCashLessInsurance =NO;
        self.hasHandleEmergencies=NO;
        self.hasParking=NO;
        
        self.isFamilyMember = NO;
        self.typeOfProblem = nil;
        self.age = nil;
        self.gender=nil;
        self.location=nil;
    }
    return self;
}

+(void)resetAllFilters
{
    [self resetNormalFilters];
    [self resetEmergencyFilters];
}

+(void)resetNormalFilters
{
    FiltersObject *filterObj =[FiltersObject sharedInstance];
    filterObj.hospitalRadius=nil;
    filterObj.hasCashLessInsurance =NO;
    filterObj.hasHandleEmergencies=NO;
    filterObj.hasParking=NO;
}

+(void)resetEmergencyFilters
{
    FiltersObject *filterObj =[FiltersObject sharedInstance];
    filterObj.isFamilyMember = NO;
    filterObj.typeOfProblem = nil;
    filterObj.age = nil;
    filterObj.gender=nil;
    filterObj.location=nil;
}


@end
