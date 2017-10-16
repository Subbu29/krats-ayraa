//
//  TOECacheController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOENetworkingUtil.h"
#import "TOEAPIConstants.h"
@interface TOECacheController : NSObject

+(instancetype)sharedInstance;

@property (nonatomic) BOOL isHomeAPICalled;
@property (nonatomic,strong) NSCache *controllerCache;

//login

-(void)getLoginDetailsWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(LoginBlock)block;

//register

-(void)registerUserWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(RegisterUserBlock)block;

//fblogin

-(void)registerFBUserWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(FBLoginBlock)block;

//forgotpassword

-(void)getForgotPasswordWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(ForgotPasswordBlock)block;

//resetpassword

-(void)resetPasswordWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(ResetPasswordBlock)block;

//searchhospital

-(void)getsearchHospitalsWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(SearchHospitalBlock)block;

//filterhospitalwithbrowsingmode

-(void)getHospitalsInBrowsingModeWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(FilterBrowsingBlock)block;

//filterhospitalwithemergencymode

-(void)getHospitalsInEmergencyModeWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(FilterEmergencyBlock)block;

//addrelative

-(void)addRelativeForUserWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(AddReltaiveBlock)block;

//updaterelative

-(void)updateRelativeForUserWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(UpdateReltaiveBlock)block;

//deleterelative

-(void)deleteRelativeForUserWithUrl:(NSString *)urlString andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(DeleteReltaiveBlock)block;

@end
