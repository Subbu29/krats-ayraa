//
//  TOEConstants.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 05/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "TOEConstants.h"
#import <CommonCrypto/CommonDigest.h>


// blue color 2,169,242
// emergency color 143 57,63

@implementation TOEConstants

#pragma mark - Email Id Validation -

+(BOOL)isEmailIdValid:(NSString *)emailId
{
    NSString *emailRegex = @"^[A-Za-z0-9]+((\\.[A-Za-z0-9]{1,})|(\\_[A-Za-z0-9]{1,}))*+@[A-Za-z]+(\\.[A-Za-z]{2,4}){1,}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailId];
    
}

#pragma mark - PassWord Validation -


+(BOOL)isPasswordValid:(NSString *)password
{
    BOOL isLowerCaseLetter = NO;
    BOOL isUpperCaseLetter = NO;
    BOOL isDigit = NO;
    BOOL isSpecialCharacter = NO;
    
    for (int i = 0; i < [password length]; i++)
    {
        unichar c = [password characterAtIndex:i];
        if(!isLowerCaseLetter)
        {
            isLowerCaseLetter = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c];
        }
        if(!isUpperCaseLetter)
        {
            isUpperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
        }
        if(!isDigit)
        {
            isDigit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
        }
    }
    
    NSString *specialChar = @"[^\"^'^ ]*";
    NSPredicate *specialCharTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", specialChar];
    isSpecialCharacter = [specialCharTest evaluateWithObject:password];
    
    return (isSpecialCharacter && isLowerCaseLetter && isDigit && isUpperCaseLetter);
}

+(BOOL)isUserNameValid:(NSString *)userName
{
    NSString *userNameRegex = @"[A-Za-z]+[A-Za-z ]*";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:userName];
}

+(BOOL)isPhoneNumberValid:(NSString *)phoneNumber
{
    NSString *phoneNoRegex = @"^[6789][0-9]{9}$";
    NSPredicate *phoneNoPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNoRegex];
    
    return [phoneNoPredicate evaluateWithObject:phoneNumber];
}

+(LoginDataModal *)getUserData
{
    NSUserDefaults *userStoredData  = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [userStoredData objectForKey:USER_STORED_DATA];
    
    id decodedObject = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    if ([decodedObject isKindOfClass:[LoginDataModal class]]) {
        LoginDataModal *userData = (LoginDataModal *)decodedObject;
        return userData;
    }
    return nil;
}

+(void)updateUserDataWith:(LoginDataModal *)userData
{
    NSUserDefaults *userStoredData  = [NSUserDefaults standardUserDefaults];
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:userData];
    [userStoredData setObject:encodedObject forKey:USER_STORED_DATA];
    
    [userStoredData setValue:userData.token forKey:USER_ACCESS_TOKEN];

}



+(void)addBottomBorderToTextField:(UIView *)view andBorderColor:(UIColor *)color andWidth:(CGFloat)width
{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, view.frame.size.height - width, view.frame.size.width, width);
    bottomBorder.backgroundColor = color.CGColor;
    [view.layer addSublayer:bottomBorder];
}

+(void)addTopBorderToView:(UIView *)view andBorderColor:(UIColor *)color andWidth:(CGFloat)width
{
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, view.frame.size.width, width);
    topBorder.backgroundColor = color.CGColor;
    [view.layer addSublayer:topBorder];
}

+(NSString *)converStringToMD5StringWithString:(NSString *)convertString {
    const char *cstr = [convertString UTF8String];
    unsigned char result[16];
    CC_MD5(cstr,(int)strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}

+(NSString *)generateMD5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr,(int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

+(void)setImageToRightForButton:(UIButton *)button
{
    button.imageEdgeInsets = UIEdgeInsetsMake(5, button.frame.size.width-30, 5, 10);
    button.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 40);
    button.semanticContentAttribute= UISemanticContentAttributeForceRightToLeft;
}

+(BOOL)isInEmergencyMode
{
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    NSString *emergency = [userData objectForKey:IS_EMERGENCY];
    if ([emergency isEqualToString:@"YES"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message inView:(UIViewController *)vc
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //                                        NSLog(@"ok button clicked");
                                    //Handle your yes please button action here
                                }];
    [alert addAction:yesButton];
    [vc presentViewController:alert animated:YES completion:nil];
}


+(void)downloadUserData
{
    
}

@end
