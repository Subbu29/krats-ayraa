//
//  ViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 04/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *TOEImageView;
@property (weak, nonatomic) IBOutlet UILabel *TOETitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *TOEdescription;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutUsButton;
@property (weak, nonatomic) IBOutlet UIImageView *userNameIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)forgotPasswordClicked:(id)sender;

- (IBAction)loginButtonClicked:(id)sender;

- (IBAction)signUpButtonClicked:(id)sender;

- (IBAction)facebookButtonClicked:(id)sender;

- (IBAction)aboutUsButtonClicked:(id)sender;

@end

