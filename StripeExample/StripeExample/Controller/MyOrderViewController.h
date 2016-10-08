//
//  MyOrderViewController.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDetailsViewController.h"
#import <ParseUI/ParseUI.h>

@interface MyOrderViewController : PFQueryTableViewController<UITableViewDelegate>{
    IBOutlet UITableView *myOrderTableView;
}

@property (strong, nonatomic) IBOutlet UITableView *myOrderTableView;
@property (strong, nonatomic) Customer *customer;
@property (strong, nonatomic) MyDetailsViewController *myDetailsViewController;
@property (strong,nonatomic) NSArray *orderList;

@property (nonatomic) NSString *productName;
@property (nonatomic) NSNumber *quantity;
@property (nonatomic) NSNumber *size;
@property (nonatomic) NSNumber *actualprice;

@end

