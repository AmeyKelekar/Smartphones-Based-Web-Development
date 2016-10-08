//
//  MyDetailsViewController.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "LoginViewController.h"
@class ViewProfileController;
@class MyOrderViewController;

@interface MyDetailsViewController : UIViewController{
    IBOutlet UIButton *myOrdersButton;
    IBOutlet UIButton *viewProfileButton;
}

@property (strong, nonatomic) IBOutlet UIButton *myOrdersButton;
@property (strong, nonatomic) IBOutlet UIButton *viewProfileButton;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) ViewProfileController *viewProfileController;
@property (strong, nonatomic) MyOrderViewController *myOrderViewController;
@property (strong, nonatomic) Customer *customer;

- (IBAction)onViewProfileButtonCicked:(id)sender;
- (IBAction)onMyOrderButtonClicked:(id)sender;


@end
