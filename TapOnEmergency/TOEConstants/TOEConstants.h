//
//  TOEConstants.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 05/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoginDataModal.h"

#define PADDING_1 1.0
#define PADDING_2 2.0
#define PADDING_5 5.0
#define PADDING_10 10.0
#define PADDING_15 15.0
#define PADDING_20 20.0
#define PADDING_30 30.0
#define PADDING_40 40.0
#define PADDING_50 50.0

#define EMERGENCY_MODE_BG_COLOR [UIColor colorWithRed:244.0f/255.0f green:67.0f/255.0f blue:52.0f/255.0f alpha:1.0f]

#define NORMAL_BG_COLOR [UIColor colorWithRed:2.0f/255.0f green:169.0f/255.0f blue:242.0f/255.0f alpha:1.0f]

#define USER_ACCESS_TOKEN @"USER_ACCESS_TOKEN"
#define USER_STORED_DATA @"USER_DATA"

#define IS_EMERGENCY @"IS_EMERGENCY"

@interface TOEConstants : NSObject

+(BOOL)isEmailIdValid:(NSString *)emailId;
+(BOOL)isPasswordValid:(NSString *)password;
+(BOOL)isUserNameValid:(NSString *)userName;
+(BOOL)isPhoneNumberValid:(NSString *)phoneNumber;

+(BOOL)isInEmergencyMode;

+(void)downloadUserData;

+(LoginDataModal *)getUserData;
+(void)updateUserDataWith:(LoginDataModal *)userData;


+(void)addBottomBorderToTextField:(UIView *)view andBorderColor:(UIColor *)color andWidth:(CGFloat)width;

+(void)addTopBorderToView:(UIView *)view andBorderColor:(UIColor *)color andWidth:(CGFloat)width;

+(NSString *)converStringToMD5StringWithString:(NSString *)convertString;


+(NSString *)generateMD5:(NSString *)input;

+(void)setImageToRightForButton:(UIButton *)button;

+(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message inView:(UIViewController *)vc;

@end
