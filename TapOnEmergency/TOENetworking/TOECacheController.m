//
//  TOECacheController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "TOECacheController.h"

@implementation TOECacheController

+(instancetype)sharedInstance
{
    static TOECacheController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TOECacheController alloc] init];
        sharedInstance.controllerCache = [[NSCache alloc] init];
    });
    return sharedInstance;
}

-(void)getLoginDetailsWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(LoginBlock)block
{
    NSMutableDictionary *headerDict = [TOEAPIConstants addHeaders];
    
    [TOENetworkingUtil getLoginDetailsWithUrl:urlString andHeaders:headerDict andPostData:postDataDictionary WithCompletionBlock:block];
}

//register

-(void)registerUserWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(RegisterUserBlock)block
{
    NSMutableDictionary *headerDict = [TOEAPIConstants addHeaders];
    
    [TOENetworkingUtil registerUserWithUrl:urlString andHeaders:headerDict andPostData:postDataDictionary WithCompletionBlock:block];
}

//fblogin

-(void)registerFBUserWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(FBLoginBlock)block
{
    NSMutableDictionary *headerDict = [TOEAPIConstants addHeaders];
    
    [TOENetworkingUtil registerFBUserWithUrl:urlString andHeaders:headerDict andPostData:postDataDictionary WithCompletionBlock:block];
}

//forgotpassword

-(void)getForgotPasswordWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(ForgotPasswordBlock)block
{
    NSMutableDictionary *headerDict = [TOEAPIConstants addHeaders];
    
    [TOENetworkingUtil getForgotPasswordWithUrl:urlString andHeaders:headerDict andPostData:postDataDictionary WithCompletionBlock:block];
}

//resetpassword

-(void)resetPasswordWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(ResetPasswordBlock)block
{
    NSMutableDictionary *headerDict = [TOEAPIConstants addHeaders];
    
    [TOENetworkingUtil resetPasswordWithUrl:urlString andHeaders:headerDict andPostData:postDataDictionary WithCompletionBlock:block];
}

//searchhospital

-(void)getsearchHospitalsWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(SearchHospitalBlock)block
{
    NSMutableDictionary *headerDict = [TOEAPIConstants addHeaders];
    
    [TOENetworkingUtil getsearchHospitalsWithUrl:urlString andHeaders:headerDict andPostData:postDataDictionary WithCompletionBlock:block];
}

//filterhospitalwithbrowsingmode

-(void)getHospitalsInBrowsingModeWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(FilterBrowsingBlock)block
{
    NSMutableDictionary *headerDict = [TOEAPIConstants addHeaders];
    
    [TOENetworkingUtil getHospitalsInBrowsingModeWithUrl:urlString andHeaders:headerDict andPostData:postDataDictionary WithCompletionBlock:block];
}

//filterhospitalwithemergencymode

-(void)getHospitalsInEmergencyModeWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(FilterEmergencyBlock)block
{
    NSMutableDictionary *headerDict = [TOEAPIConstants addHeaders];
    
    [TOENetworkingUtil getHospitalsInEmergencyModeWithUrl:urlString andHeaders:headerDict andPostData:postDataDictionary WithCompletionBlock:block];
}

//addrelative

-(void)addRelativeForUserWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(AddReltaiveBlock)block
{
    
    NSMutableDictionary *headerDict = [TOEAPIConstants addHeaders];
    
    [TOENetworkingUtil addRelativeForUserWithUrl:urlString andHeaders:headerDict andPostData:postDataDictionary WithCompletionBlock:block];
}

//updaterelative

-(void)updateRelativeForUserWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(UpdateReltaiveBlock)block
{
    NSMutableDictionary *headerDict = [TOEAPIConstants addHeaders];
    
    [TOENetworkingUtil updateRelativeForUserWithUrl:urlString andHeaders:headerDict andPostData:postDataDictionary WithCompletionBlock:block];
    
}

//deleterelative

-(void)deleteRelativeForUserWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(DeleteReltaiveBlock)block
{
    NSMutableDictionary *headerDict = [TOEAPIConstants addHeaders];
    
    [TOENetworkingUtil deleteRelativeForUserWithUrl:urlString andHeaders:headerDict andPostData:postDataDictionary WithCompletionBlock:block];
}


@end
