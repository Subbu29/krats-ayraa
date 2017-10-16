//
//  SignUpViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 04/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mainsSrcollView;

@property (weak, nonatomic) IBOutlet UIImageView *firstNameIcon;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;


@property (weak, nonatomic) IBOutlet UIImageView *lastNameIcon;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;


@property (weak, nonatomic) IBOutlet UIImageView *mobileNumberIcon;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;


@property (weak, nonatomic) IBOutlet UIImageView *emailIdIcon;
@property (weak, nonatomic) IBOutlet UITextField *emailIdTextField;


@property (weak, nonatomic) IBOutlet UIImageView *genderIcon;


@property (weak, nonatomic) IBOutlet UIImageView *passwordIcon;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@property (weak, nonatomic) IBOutlet UIImageView *confirmPasswordIcon;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;


@property (weak, nonatomic) IBOutlet UIButton *maleButton;
- (IBAction)maleButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
- (IBAction)femaleButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *acceptPermissionsButton;
- (IBAction)acceptPermissionButtonClicked:(id)sender;

- (IBAction)signUpButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@end
