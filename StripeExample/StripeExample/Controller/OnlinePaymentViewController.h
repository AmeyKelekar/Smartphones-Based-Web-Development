//
//  OnlinePaymentViewController.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPView.h"
#import "SelectPaymentMethodViewController.h"

@interface OnlinePaymentViewController : UIViewController <STPViewDelegate>

@property (strong, nonatomic) STPView* stripeView;
@property (strong, nonatomic) SelectPaymentMethodViewController *selectPaymentMethodViewController;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)onSaveButtonClicked:(id)sender;

@end
