//
//  MyDetailsViewController.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import "MyDetailsViewController.h"
#import "ViewProfileController.h"
#import "MyOrderViewController.h"

@interface MyDetailsViewController ()

@end

@implementation MyDetailsViewController

@synthesize viewController;
@synthesize loginViewController;
@synthesize myOrdersButton;
@synthesize viewProfileButton;
@synthesize customer;
@synthesize viewProfileController;
@synthesize myOrderViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Customer First Name in my details view controller is: %@",self.customer.firstname);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onViewProfileButtonCicked:(id)sender {
    [self performSegueWithIdentifier:@"segueToViewProfile" sender:sender];
    
}

- (IBAction)onMyOrderButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"sequeToMyOrders" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToViewProfile"]) {
        self.viewProfileController = segue.destinationViewController;
        viewProfileController.myDetailsViewController = self;
        self.viewProfileController.customer = self.customer;
        self.viewProfileController.title = @"My Profile";
    }
    if ([[segue identifier] isEqualToString:@"sequeToMyOrders"]) {
        self.myOrderViewController = segue.destinationViewController;
        myOrderViewController.myDetailsViewController = self;
        self.myOrderViewController.customer = self.customer;
        self.myOrderViewController.title = @"My Bookings";
    }
    CATransition *transition =[CATransition animation];
    transition.duration = 0.3f;
    transition.type=kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
}
@end
