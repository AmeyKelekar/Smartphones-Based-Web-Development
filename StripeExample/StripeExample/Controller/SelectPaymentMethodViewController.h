//
//  SelectPaymentMethodViewController.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerDetailsViewController.h"
#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
@class OnlinePaymentViewController;

@interface SelectPaymentMethodViewController : UIViewController<UITextFieldDelegate>{
    
    IBOutlet UILabel *onlinePaymentLabel;
    IBOutlet UILabel *cashOnDeliveryLabel;
    IBOutlet UIButton *submitOrderButton;
    IBOutlet UIButton *onlinePaymentButton;
    IBOutlet UIButton *cashOnDeliveryButton;
    IBOutlet UILabel *totalLabel;
    IBOutlet UITextField *totalTextField;
}
@property (strong, nonatomic) IBOutlet UIButton *cashOnDeliveryButton;
@property (strong, nonatomic) IBOutlet UIButton *onlinePaymentButton;
@property (strong, nonatomic) IBOutlet UIButton *submitOrderButton;
@property (strong, nonatomic) IBOutlet UILabel *onlinePaymentLabel;
@property (strong, nonatomic) IBOutlet UILabel *cashOnDeliveryLabel;
@property (strong, nonatomic) IBOutlet UITextField *totalTextField;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) CustomerDetailsViewController *customerDetailsViewController;
@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) OnlinePaymentViewController *onlinePaymentViewController;
@property (strong, nonatomic) NSNumber *total;
@property (strong, nonatomic) Customer *customer;
@property (strong, nonatomic) NSNumber *myFlag;

- (IBAction)onSubmitOrderButtonClicked:(id)sender;

@end
