//
//  SelectPaymentMethodViewController.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import "SelectPaymentMethodViewController.h"
#import "OnlinePaymentViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
@interface SelectPaymentMethodViewController ()

@end


@implementation SelectPaymentMethodViewController

@synthesize customerDetailsViewController;
@synthesize onlinePaymentViewController;
@synthesize loginViewController;
@synthesize cashOnDeliveryButton;
@synthesize cashOnDeliveryLabel;
@synthesize submitOrderButton;
@synthesize onlinePaymentButton;
@synthesize onlinePaymentLabel;
@synthesize totalLabel;
@synthesize totalTextField;
@synthesize total;
@synthesize customer;
@synthesize myFlag;

int flag = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"My select payment view controller total is:%@",self.total);
    // Do any additional setup after loading the view.
    [cashOnDeliveryButton setImage:[UIImage imageNamed:@"selectedradioButton.png"] forState:UIControlStateSelected];
    cashOnDeliveryButton.layer.cornerRadius = 22;
    cashOnDeliveryButton.layer.masksToBounds = YES;
    cashOnDeliveryButton.tag = 1;
    [cashOnDeliveryButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [onlinePaymentButton setImage:[UIImage imageNamed:@"selectedradioButton.png"] forState:UIControlStateSelected];
    onlinePaymentButton.layer.cornerRadius = 22;
    onlinePaymentButton.layer.masksToBounds = YES;
    onlinePaymentButton.tag = 2;
    [onlinePaymentButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.submitOrderButton.hidden = TRUE;
    self.totalLabel.hidden = TRUE;
    self.totalTextField.hidden = TRUE;
    self.totalTextField.userInteractionEnabled = NO;
    self.totalTextField.text = [self.total stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//textfield delegate method
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void) buttonClicked: (UIButton *)sender{
    switch (sender.tag)
    {
        case 1:
            if([cashOnDeliveryButton isSelected]==YES){
                [cashOnDeliveryButton setSelected:NO];
                self.submitOrderButton.hidden = TRUE;
                self.totalLabel.hidden = TRUE;
                self.totalTextField.hidden = TRUE;
            }
            else
            {
                [cashOnDeliveryButton setSelected:YES];
                [onlinePaymentButton setSelected:NO];
                self.submitOrderButton.hidden = FALSE;
                self.totalLabel.hidden = FALSE;
                self.totalTextField.hidden = FALSE;
            }
            break;
        case 2:
            if([onlinePaymentButton isSelected]==YES){
                [onlinePaymentButton setSelected:NO];
                self.submitOrderButton.hidden = TRUE;
                self.totalLabel.hidden = TRUE;
                self.totalTextField.hidden = TRUE;
            }
            else
            {
                [onlinePaymentButton setSelected:YES];
                [cashOnDeliveryButton setSelected:NO];
                self.submitOrderButton.hidden = TRUE;
                self.totalLabel.hidden = TRUE;
                self.totalTextField.hidden = TRUE;
                [self performSegueWithIdentifier:@"segueToOnlinePaymentVC" sender:sender];
            }
            break;
        default:
            break;
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToOnlinePaymentVC"]) {
        self.onlinePaymentViewController = segue.destinationViewController;
        onlinePaymentViewController.selectPaymentMethodViewController = self;
        self.onlinePaymentViewController.title = @"Online Payment Method";
        CATransition *transition =[CATransition animation];
        transition.duration = 0.3f;
        transition.type=kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    }
}


- (IBAction)onSubmitOrderButtonClicked:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirmation Message" message:@"Do you want to confirm the order?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        NSLog(@"Cancel Action");
    }];
    UIAlertAction* okAction= [UIAlertAction actionWithTitle:NSLocalizedString(@"OK",@"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"OK Action");
        flag = 1;
        
        // Register our parse app with the service
        [Parse setApplicationId:@"Wqip6okW5ZL4bn4IikxII9bbk12DS5KVarCkGr8Q"
                      clientKey:@"ef2zLzF6jTT3Ahq9tOyf1Gt2mKcabL90bdxo4npe"];
        
        PFQuery *query = [PFQuery queryWithClassName:@"Cust_orders"];
        int count = (int)[query countObjects];
        
        PFObject *custOrders = [PFObject objectWithClassName:@"Cust_orders"];
        if([[myFlag stringValue] isEqualToString:@"1"]){
            NSLog(@"I am in myFlag condition");
            [custOrders setObject: [NSNumber numberWithInteger: [self.customerDetailsViewController.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.custid integerValue]] forKey:@"custid"];
        }
        else{
            [custOrders setObject: [NSNumber numberWithInteger: [self.loginViewController.customerDetailsViewController.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.custid integerValue]] forKey:@"custid"];
        }
        //[custOrders setObject: [NSNumber numberWithInteger: [self.customer.custid integerValue]] forKey:@"custid"];
        [custOrders setObject:[[NSDate alloc]init] forKey:@"orderDate"];
        [custOrders setObject:@"PENDING" forKey:@"orderStatus"];
        [custOrders setObject:[NSNumber numberWithInt:(count+1)] forKey:@"orderid"];
        [custOrders saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded){
                NSLog(@"Object Uploaded!");
            }
            else{
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                NSLog(@"Error: %@", errorString);
            }
        }];
        
        NSMutableArray *list = self.customerDetailsViewController.myCartViewController.productOfCart;
        if(list == nil)
            list = self.loginViewController.customerDetailsViewController.myCartViewController.productOfCart;
        PFQuery *query1 = [PFQuery queryWithClassName:@"Order_Details"];
        int count1 = (int)[query1 countObjects];
        for (OrderProduct *op in list){
            PFObject *orderDetails = [PFObject objectWithClassName:@"Order_Details"];
            if([[myFlag stringValue] isEqualToString:@"1"]){
                [orderDetails setObject: [NSNumber numberWithInteger: [self.customerDetailsViewController.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.custid integerValue]] forKey:@"custid"];
            }
            else{
                [orderDetails setObject: [NSNumber numberWithInteger: [self.loginViewController.customerDetailsViewController.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.custid integerValue]] forKey:@"custid"];
            }
            //            [orderDetails setObject: [NSNumber numberWithInteger: [self.customer.custid integerValue]] forKey:@"custid"];
            [orderDetails setObject:[NSNumber numberWithInt:(count+1)] forKey:@"orderid"];
            [orderDetails setObject:op.productQuantity forKey:@"size"];
            [orderDetails setObject:op.productItemCount forKey:@"quantity"];
            [orderDetails setObject:op.productActualPrice forKey:@"actualprice"];
            [orderDetails setObject:op.productName forKey:@"productName"];
            [orderDetails setObject:op.productId forKey:@"productId"];
            [orderDetails setObject:[NSNumber numberWithInt:(count1+1)] forKey:@"order_details_id"];
            count1 = count1 + 1;
            [orderDetails saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded){
                    NSLog(@"Object Uploaded!");
                }
                else{
                    NSString *errorString = [[error userInfo] objectForKey:@"error"];
                    NSLog(@"Error: %@", errorString);
                }
            }];
        }
        
        [self.customerDetailsViewController.myCartViewController.productOfCart removeAllObjects];
        [self.loginViewController.customerDetailsViewController.myCartViewController.productOfCart removeAllObjects];
        //        self.loginViewController.customerDetailsViewController.myCartViewController.selectQuantityViewController.listItemViewController.viewController.total = @0.0;
        self.total = @0.0;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
@end
