
//
//  LoginDataModal.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 25/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "LoginDataModal.h"

@implementation LoginDataModal

-(instancetype)initWithDictionary:(id)dict
{
    self = [super initWithDictionary:dict];
    if (self) {
        self.adminInfo = [[AdminInfo alloc] initWithDictionary:self.adminInfo];
        self.emergencyContacts = [EmergencyContacts arrayOfModelsFromDictionary:self.emergencyContacts];
        self.relatives=[UserRelatives arrayOfModelsFromDictionary:self.relatives];
        self.locations = [Locations arrayOfModelsFromDictionary:self.locations];
        self.incidents = [Incidents arrayOfModelsFromDictionary:self.incidents];
    }
    return self;
}

#pragma mark - Serialization and Deserialization Methods

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.adminInfo = [coder decodeObjectForKey:@"adminInfo"];
        self.asthama = [coder decodeObjectForKey:@"asthama"];
        self.birthDate = [coder decodeObjectForKey:@"birthDate"];
        self.bloodGroup = [coder decodeObjectForKey:@"bloodGroup"];
        self.bloodpressure = [coder decodeObjectForKey:@"bloodpressure"];
        self.companyId = [coder decodeObjectForKey:@"companyId"];
        self.currentMedication = [coder decodeObjectForKey:@"currentMedication"];
        self.diabetes = [coder decodeObjectForKey:@"diabetes"];
        self.emailId = [coder decodeObjectForKey:@"emailId"];
        self.emergencyContacts = [coder decodeObjectForKey:@"emergencyContacts"];
        self.epilepsy = [coder decodeObjectForKey:@"epilepsy"];
        self.firstName = [coder decodeObjectForKey:@"firstName"];
        self.gender = [coder decodeObjectForKey:@"gender"];
        self.hypertension = [coder decodeObjectForKey:@"hypertension"];
        self.incidents = [coder decodeObjectForKey:@"incidents"];
        self.lastName = [coder decodeObjectForKey:@"lastName"];
        self.locations = [coder decodeObjectForKey:@"locations"];
        self.majorSurgeries = [coder decodeObjectForKey:@"majorSurgeries"];
        self.mobileNumber = [coder decodeObjectForKey:@"mobileNumber"];
        self.profilePic = [coder decodeObjectForKey:@"profilePic"];
        self.relatives = [coder decodeObjectForKey:@"relatives"];
        self.thyroid = [coder decodeObjectForKey:@"thyroid"];
        self.token = [coder decodeObjectForKey:@"token"];
        self.userId = [coder decodeObjectForKey:@"userId"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.adminInfo forKey:@"adminInfo"];
    [coder encodeObject:self.asthama forKey:@"asthama"];
    [coder encodeObject:self.birthDate forKey:@"birthDate"];
    [coder encodeObject:self.bloodGroup forKey:@"bloodGroup"];
    [coder encodeObject:self.bloodpressure forKey:@"bloodpressure"];
    [coder encodeObject:self.companyId forKey:@"companyId"];
    [coder encodeObject:self.currentMedication forKey:@"currentMedication"];
    [coder encodeObject:self.diabetes forKey:@"diabetes"];
    [coder encodeObject:self.emailId forKey:@"emailId"];
    [coder encodeObject:self.emergencyContacts forKey:@"emergencyContacts"];
    [coder encodeObject:self.epilepsy forKey:@"epilepsy"];
    [coder encodeObject:self.firstName forKey:@"firstName"];
    [coder encodeObject:self.gender forKey:@"gender"];
    [coder encodeObject:self.hypertension forKey:@"hypertension"];
    [coder encodeObject:self.incidents forKey:@"incidents"];
    [coder encodeObject:self.lastName forKey:@"lastName"];
    [coder encodeObject:self.locations forKey:@"locations"];
    [coder encodeObject:self.majorSurgeries forKey:@"majorSurgeries"];
    [coder encodeObject:self.mobileNumber forKey:@"mobileNumber"];
    [coder encodeObject:self.profilePic forKey:@"profilePic"];
    [coder encodeObject:self.relatives forKey:@"relatives"];
    [coder encodeObject:self.thyroid forKey:@"thyroid"];
    [coder encodeObject:self.token forKey:@"token"];
    [coder encodeObject:self.userId forKey:@"userId"];
}


@end

@implementation AdminInfo

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        
        self.emailId = [coder decodeObjectForKey:@"emailId"];
        self.mobileNumber = [coder decodeObjectForKey:@"mobileNumber"];
        self.name = [coder decodeObjectForKey:@"name"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.emailId forKey:@"emailId"];
    [coder encodeObject:self.mobileNumber forKey:@"mobileNumber"];
    [coder encodeObject:self.name forKey:@"name"];
}



@end


@implementation EmergencyContacts

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
       
        self.contactId = [coder decodeObjectForKey:@"contactId"];
        self.contactName = [coder decodeObjectForKey:@"contactName"];
        self.contactNumber = [coder decodeObjectForKey:@"contactNumber"];
        self.userId = [coder decodeObjectForKey:@"userId"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.contactId forKey:@"contactId"];
    [coder encodeObject:self.contactName forKey:@"contactName"];
    [coder encodeObject:self.contactNumber forKey:@"contactNumber"];
    [coder encodeObject:self.userId forKey:@"userId"];
}




@end

@implementation Incidents

-(instancetype)initWithDictionary:(id)dict
{
    self = [super initWithDictionary:dict];
    if (self) {
        self.incidentDescription = [dict valueForKey:@"description"];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.body = [coder decodeObjectForKey:@"body"];
        self.incidentDescription = [coder decodeObjectForKey:@"incidentDescription"];
        self.incidentId = [coder decodeObjectForKey:@"incidentId"];
        self.incidentPriority = [coder decodeObjectForKey:@"incidentPriority"];
        self.incidentStatus = [coder decodeObjectForKey:@"incidentStatus"];
        self.incidentType = [coder decodeObjectForKey:@"incidentType"];
        self.isResponseOn = [coder decodeObjectForKey:@"isResponseOn"];
        self.timestamp = [coder decodeObjectForKey:@"timestamp"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.userStatus = [coder decodeObjectForKey:@"userStatus"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.body forKey:@"body"];
    [coder encodeObject:self.incidentDescription forKey:@"incidentDescription"];
    [coder encodeObject:self.incidentId forKey:@"incidentId"];
    [coder encodeObject:self.incidentPriority forKey:@"incidentPriority"];
    [coder encodeObject:self.incidentStatus forKey:@"incidentStatus"];
    [coder encodeObject:self.incidentType forKey:@"incidentType"];
    [coder encodeObject:self.isResponseOn forKey:@"isResponseOn"];
    [coder encodeObject:self.timestamp forKey:@"timestamp"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.userStatus forKey:@"userStatus"];
}




@end

@implementation Locations

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        

        self.latitude = [coder decodeObjectForKey:@"latitude"];
        self.locationId = [coder decodeObjectForKey:@"locationId"];
        self.locationName = [coder decodeObjectForKey:@"locationName"];
        self.longitude = [coder decodeObjectForKey:@"longitude"];
        self.userId = [coder decodeObjectForKey:@"userId"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.latitude forKey:@"latitude"];
    [coder encodeObject:self.locationId forKey:@"locationId"];
    [coder encodeObject:self.locationName forKey:@"locationName"];
    [coder encodeObject:self.longitude forKey:@"longitude"];
    [coder encodeObject:self.userId forKey:@"userId"];
}



@end

@implementation UserRelatives

-(instancetype)initWithDictionary:(id)dict
{
    self = [super initWithDictionary:dict];
    if (self) {
        self.asthama = [[dict valueForKey:@"asthama"] boolValue];
        self.bloodpressure = [[dict valueForKey:@"bloodpressure"] boolValue];
        self.diabetes = [[dict valueForKey:@"diabetes"] boolValue];
        self.epilepsy = [[dict valueForKey:@"epilepsy"] boolValue];
        self.hypertension = [[dict valueForKey:@"hypertension"] boolValue];
        self.thyroid = [[dict valueForKey:@"thyroid"] boolValue];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    UserRelatives *object = [[[self class] allocWithZone:zone] init];
    
    object.asthama = self.asthama;
    object.birthDate = self.birthDate;
    object.bloodGroup=self.bloodGroup;
    object.bloodpressure = self.bloodpressure;
    object.currentMedication = self.currentMedication;
    object.diabetes = self.diabetes;
    object.epilepsy  = self.epilepsy;
    object.gender = self.gender;
    object.hypertension = self.hypertension;
    object.lastModifiedDate = self.lastModifiedDate;
    object.majorSurgeries = self.majorSurgeries;
    object.mobileNumber = self.mobileNumber;
    object.relation =self.relation;
    object.relativeId = self.relativeId;
    object.relativeName = self.relativeName;
    object.thyroid = self.thyroid;
    object.userId = self.userId;
    
    return object;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.asthama = [coder decodeBoolForKey:@"asthama"];
        self.birthDate = [coder decodeObjectForKey:@"birthDate"];
        self.bloodGroup = [coder decodeObjectForKey:@"bloodGroup"];
        self.bloodpressure = [coder decodeBoolForKey:@"bloodpressure"];
        self.currentMedication = [coder decodeObjectForKey:@"currentMedication"];
        self.diabetes = [coder decodeBoolForKey:@"diabetes"];
        self.epilepsy = [coder decodeBoolForKey:@"epilepsy"];
        self.gender = [coder decodeObjectForKey:@"gender"];
        self.hypertension = [coder decodeBoolForKey:@"hypertension"];
        self.majorSurgeries = [coder decodeObjectForKey:@"majorSurgeries"];
        self.lastModifiedDate = [coder decodeObjectForKey:@"lastModifiedDate"];
        self.relation = [coder decodeObjectForKey:@"relation"];
        self.relativeId = [coder decodeObjectForKey:@"relativeId"];
        self.relativeName = [coder decodeObjectForKey:@"relativeName"];
        self.mobileNumber = [coder decodeObjectForKey:@"mobileNumber"];
        self.thyroid = [coder decodeBoolForKey:@"thyroid"];
        self.userId = [coder decodeObjectForKey:@"userId"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    
    [coder encodeBool:self.asthama forKey:@"asthama"];
    [coder encodeObject:self.birthDate forKey:@"birthDate"];
    [coder encodeObject:self.bloodGroup forKey:@"bloodGroup"];
    [coder encodeBool:self.bloodpressure forKey:@"bloodpressure"];
    [coder encodeObject:self.currentMedication forKey:@"currentMedication"];
    [coder encodeBool:self.diabetes forKey:@"diabetes"];
    [coder encodeBool:self.epilepsy forKey:@"epilepsy"];
    [coder encodeObject:self.gender forKey:@"gender"];
    [coder encodeBool:self.hypertension forKey:@"hypertension"];
    [coder encodeObject:self.majorSurgeries forKey:@"majorSurgeries"];
    [coder encodeObject:self.lastModifiedDate forKey:@"lastModifiedDate"];
    [coder encodeObject:self.relation forKey:@"relation"];
    [coder encodeObject:self.relativeId forKey:@"relativeId"];
    [coder encodeObject:self.relativeName forKey:@"relativeName"];
    [coder encodeObject:self.mobileNumber forKey:@"mobileNumber"];
    [coder encodeBool:self.thyroid forKey:@"thyroid"];
    [coder encodeObject:self.userId forKey:@"userId"];
}

@end
