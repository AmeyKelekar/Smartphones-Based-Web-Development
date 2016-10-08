//
//  SelectQuantityViewController.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItemViewController.h"
#import "OrderProductList.h"
#import "Product.h"
@class MyCartViewController;

@interface SelectQuantityViewController : UIViewController <UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>{
    ListItemViewController *listItemViewController;
    IBOutlet UILabel *productNameLabel;
    IBOutlet UILabel *productPriceLabel;
    IBOutlet UILabel *selectSizeLabel;
    IBOutlet UILabel *selectQuantityLabel;
    IBOutlet UIImageView *productImageView;
    IBOutlet UIButton *selectSizeButton;
    IBOutlet UITableView *selectSizeTable;
    IBOutlet UIButton *selectQuantityButton;
    IBOutlet UITableView *selectQuantityTable;
    IBOutlet UILabel *actualPriceLabel;
    IBOutlet UITextField *actualPriceTextField;
    IBOutlet UIButton *addToCartButton;
}

@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *selectSizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *selectQuantityLabel;
@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UIButton *selectSizeButton;
@property (strong, nonatomic) IBOutlet UITableView *selectSizeTable;
@property (strong, nonatomic) IBOutlet UIButton *selectQuantityButton;
@property (strong, nonatomic) IBOutlet UILabel *actualPriceLabel;
@property (strong, nonatomic) IBOutlet UITableView *selectQuantityTable;
@property (strong, nonatomic) IBOutlet UITextField *actualPriceTextField;
@property (strong, nonatomic) IBOutlet UIButton *addToCartButton;
@property (strong, nonatomic) ListItemViewController *listItemViewController;
@property (strong, nonatomic) MyCartViewController *myCartViewController;
@property (strong, nonatomic) Product *inputProduct;
@property (strong, nonatomic) OrderProductList *orderProductList;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *data1;
@property (strong, nonatomic) Customer *customer;

- (IBAction)selectSizeButtonAction:(id)sender;
- (IBAction)selectQuantityButonAction:(id)sender;
- (IBAction)onAddToCartButtonClicked:(id)sender;

@end