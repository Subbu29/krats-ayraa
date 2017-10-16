//
//  ForgetPassWordViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 04/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPassWordViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,strong) UITextField *mobileNumberTextField;
@property(nonatomic,strong) UITextField *activationCodeTextField;
@property(nonatomic,strong) UITextField *passwordTextField;
@property(nonatomic,strong) UITextField *retypePasswordTextField;
@property(nonatomic,strong) UIButton *resetPasswordButton;




@end
