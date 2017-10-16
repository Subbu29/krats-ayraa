//
//  TOENetworkingUtil.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "TOENetworkingUtil.h"
#import "TOECacheController.h"
#import "HospitalsListDataModal.h"
#import "TOEHttpUtil.h"
#import <AFNetworking.h>

@implementation TOENetworkingUtil


//login

+(void)getLoginDetailsWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(LoginBlock)block
{
    [TOEHttpUtil postDataFromNetworkWithUrl:urlString withParameters:postDataDictionary WithHeaders:apiHeaders WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
        block(operation.responseObject,statusCode);
        NSLog(@"%ld",(long)statusCode);
    }];
}

//register

+(void)registerUserWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(RegisterUserBlock)block
{
    
    [TOEHttpUtil postDataFromNetworkWithUrl:urlString withParameters:postDataDictionary WithHeaders:apiHeaders WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
        block(operation.responseObject,statusCode);
    }];
}

//fblogin

+(void)registerFBUserWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(FBLoginBlock)block
{
    [TOEHttpUtil postDataFromNetworkWithUrl:urlString withParameters:postDataDictionary WithHeaders:apiHeaders WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
        block(operation.responseObject,statusCode);
    }];
}

//forgotpassword

+(void)getForgotPasswordWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(ForgotPasswordBlock)block
{
    
    [TOEHttpUtil postDataFromNetworkWithUrl:urlString withParameters:postDataDictionary WithHeaders:apiHeaders WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
    block(operation.responseObject,statusCode);
    }];
}

//resetpassword

+(void)resetPasswordWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(ResetPasswordBlock)block
{
    [TOEHttpUtil postDataFromNetworkWithUrl:urlString withParameters:postDataDictionary WithHeaders:apiHeaders WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
        block(operation.responseObject,statusCode);
    }];
}

//searchhospital

+(void)getsearchHospitalsWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(SearchHospitalBlock)block
{
    [TOEHttpUtil postDataFromNetworkWithUrl:urlString withParameters:postDataDictionary WithHeaders:apiHeaders WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
        block(operation.responseObject,statusCode);
    }];
}

//filterhospitalwithbrowsingmode

+(void)getHospitalsInBrowsingModeWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(FilterBrowsingBlock)block
{
    [TOEHttpUtil postDataFromNetworkWithUrl:urlString withParameters:postDataDictionary WithHeaders:apiHeaders WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
        block(operation.responseObject,statusCode);
    }];
}

//filterhospitalwithemergencymode

+(void)getHospitalsInEmergencyModeWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(FilterEmergencyBlock)block
{
    [TOEHttpUtil postDataFromNetworkWithUrl:urlString withParameters:postDataDictionary WithHeaders:apiHeaders WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
        block(operation.responseObject,statusCode);
    }];
}

//addrelative

+(void)addRelativeForUserWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(AddReltaiveBlock)block
{
     
    [TOEHttpUtil postDataFromNetworkWithUrl:urlString withParameters:postDataDictionary WithHeaders:apiHeaders WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
        block(operation.responseObject,statusCode);
    }];
}

//updaterelative

+(void)updateRelativeForUserWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(UpdateReltaiveBlock)block
{
    [TOEHttpUtil postDataFromNetworkWithUrl:urlString withParameters:postDataDictionary WithHeaders:apiHeaders WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
        block(operation.responseObject,statusCode);
    }];
    
}

//deleterelative

+(void)deleteRelativeForUserWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(DeleteReltaiveBlock)block
{
    [TOEHttpUtil postDataFromNetworkWithUrl:urlString withParameters:postDataDictionary WithHeaders:apiHeaders WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
        block(operation.responseObject,statusCode);
    }];
}

@end
