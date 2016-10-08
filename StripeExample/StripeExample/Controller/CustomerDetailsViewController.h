//
//  CustomerDetailsViewController.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCartViewController.h"
@class SelectPaymentMethodViewController;
@class LoginViewController;

@interface CustomerDetailsViewController : UIViewController{
    IBOutlet UILabel *newUserLabel;
    IBOutlet UILabel *firstNameLabel;
    IBOutlet UILabel *lastNameLabel;
    IBOutlet UILabel *emailIdLabel;
    IBOutlet UILabel *mobileNumberLabel;
    IBOutlet UIButton *registerButton;
    IBOutlet UITextField *firstNameTextField;
    IBOutlet UITextField *lastNameTextField;
    IBOutlet UITextField *emailIdTextField;
    IBOutlet UITextField *mobileNumberTextField;
    IBOutlet UIButton *loginButton;
}

@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobileNumberLabel;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailIdTextField;
@property (strong, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) MyCartViewController *myCartViewController;
@property (strong, nonatomic) SelectPaymentMethodViewController *selectPaymentMethodViewController;
@property (strong, nonatomic) LoginViewController *loginViewController;
@property (nonatomic, assign) id currentResponder;
@property (strong, nonatomic) NSNumber *total;
@property (strong, nonatomic) Customer *customer;

- (IBAction)onLoginButtonClicked:(id)sender;
- (IBAction)onRegisterButtonClicked:(id)sender;

@end

