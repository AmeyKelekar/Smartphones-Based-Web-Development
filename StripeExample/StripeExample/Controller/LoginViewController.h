//
//  LoginViewController.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerDetailsViewController.h"
#import "ViewController.h"
@class SelectPaymentMethodViewController;
@class MyDetailsViewController;

@interface LoginViewController : UIViewController{
    
    IBOutlet UITextField *mobileNumberTextField;
    IBOutlet UILabel *loginLabel;
    IBOutlet UILabel *mobileNumberLabel;
    IBOutlet UIButton *submitButton;
    IBOutlet UILabel *customerIdLabel;
    IBOutlet UITextField *customerIdTextField;
}

@property (strong, nonatomic) IBOutlet UILabel *customerIdLabel;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (strong, nonatomic) IBOutlet UILabel *loginLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobileNumberLabel;
@property (strong, nonatomic) IBOutlet UITextField *customerIdTextField;
@property (strong, nonatomic) CustomerDetailsViewController *customerDetailsViewController;
@property (strong, nonatomic) SelectPaymentMethodViewController *selectPaymentMethodViewController;
@property (strong, nonatomic) MyDetailsViewController *myDetailsViewController;
@property (strong , nonatomic) ViewController *viewController;
@property (nonatomic, assign) id currentResponder;
@property (strong, nonatomic) NSNumber *total;
@property (strong, nonatomic) NSNumber *flag;
@property (strong, nonatomic) Customer *customer;

- (IBAction)onSubmitButtonClicked:(id)sender;

@end

