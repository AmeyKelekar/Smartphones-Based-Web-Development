//
//  MyCartViewController.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectQuantityViewController.h"
//#import "ListItemViewController.h"
@class CustomerDetailsViewController;

@interface MyCartViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UILabel *myOrderLabel;
    IBOutlet UITableView *cartTableView;
    IBOutlet UILabel *totalPriceLabel;
    IBOutlet UITextField *totalPriceTextField;
    IBOutlet UIButton *proceedToCheckoutButton;
}

@property (strong, nonatomic) IBOutlet UIButton *proceedToCheckoutButton;
@property (strong, nonatomic) IBOutlet UILabel *myOrderLabel;
@property (strong, nonatomic) IBOutlet UITableView *cartTableView;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (strong, nonatomic) IBOutlet UITextField *totalPriceTextField;
@property (strong, nonatomic) SelectQuantityViewController *selectQuantityViewController;
@property (strong, nonatomic) CustomerDetailsViewController *customerDetailsViewController;
//@property (strong, nonatomic) ListItemViewController *listItemViewController;
//an array to have cart data objects
@property (nonatomic,strong) NSMutableArray *productOfCart;
@property (strong, nonatomic) Customer *customer;

- (IBAction)onProceedToCheckoutButtonClicked:(id)sender;

@end

