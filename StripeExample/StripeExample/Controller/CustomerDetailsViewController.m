//
//  CustomerDetailsViewController.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import "CustomerDetailsViewController.h"
#import "SelectPaymentMethodViewController.h"
#import "LoginViewController.h"
#import "NSString+ReadString.h"
#import <Parse/Parse.h>

@interface CustomerDetailsViewController ()

@end

@implementation CustomerDetailsViewController

@synthesize myCartViewController;
@synthesize firstNameLabel;
@synthesize lastNameLabel;
@synthesize emailIdLabel;
@synthesize mobileNumberLabel;
@synthesize registerButton;
@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize emailIdTextField;
@synthesize mobileNumberTextField;
@synthesize loginButton;
@synthesize currentResponder;
@synthesize selectPaymentMethodViewController;
@synthesize loginViewController;
@synthesize total;
@synthesize customer;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"My customer details view controller total is:%@",self.total);
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)onLoginButtonClicked:(id)sender {
    //[self performSegueWithIdentifier:@"segueToLoginVC" sender:sender];
}

- (IBAction)onRegisterButtonClicked:(id)sender {
    //Checking whether string contains only whitespace.
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    
    if ([[self.firstNameTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.firstNameTextField : @"First name contains only white spaces"];
    }
    
    else if ([[self.lastNameTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.lastNameTextField : @"Last name contains only white spaces"];
    }
    else if ([[self.mobileNumberTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.mobileNumberTextField : @"Mobile number contains only white spaces"];
    }
    
    else if([self.mobileNumberTextField.text validatePhoneNumber:self.mobileNumberTextField.text] == false){
        [self giveAlert: self.mobileNumberTextField: @"Entered Mobile number should be minimum 7 digits, maximum 10 digits and the first digit must be 1,2,3,4,5,6,7,8 or 9"];
    }
    else if ([[self.emailIdTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.emailIdTextField : @"Email Address contains only white spaces"];
    }
    
    else if([self.emailIdTextField.text NSStringIsValidEmail:self.emailIdTextField.text] == false){
        [self giveAlert: self.emailIdTextField: @"Entered email address is not valid!!"];
    }
    else{
        // Register our parse app with the service
        [Parse setApplicationId:@"Wqip6okW5ZL4bn4IikxII9bbk12DS5KVarCkGr8Q"
                      clientKey:@"ef2zLzF6jTT3Ahq9tOyf1Gt2mKcabL90bdxo4npe"];
        
        PFObject *customer1 = [PFObject objectWithClassName:@"Customers"];
        
        [customer1 setObject: [NSNumber numberWithInteger: [self.mobileNumberTextField.text integerValue]] forKey:@"custid"];
        [customer1 setObject:self.firstNameTextField.text forKey:@"firstname"];
        [customer1 setObject:self.lastNameTextField.text forKey:@"lastname"];
        [customer1 setObject:[NSNumber numberWithInteger: [self.mobileNumberTextField.text integerValue]] forKey:@"mobilenumber"];
        [customer1 setObject:self.emailIdTextField.text forKey:@"emailid"];
        [customer1 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded){
                NSLog(@"Object Uploaded!");
            }
            else{
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                NSLog(@"Error: %@", errorString);
            }
        }];
        if( self.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer == nil){
            self.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer = [[Customer alloc]init];
        }
        self.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.custid = [NSNumber numberWithInteger: [self.mobileNumberTextField.text integerValue]];
        self.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.mobilenumber = [NSNumber numberWithInteger: [self.mobileNumberTextField.text integerValue]];
        self.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.firstname = self.firstNameTextField.text;
        self.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.lastname = self.lastNameTextField.text;
        self.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.emailid = self.emailIdTextField.text;
        NSLog(@"MY FIRST: %@",self.myCartViewController.selectQuantityViewController.listItemViewController.viewController.customer.firstname);
        [self performSegueWithIdentifier:@"selectPaymentOption" sender:sender];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"selectPaymentOption"]) {
        self.selectPaymentMethodViewController = segue.destinationViewController;
        selectPaymentMethodViewController.customerDetailsViewController = self;
        self.selectPaymentMethodViewController.total = self.total;
        self.selectPaymentMethodViewController.myFlag = @1.0;
        self.selectPaymentMethodViewController.customer = self.customer;
        self.selectPaymentMethodViewController.title = @"Payment Options";
    }
    else if([[segue identifier] isEqualToString:@"segueToLoginVC"]) {
        self.loginViewController = segue.destinationViewController;
        loginViewController.customerDetailsViewController = self;
        self.loginViewController.total = self.total;
        self.loginViewController.customer = self.customer;
        self.loginViewController.title = @"Customer Login";
        
    }
    CATransition *transition =[CATransition animation];
    transition.duration = 0.3f;
    transition.type=kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
}
@end
