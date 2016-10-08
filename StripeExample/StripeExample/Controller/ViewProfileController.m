//
//  ViewProfileController.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import "ViewProfileController.h"


@interface ViewProfileController ()

@end

@implementation ViewProfileController

@synthesize userProfileLabel;
@synthesize emailIdLabel;
@synthesize emailIdTextField;
@synthesize lastNameLabel;
@synthesize lastNameTextField;
@synthesize firstNameLabel;
@synthesize firstNameTextField;
@synthesize mobileNumberLabel;
@synthesize moblieNumberTextField;
@synthesize customer;
@synthesize myDetailsViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Customer Name is in view profile: %@",self.customer.firstname);
    self.firstNameTextField.text = self.customer.firstname;
    self.lastNameTextField.text = self.customer.lastname;
    self.moblieNumberTextField.text = [self.customer.mobilenumber stringValue];
    self.emailIdTextField.text = self.customer.emailid;
    self.firstNameTextField.userInteractionEnabled = NO;
    self.lastNameTextField.userInteractionEnabled = NO;
    self.moblieNumberTextField.userInteractionEnabled = NO;
    self.emailIdTextField.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

