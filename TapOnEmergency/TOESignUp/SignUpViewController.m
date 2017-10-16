//
//  SignUpViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 04/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "SignUpViewController.h"
#import "TOEConstants.h"
#import "TOECacheController.h"

#define ERROR_LABELS_TAG_CONSTANT 111

@interface SignUpViewController ()

@end

@implementation SignUpViewController
{
    UITextField *previousTextField;
    NSString *gender;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
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

- (void)keyboardWillShow:(NSNotification *)notify
{
    CGSize keyboardSize = [[[notify userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat keyboardHeight = MIN(keyboardSize.height,keyboardSize.width);
    CGFloat remainingHeight = self.mainsSrcollView.frame.size.height - keyboardHeight;
    CGFloat textFieldPosition = self.mainsSrcollView.frame.origin.y+previousTextField.frame.origin.y + previousTextField.frame.size.height;
    if (textFieldPosition>remainingHeight) {
        [_mainsSrcollView setContentOffset:CGPointMake(0, textFieldPosition-remainingHeight)];
    }
}

- (void)keyboardWillHide:(NSNotification *)notify
{
    [_mainsSrcollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

-(void)setUpViews
{
    [self setPlaceHolderTextColors];
    [self setBottombordersForTextFields];
}

-(void)setBottombordersForTextFields
{
    [self addBottomBorderToTextField:_firstNameTextField andBorderColor:[UIColor lightGrayColor]];
    [self addBottomBorderToTextField:_lastNameTextField andBorderColor:[UIColor lightGrayColor]];
    [self addBottomBorderToTextField:_passwordTextField andBorderColor:[UIColor lightGrayColor]];
    [self addBottomBorderToTextField:_confirmPasswordTextField andBorderColor:[UIColor lightGrayColor]];
    [self addBottomBorderToTextField:_emailIdTextField andBorderColor:[UIColor lightGrayColor]];
    [self addBottomBorderToTextField:_mobileNumberTextField andBorderColor:[UIColor lightGrayColor]];
}

-(void)setPlaceHolderTextColors
{
    [self setPlaceHolderTextColorForTextField:_firstNameTextField];
    [self setPlaceHolderTextColorForTextField:_lastNameTextField];
    [self setPlaceHolderTextColorForTextField:_passwordTextField];
    [self setPlaceHolderTextColorForTextField:_confirmPasswordTextField];
    [self setPlaceHolderTextColorForTextField:_emailIdTextField];
    [self setPlaceHolderTextColorForTextField:_mobileNumberTextField];
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

- (IBAction)acceptPermissionButtonClicked:(id)sender {
    // accept permission
}

- (IBAction)signUpButtonClicked:(id)sender {
    if ([self isDataValid]) {
        // hit api and move to home
        NSString *urlString = [NSString stringWithFormat:@"%@register",TOE_WEB_API_URL];
//        {
//            "emailId": "alimparkar@live.in",
//            "firstName": "Alim",
//            "lastName": "Parkar",
//            "mobileNumber": "9766929688",
//            "password": "bc3f0724742b42466b0e4995ae616c2d"
//        }
//        NSString *email= [NSString stringWithFormat:@"alimparkarasd@live.in"];
//        NSString *firstName=[NSString stringWithFormat:@"Alimasd"];
//        NSString *lastName= [NSString stringWithFormat:@"Parkarasd"];
//        NSString *mobileNumber= [NSString stringWithFormat:@"9766009688"];
//        NSString *password= [NSString stringWithFormat:@"bc3f0724742b42466b0e4995ae616c2d"];
        
        NSMutableDictionary *postDataDict = [[NSMutableDictionary alloc] init];
        [postDataDict setValue:_emailIdTextField.text forKey:@"emailId"];
        [postDataDict setValue:_firstNameTextField.text forKey:@"firstName"];
        [postDataDict setValue:_lastNameTextField.text forKey:@"lastName"];
        [postDataDict setValue:_mobileNumberTextField.text forKey:@"mobileNumber"];
        NSString *md5String = [TOEConstants generateMD5:_passwordTextField.text];
        [postDataDict setValue:md5String forKey:@"password"];
        
        [[TOECacheController sharedInstance] registerUserWithUrl:urlString andPostData:postDataDict WithCompletionBlock:^(id userData, NSInteger statusCode) {
            
            switch (statusCode) {
                case STATUS_OK:
                {
                    // store user data;
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

- (IBAction)maleButtonClicked:(id)sender {
    gender = [NSString stringWithFormat:@"Male"];
}


- (IBAction)femaleButtonClicked:(id)sender {
    gender = [NSString stringWithFormat:@"Female"];
}

-(BOOL)isDataValid
{
    BOOL isDataValid = YES;
    if (![TOEConstants isUserNameValid:_firstNameTextField.text]) {
        isDataValid = NO;
        [self showErrorForView:_firstNameTextField withText:@"Enter Valid First Name"];
    }
    if (![TOEConstants isUserNameValid:_lastNameTextField.text]) {
        isDataValid = NO;
        [self showErrorForView:_lastNameTextField withText:@"Enter Valid Last Name"];
    }
    if (![TOEConstants isEmailIdValid:_emailIdTextField.text]) {
        isDataValid = NO;
        [self showErrorForView:_emailIdTextField withText:@"Enter Valid EmailID"];
    }
    if (![TOEConstants isPhoneNumberValid:_mobileNumberTextField.text]) {
        isDataValid = NO;
        [self showErrorForView:_mobileNumberTextField withText:@"Enter Valid Mobile Number"];
    }
    if (![TOEConstants isPasswordValid:_passwordTextField.text]) {
        isDataValid = NO;
        [self showErrorForView:_passwordTextField withText:@"Enter Valid Password"];
    }
    if (![_confirmPasswordTextField.text isEqualToString:_passwordTextField.text]) {
        isDataValid = NO;
        [self showErrorForView:_confirmPasswordTextField withText:@"Passwords Do not Match"];
    }
    if (!(gender.length>0)) {
        isDataValid = NO;
    }
    return isDataValid;
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
