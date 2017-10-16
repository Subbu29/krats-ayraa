//
//  TOENetworkingUtil.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <Foundation/Foundation.h>


//login

typedef void (^LoginBlock)(id loginData,NSInteger statusCode);

//register

typedef void (^RegisterUserBlock)(id userData,NSInteger statusCode);

//fblogin

typedef void (^FBLoginBlock)(id fbLoginData,NSInteger statusCode);

//forgotpassword

typedef void (^ForgotPasswordBlock)(id forgotPassWordData,NSInteger statusCode);

//resetpassword

typedef void (^ResetPasswordBlock)(id resetPasswordData,NSInteger statusCode);

//searchhospital

typedef void (^SearchHospitalBlock)(id searchHospitalData,NSInteger statusCode);

//filterhospitalwithbrowsingmode

typedef void (^FilterBrowsingBlock)(NSArray *filterBrowsingData,NSInteger statusCode);

//filterhospitalwithemergencymode

typedef void (^FilterEmergencyBlock)(id filterEmergencyData,NSInteger statusCode);

//addrelative

typedef void (^AddReltaiveBlock)(id addRelativeResponse,NSInteger statusCode);

//updaterelative

typedef void (^UpdateReltaiveBlock)(id updateRelativeResponse,NSInteger statusCode);

//deleterelative

typedef void (^DeleteReltaiveBlock)(id deleteRelativeResponse,NSInteger statusCode);

@interface TOENetworkingUtil : NSObject

//login

+(void)getLoginDetailsWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(LoginBlock)block;

//register

+(void)registerUserWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(RegisterUserBlock)block;

//fblogin

+(void)registerFBUserWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(FBLoginBlock)block;

//forgotpassword

+(void)getForgotPasswordWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(ForgotPasswordBlock)block;

//resetpassword

+(void)resetPasswordWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(ResetPasswordBlock)block;

//searchhospital

+(void)getsearchHospitalsWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(SearchHospitalBlock)block;

//filterhospitalwithbrowsingmode

+(void)getHospitalsInBrowsingModeWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(FilterBrowsingBlock)block;

//filterhospitalwithemergencymode

+(void)getHospitalsInEmergencyModeWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(FilterEmergencyBlock)block;

//addrelative

+(void)addRelativeForUserWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(AddReltaiveBlock)block;

//updaterelative

+(void)updateRelativeForUserWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(UpdateReltaiveBlock)block;

//deleterelative

+(void)deleteRelativeForUserWithUrl:(NSString *)urlString andHeaders:(NSMutableDictionary *)apiHeaders andPostData:(NSMutableDictionary *)postDataDictionary WithCompletionBlock:(DeleteReltaiveBlock)block;

@end
