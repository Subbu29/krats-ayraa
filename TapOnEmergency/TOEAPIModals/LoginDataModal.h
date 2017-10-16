//
//  LoginDataModal.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 25/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Initialization.h"
@class AdminInfo;


@interface LoginDataModal : NSObject

@property (strong,nonatomic) AdminInfo *adminInfo;
@property (strong,nonatomic) NSString *asthama;
@property (strong,nonatomic) NSString *birthDate;
@property (strong,nonatomic) NSString *bloodGroup;
@property (strong,nonatomic) NSString *bloodpressure;
@property (strong,nonatomic) NSString *companyId;
@property (strong,nonatomic) NSString *currentMedication;
@property (strong,nonatomic) NSString *diabetes;
@property (strong,nonatomic) NSString *emailId;
@property (strong,nonatomic) NSMutableArray *emergencyContacts;
@property (strong,nonatomic) NSString *epilepsy;
@property (strong,nonatomic) NSString *firstName;
@property (strong,nonatomic) NSString *gender;
@property (strong,nonatomic) NSString *hypertension;
@property (strong,nonatomic) NSMutableArray *incidents;
@property (strong,nonatomic) NSString *lastName;
@property (strong,nonatomic) NSMutableArray *locations;
@property (strong,nonatomic) NSString *majorSurgeries;
@property (strong,nonatomic) NSString *mobileNumber;
@property (strong,nonatomic) NSString *profilePic;
@property (strong,nonatomic) NSMutableArray *relatives;
@property (strong,nonatomic) NSString *thyroid;
@property (strong,nonatomic) NSString *token;
@property (strong,nonatomic) NSString *userId;

@end

@interface AdminInfo : NSObject

@property (strong,nonatomic) NSString *emailId;
@property (strong,nonatomic) NSString *mobileNumber;
@property (strong,nonatomic) NSString *name;

@end

@interface EmergencyContacts : NSObject

@property (strong,nonatomic) NSString *contactId;
@property (strong,nonatomic) NSString *contactName;
@property (strong,nonatomic) NSString *contactNumber;
@property (strong,nonatomic) NSString *userId;

@end

@interface Incidents : NSObject


@property (strong,nonatomic) NSString *body;
@property (strong,nonatomic) NSString *incidentDescription;
@property (strong,nonatomic) NSString *incidentId;
@property (strong,nonatomic) NSString *incidentPriority;
@property (strong,nonatomic) NSString *incidentStatus;
@property (strong,nonatomic) NSString *incidentType;
@property (strong,nonatomic) NSString *isResponseOn;
@property (strong,nonatomic) NSString *timestamp;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *userStatus;

@end

@interface Locations : NSObject

@property (strong,nonatomic) NSString *latitude;
@property (strong,nonatomic) NSString *locationId;
@property (strong,nonatomic) NSString *locationName;
@property (strong,nonatomic) NSString *longitude;
@property (strong,nonatomic) NSString *userId;

@end

@interface UserRelatives : NSObject <NSCopying>

@property (nonatomic) BOOL asthama;
@property (strong,nonatomic) NSString *birthDate;
@property (strong,nonatomic) NSString *bloodGroup;
@property (nonatomic) BOOL bloodpressure;
@property (strong,nonatomic) NSString *currentMedication;
@property (nonatomic) BOOL diabetes;
@property (nonatomic) BOOL epilepsy;
@property (strong,nonatomic) NSString *gender;
@property (nonatomic) BOOL hypertension;
@property (strong,nonatomic) NSString *lastModifiedDate;
@property (strong,nonatomic) NSString * majorSurgeries;
@property (strong,nonatomic) NSString *mobileNumber;
@property (strong,nonatomic) NSString *relation;
@property (strong,nonatomic) NSString *relativeId;
@property (strong,nonatomic) NSString *relativeName;
@property (nonatomic) BOOL thyroid;
@property (strong,nonatomic) NSString *userId;

@end
