//
//  ViewProfileController.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDetailsViewController.h"

@interface ViewProfileController : UIViewController{
    
    IBOutlet UILabel *userProfileLabel;
    IBOutlet UILabel *mobileNumberLabel;
    IBOutlet UILabel *emailIdLabel;
    IBOutlet UILabel *lastNameLabel;
    IBOutlet UILabel *firstNameLabel;
    IBOutlet UITextField *moblieNumberTextField;
    IBOutlet UITextField *emailIdTextField;
    IBOutlet UITextField *lastNameTextField;
    IBOutlet UITextField *firstNameTextField;
}
@property (strong, nonatomic) IBOutlet UILabel *userProfileLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailIdTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UILabel *mobileNumberLabel;
@property (strong, nonatomic) IBOutlet UITextField *moblieNumberTextField;
@property (strong, nonatomic) IBOutlet UILabel *emailIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UIView *firstNameLabel;

@property (strong, nonatomic) Customer *customer;
@property (strong, nonatomic) MyDetailsViewController *myDetailsViewController;

@end

