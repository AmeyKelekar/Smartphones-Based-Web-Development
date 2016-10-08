//
//  ViewController.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductList.h"
#import "Customer.h"
@class ListItemViewController;
@class MyDetailsViewController;
@class LoginViewController;

@interface ViewController : UIViewController{
    IBOutlet UIButton *shopCakesButton;
    IBOutlet UIButton *shopSweetsButton;
    IBOutlet UIImageView *cakeImageView;
    IBOutlet UIImageView *sweetImageView;
    IBOutlet UILabel *footerLabel;
    UIBarButtonItem *cartButton;
    UIBarButtonItem *menuButton;
}

@property (strong, nonatomic) IBOutlet UIImageView *cakeImageView;
@property (strong, nonatomic) IBOutlet UIImageView *sweetImageView;
@property (strong, nonatomic) IBOutlet UIButton *shopCakesButton;
@property (strong, nonatomic) IBOutlet UIButton *shopSweetsButton;
@property (strong, nonatomic) IBOutlet UILabel *footerLabel;
@property (strong, nonatomic) ListItemViewController *listItemViewController;
@property (strong, nonatomic) MyDetailsViewController *myDetailsViewController;
@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) ProductList *productList;
@property (strong, nonatomic) Customer *customer;
@property (strong, nonatomic) NSMutableArray *prodList;
@property (strong, nonatomic) UIBarButtonItem *cartButton;
@property (strong, nonatomic) UIBarButtonItem *menuButton;
@property (strong, nonatomic) NSMutableArray *myArray;
@property (strong, nonatomic) NSNumber *total;
@property (strong, nonatomic) NSNumber *flag;

- (IBAction)onShopCakesButtonClicked:(id)sender;
- (IBAction)onShopSweetsButtonClicked:(id)sender;

@end
