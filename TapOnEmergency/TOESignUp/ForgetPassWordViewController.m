//
//  ForgetPassWordViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 04/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "ForgetPassWordViewController.h"
#import "TOEConstants.h"

#define ERROR_LABELS_TAG_CONSTANT 111

@interface ForgetPassWordViewController ()

@end

@implementation ForgetPassWordViewController
{
    UITextField *previousTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpViews
{
    [self setUpMobileNumberTextField];
    [self setUpActivationCodeTextField];
    [self setUpPasswordTextField];
    [self setUpRetypePasswordTextField];
    [self setUpResetPasswordButton];
}

-(void)setUpMobileNumberTextField
{
    _mobileNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(PADDING_20, PADDING_50+PADDING_50, self.view.frame.size.width - PADDING_40, PADDING_30)];
    _mobileNumberTextField.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
    _mobileNumberTextField.placeholder = [NSString stringWithFormat:@"Mobile Number"];
    _mobileNumberTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0];
    _mobileNumberTextField.borderStyle = UITextBorderStyleNone;
    _mobileNumberTextField.textColor = [UIColor blackColor];
    _mobileNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _mobileNumberTextField.delegate = self;
    _mobileNumberTextField.tag = 22;
    [self addBottomBorderToTextField:_mobileNumberTextField andBorderColor:[UIColor lightGrayColor]];
    [self.view addSubview:_mobileNumberTextField];
}

-(void)setUpActivationCodeTextField
{
    _activationCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(PADDING_20, _mobileNumberTextField.frame.origin.y + _mobileNumberTextField.frame.size.height + PADDING_30, self.view.frame.size.width - PADDING_40, PADDING_30)];
    _activationCodeTextField.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
    _activationCodeTextField.placeholder = [NSString stringWithFormat:@"Activation Code"];
    _activationCodeTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0];
    _activationCodeTextField.borderStyle = UITextBorderStyleNone;
    _activationCodeTextField.textColor = [UIColor blackColor];
    [self addBottomBorderToTextField:_activationCodeTextField andBorderColor:[UIColor lightGrayColor]];
    _activationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _activationCodeTextField.tag = 23;
    _activationCodeTextField.delegate = self;
    _activationCodeTextField.hidden = YES;
    [self.view addSubview:_activationCodeTextField];
}

-(void)setUpPasswordTextField
{
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(PADDING_20, _activationCodeTextField.frame.origin.y+_activationCodeTextField.frame.size.height+PADDING_30, self.view.frame.size.width - PADDING_40, PADDING_30)];
    _passwordTextField.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
    _passwordTextField.placeholder = [NSString stringWithFormat:@"Enter New Password"];
    _passwordTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0];
    _passwordTextField.borderStyle = UITextBorderStyleNone;
    _passwordTextField.textColor = [UIColor blackColor];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.tag = 24;
    _passwordTextField.delegate = self;
    _passwordTextField.hidden = YES;
    [self addBottomBorderToTextField:_passwordTextField andBorderColor:[UIColor lightGrayColor]];
    [self.view addSubview:_passwordTextField];
}

-(void)setUpRetypePasswordTextField
{
    _retypePasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(PADDING_20, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height+PADDING_30, self.view.frame.size.width - PADDING_40, PADDING_30)];
    _retypePasswordTextField.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
    _retypePasswordTextField.placeholder = [NSString stringWithFormat:@"Confirm Password"];
    _retypePasswordTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0];
    _retypePasswordTextField.borderStyle = UITextBorderStyleNone;
    _retypePasswordTextField.textColor = [UIColor blackColor];
    _retypePasswordTextField.secureTextEntry = YES;
    _retypePasswordTextField.tag = 25;
    _retypePasswordTextField.delegate = self;
    _retypePasswordTextField.hidden = YES;
    [self addBottomBorderToTextField:_retypePasswordTextField andBorderColor:[UIColor lightGrayColor]];
    [self.view addSubview:_retypePasswordTextField];
    
}

-(void)setUpResetPasswordButton
{
    _resetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _resetPasswordButton.frame = CGRectMake(PADDING_20, _mobileNumberTextField.frame.origin.y + _mobileNumberTextField.frame.size.height + PADDING_15, self.view.frame.size.width - PADDING_40, PADDING_40);
    _resetPasswordButton.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
    [_resetPasswordButton setTitle:@"Reset Password" forState:UIControlStateNormal];
    _resetPasswordButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
    [_resetPasswordButton addTarget:self action:@selector(resetPasswordClicked) forControlEvents:UIControlEventTouchUpInside];
    _resetPasswordButton.backgroundColor = NORMAL_BG_COLOR;
    [self.view addSubview:_resetPasswordButton];
}

-(void)updateViewFrames
{
    if (!_retypePasswordTextField.hidden) {
        _resetPasswordButton.frame =CGRectMake(_resetPasswordButton.frame.origin.x, _mobileNumberTextField.frame.size.height+_mobileNumberTextField.frame.origin.y+PADDING_20, _resetPasswordButton.frame.size.width, _resetPasswordButton.frame.size.height);
    }
    else {
        _activationCodeTextField.hidden = NO;
        _passwordTextField.hidden = NO;
        _retypePasswordTextField.hidden = NO;
        _resetPasswordButton.frame =CGRectMake(_resetPasswordButton.frame.origin.x, _retypePasswordTextField.frame.size.height+_retypePasswordTextField.frame.origin.y+PADDING_20, _retypePasswordTextField.frame.size.width, _retypePasswordTextField.frame.size.height);
    }
}

-(void)resetPasswordClicked
{
    if (_passwordTextField.hidden) {
        if ([TOEConstants isPhoneNumberValid:_mobileNumberTextField.text]) {
         // hit api and unhide the fields
            [self updateViewFrames];
        }
        else {
            [self showErrorForView:_mobileNumberTextField withText:@"Enter Valid Mobile Number"];
        }
    }
    else{
        if ([self isDataValid]) {
            // hit api with resetting pwd
        }
    }
}

-(BOOL)isDataValid
{
    BOOL isDataValid = YES;
    if (![TOEConstants isPasswordValid:_passwordTextField.text]) {
        isDataValid = NO;
        [self showErrorForView:_passwordTextField withText:@"Enter Valid Password"];
    }
    if (![_passwordTextField.text isEqualToString:_retypePasswordTextField.text]) {
        isDataValid = NO;
        [self showErrorForView:_retypePasswordTextField withText:@"Passwords doesnt match"];
    }
    if (!(_activationCodeTextField.text.length>0)) {
        isDataValid = NO;
        [self showErrorForView:_activationCodeTextField withText:@"Activation Code Cant empty"];
    }
    if (![TOEConstants isPhoneNumberValid:_mobileNumberTextField.text]) {
        [self showErrorForView:_mobileNumberTextField withText:@"Enter Valid Mobile Number"];
    }
    return isDataValid;
}

#pragma mark - textfield delegate -

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self addBottomBorderToTextField:textField andBorderColor:[UIColor colorWithRed:0.0/255.0f green:140.0/255.0f blue:124.0/255.0f alpha:1.0f]];
    if (![self.view viewWithTag:(previousTextField.tag+ERROR_LABELS_TAG_CONSTANT)]) {
        [self addBottomBorderToTextField:previousTextField andBorderColor:[UIColor lightGrayColor]];
    }
    [self removeErrorViewForTextfield:textField];
    previousTextField = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addBottomBorderToTextField:textField andBorderColor:[UIColor lightGrayColor]];
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length>1) {
        return NO;
    }
    if (textField.tag ==22) {
        if (textField.text.length==10 && string.length>0) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - Error States -

-(void)showErrorForView:(UITextField *)textfield withText:(NSString *)errorMessage
{
    UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(textfield.frame.origin.x, textfield.frame.origin.y+textfield.frame.size.height + PADDING_2, textfield.frame.size.width, PADDING_15)];
    errorLabel.tag = textfield.tag + ERROR_LABELS_TAG_CONSTANT;
    errorLabel.text = errorMessage;
    errorLabel.font = [UIFont fontWithName:[NSString stringWithFormat:@"Helvetica Neue"] size:12.0];
    errorLabel.textColor = [UIColor redColor];
    errorLabel.textAlignment = NSTextAlignmentRight;
    [self addBottomBorderToTextField:textfield andBorderColor:[UIColor redColor]];
    [self.view addSubview:errorLabel];
}

-(void)addTopBorderToTextField:(UILabel *)errorLabel
{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 0.0f, errorLabel.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [errorLabel.layer addSublayer:bottomBorder];
}

-(void)removeErrorViewForTextfield:(UITextField *)textfield
{
    if ([self.view viewWithTag:(textfield.tag + ERROR_LABELS_TAG_CONSTANT)]!=nil) {
        [[self.view viewWithTag:(textfield.tag+ERROR_LABELS_TAG_CONSTANT)] removeFromSuperview];
    }
}

-(void)addBottomBorderToTextField:(UITextField *)textField andBorderColor:(UIColor *)color
{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, textField.frame.size.height - 1.0f, textField.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = color.CGColor;
    [textField.layer addSublayer:bottomBorder];
}

-(void)setPlaceHolderTextColorForTextField:(UITextField *)textField
{
    NSAttributedString *attributedPlaceHolder = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{ NSForegroundColorAttributeName :[UIColor lightGrayColor]}];
    textField.attributedPlaceholder = attributedPlaceHolder;
}

@end
