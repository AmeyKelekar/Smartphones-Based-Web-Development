//
//  ListItemViewController.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Product.h"
@class SelectQuantityViewController;
//@class MyCartViewController;

@interface ListItemViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    NSMutableArray *allItems;
    NSMutableArray *displayItems;
    IBOutlet UITableView *listItemTableView;
    IBOutlet UISearchBar *listItemSearchBar;
    ViewController *viewController;
    Product *product;
}
@property (strong, nonatomic) IBOutlet UITableView *listItemTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *listItemSearchBar;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) Product *product;
@property (strong, nonatomic) SelectQuantityViewController *selectQuantityViewController;
//@property (strong, nonatomic) MyCartViewController *myCartViewContoller;
@property (strong, nonatomic) Customer *customer;

@end

