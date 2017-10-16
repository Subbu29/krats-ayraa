//
//  ViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 04/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "ViewController.h"
#import "TOEConstants.h"
#import "AppDelegate.h"
#import "SignUpViewController.h"
#import "TOEHttpUtil.h"
#import "TOECacheController.h"
#import "LoginDataModal.h"
#import "ForgetPassWordViewController.h"

#define ERROR_LABELS_TAG_CONSTANT 111

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)setUpViews
{
    _loginButton.layer.borderColor = [UIColor colorWithRed:30.0f/255.0f green:138.0f/255.0f blue:206.0f/255.0f alpha:1.0f].CGColor;
    _loginButton.layer.borderWidth = 3.0f;
    _loginButton.layer.cornerRadius = 7.0f;
    [self addBottomBorderToTextField:_userNameTextField andBorderColor:[UIColor lightGrayColor]];
    [self addBottomBorderToTextField:_passwordTextField andBorderColor:[UIColor lightGrayColor]];
    [self setPlaceHolderTextColors];
}

-(void)addBottomBorderToTextField:(UITextField *)textField andBorderColor:(UIColor *)color
{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, textField.frame.size.height - 1.0f, textField.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = color.CGColor;
    [textField.layer addSublayer:bottomBorder];
}

-(void)setPlaceHolderTextColors
{
    [self setPlaceHolderTextColorForTextField:_userNameTextField];
    [self setPlaceHolderTextColorForTextField:_passwordTextField];
}

-(void)setPlaceHolderTextColorForTextField:(UITextField *)textField
{
    NSAttributedString *attributedPlaceHolder = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{ NSForegroundColorAttributeName :[UIColor lightGrayColor]}];
    textField.attributedPlaceholder = attributedPlaceHolder;
}

#pragma mark - textdfield delegate methods -

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self addBottomBorderToTextField:textField andBorderColor:[UIColor colorWithRed:0.0/255.0f green:140.0/255.0f blue:124.0/255.0f alpha:1.0f]];
    [self removeErrorViewForTextfield:textField];
    if (textField.tag == 10) {
        if (![self.view viewWithTag:(_passwordTextField.tag+ERROR_LABELS_TAG_CONSTANT)]) {
            [self addBottomBorderToTextField:_passwordTextField andBorderColor:[UIColor lightGrayColor]];
        }
        
    }
    else{
        if (![self.view viewWithTag:(_passwordTextField.tag+ERROR_LABELS_TAG_CONSTANT)]) {
            [self addBottomBorderToTextField:_userNameTextField andBorderColor:[UIColor lightGrayColor]];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addBottomBorderToTextField:textField andBorderColor:[UIColor lightGrayColor]];
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)isDataValid
{
    BOOL isDataValid = YES;
    if (![TOEConstants isEmailIdValid:_userNameTextField.text]) {
        isDataValid = NO;
        // show error for email Id
        [self showErrorForView:_userNameTextField withText:@"Enter Valid EmailID"];
    }
    if (![TOEConstants isPasswordValid:_passwordTextField.text]) {
        isDataValid = NO;
        [self showErrorForView:_passwordTextField withText:@"Enter Valid Password"];
        // show error for password
    }
    return isDataValid;
}

- (IBAction)forgotPasswordClicked:(id)sender {
    // push to forgot password flow
    ForgetPassWordViewController *forgotpwdViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgetPassWordViewController"];
    [self.navigationController pushViewController:forgotpwdViewController animated:YES];
}

- (IBAction)loginButtonClicked:(id)sender
{
    if ([self isDataValid]) {
        
        NSMutableDictionary *postDataDict = [[NSMutableDictionary alloc] init];
        [postDataDict setValue:[NSString stringWithFormat:@"%@",_userNameTextField.text] forKey:@"emailId"];
        NSString *pwdHD5 = [TOEConstants generateMD5:_passwordTextField.text];
        [postDataDict setValue:pwdHD5 forKey:@"password"];
        
        [[TOECacheController sharedInstance] getLoginDetailsWithUrl:[NSString stringWithFormat:@"%@login",TOE_WEB_API_URL] andPostData:postDataDict WithCompletionBlock:^(id loginData, NSInteger statusCode) {
            
            switch (statusCode) {
                case STATUS_OK:
                {
                    LoginDataModal *userData = [[LoginDataModal alloc] initWithDictionary:loginData];
                    [self storeUserData:userData];
                }
                    
                    break;
                case STATUS_NO_DATA:
                    
                    break;
                case STATUS_OBJECT_NOT_FOUND:
                    
                    break;
                case STATUS_NO_INTERNET:
                    
                    break;
                default:
                    
                    break;
            }
        }];
    }
}

-(void)storeUserData:(LoginDataModal *)userData
{
    NSUserDefaults *userStoredData  = [NSUserDefaults standardUserDefaults];
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:userData];
    [userStoredData setObject:encodedObject forKey:USER_STORED_DATA];
    
    [userStoredData setValue:userData.token forKey:USER_ACCESS_TOKEN];
    
    AppDelegate *appDelegateTemp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}

- (IBAction)signUpButtonClicked:(id)sender {
    
    // push to another view controller
    SignUpViewController *userSignUpViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self.navigationController pushViewController:userSignUpViewController animated:YES];
}

- (IBAction)facebookButtonClicked:(id)sender {
    // install fb login
}

- (IBAction)aboutUsButtonClicked:(id)sender {
    
}

#pragma mark - Error States -

-(void)showErrorForView:(UITextField *)textfield withText:(NSString *)errorMessage
{
    [self removeErrorViewForTextfield:textfield];
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


@end
