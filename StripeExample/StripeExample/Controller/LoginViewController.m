//
//  LoginViewController.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import "LoginViewController.h"
#import "SelectPaymentMethodViewController.h"
#import "MyDetailsViewController.h"
#import "NSString+ReadString.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize submitButton;
@synthesize mobileNumberLabel;
@synthesize mobileNumberTextField;
@synthesize loginLabel;
@synthesize customerIdLabel;
@synthesize customerIdTextField;
@synthesize customerDetailsViewController;
@synthesize currentResponder;
@synthesize selectPaymentMethodViewController;
@synthesize viewController;
@synthesize myDetailsViewController;
@synthesize total;
@synthesize flag;
@synthesize customer;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"My login view controller total is:%@",self.total);
    NSLog(@"Flag Value is:%@",self.flag);
    // Do any additional setup after loading the view.
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];
    //End gesture recognizer
    
}

-(void) dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

//Implement the below delegate method:
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentResponder = textField;
}

//Implement resignOnTap:
- (void)resignOnTap:(id)iSender {
    [self.currentResponder resignFirstResponder];
}

- (void) giveAlert: (UITextField*) textField : (NSString *) errorMessage{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error Message" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [textField becomeFirstResponder];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) giveErrorAlert : (NSString *) errorMessage{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error Message" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)onSubmitButtonClicked:(id)sender {
    //Checking whether string contains only whitespace.
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([[self.mobileNumberTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.mobileNumberTextField : @"Mobile number contains only white spaces"];
    }
    
    else if([self.mobileNumberTextField.text validatePhoneNumber:self.mobileNumberTextField.text] == false){
        [self giveAlert: self.mobileNumberTextField: @"Entered Mobile number should be minimum 7 digits, maximum 10 digits and the first digit must be 1,2,3,4,5,6,7,8 or 9"];
    }
    
    else if ([[self.customerIdTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.customerIdTextField : @"Customer ID contains only white spaces"];
    }
    
    else if([self.customerIdTextField.text validatePhoneNumber:self.customerIdTextField.text] == false){
        [self giveAlert: self.customerIdTextField: @"Entered customer ID should be minimum 7 digits, maximum 10 digits and the first digit must be 1,2,3,4,5,6,7,8 or 9"];
    }
    
    else{
        // Register our parse app with nsthe service
        NSMutableArray *allObjects = [[NSMutableArray alloc]init];
        [Parse setApplicationId:@"Wqip6okW5ZL4bn4IikxII9bbk12DS5KVarCkGr8Q"
                      clientKey:@"ef2zLzF6jTT3Ahq9tOyf1Gt2mKcabL90bdxo4npe"];
        
        PFQuery *query = [PFQuery queryWithClassName:@"Customers"];
        [query whereKey:@"mobilenumber" equalTo:[NSNumber numberWithInteger: [self.mobileNumberTextField.text integerValue]]];
        [query whereKey:@"custid" equalTo:[NSNumber numberWithInteger: [self.customerIdTextField.text integerValue]]];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (object != nil) {
                NSLog(@"User exist");
                [allObjects addObject:object];
                if(self.customerDetailsViewController.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer == nil){
                    self.customerDetailsViewController.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer = [[Customer alloc ]init];
                }
                self.customerDetailsViewController.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.custid = [NSNumber numberWithInteger: [self.mobileNumberTextField.text integerValue]];
                self.customerDetailsViewController.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.mobilenumber = [NSNumber numberWithInteger: [self.mobileNumberTextField.text integerValue]];
                self.customerDetailsViewController.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.firstname = [[allObjects valueForKey:@"firstname"] objectAtIndex:0];
                self.customerDetailsViewController.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.lastname = [[allObjects valueForKey:@"lastname"] objectAtIndex:0];
                self.customerDetailsViewController.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.emailid = [[allObjects valueForKey:@"lastname"] objectAtIndex:0];
                //[self performSegueWithIdentifier:@"proceedToPayment" sender:sender];
                if(self.customer == nil){
                    self.customer = [[Customer alloc ]init];
                }
                self.viewController.flag = @0.0;
                self.customer.custid = [NSNumber numberWithInteger: [self.mobileNumberTextField.text integerValue]];
                self.customer.mobilenumber = [NSNumber numberWithInteger: [self.mobileNumberTextField.text integerValue]];
                self.customer.firstname = [[allObjects valueForKey:@"firstname"] objectAtIndex:0];
                self.customer.lastname = [[allObjects valueForKey:@"lastname"] objectAtIndex:0];
                self.customer.emailid = [[allObjects valueForKey:@"emailid"] objectAtIndex:0];
                NSLog(@"FirstName is: %@",self.customer.firstname);
                self.viewController.customer = self.customer;
                NSLog(@"My Array FirstName is: %@", self.viewController.customer.firstname);
                if([[flag stringValue] isEqualToString:@"1"]){
                    [self performSegueWithIdentifier:@"segueBackToMyDetails" sender:sender];
                }
                else{
                    [self performSegueWithIdentifier:@"proceedToPayment" sender:sender];
                }
            }
            else
            {
                NSLog(@"User don`t exist");
                [self giveErrorAlert:@"Please enter valid login details!!!"];
            }
        }];
    }
    NSLog(@"My Array FirstName is ootside block: %@", self.viewController.customer.firstname);
    //    if([[flag stringValue] isEqualToString:@"1"]){
    //        [self performSegueWithIdentifier:@"segueBackToMyDetails" sender:sender];
    //    }
    //    else{
    //        [self performSegueWithIdentifier:@"proceedToPayment" sender:sender];
    //    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"proceedToPayment"]) {
        self.selectPaymentMethodViewController = segue.destinationViewController;
        selectPaymentMethodViewController.loginViewController = self;
        self.selectPaymentMethodViewController.total =self.total ;
        self.selectPaymentMethodViewController.title = @"Payment Options";
    }
    else if([[segue identifier] isEqualToString:@"segueBackToMyDetails"]) {
        self.myDetailsViewController = segue.destinationViewController;
        myDetailsViewController.loginViewController = self;
        self.viewController.flag = @0.0;
        self.myDetailsViewController.customer = self.customer;
        self.myDetailsViewController.title = @"My Details";
    }
    CATransition *transition =[CATransition animation];
    transition.duration = 0.3f;
    transition.type=kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
}

@end

