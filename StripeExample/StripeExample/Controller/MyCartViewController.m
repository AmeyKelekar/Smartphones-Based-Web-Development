//
//  MyCartViewController.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import "MyCartViewController.h"
#import "CustomerDetailsViewController.h"
#import "CCell.h"
@interface MyCartViewController ()

@end


@implementation MyCartViewController

@synthesize selectQuantityViewController;
@synthesize myOrderLabel;
@synthesize proceedToCheckoutButton;
@synthesize cartTableView;
@synthesize totalPriceLabel;
@synthesize totalPriceTextField;
@synthesize productOfCart;
@synthesize customerDetailsViewController;
//@synthesize listItemViewController;
@synthesize customer;

//- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self){
//        //custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.productOfCart = self.selectQuantityViewController.listItemViewController.viewController.myArray;
    NSLog(@"product cart is: %@",self.productOfCart);
    self.cartTableView.delegate = self;
    self.cartTableView.dataSource = self;
    self.cartTableView.allowsMultipleSelectionDuringEditing = NO;
    [self calculateTotal];
}

- (void) calculateTotal {
    NSNumber *total1 = [[NSNumber alloc] initWithDouble:0.0];
    for (OrderProduct *op in self.productOfCart) {
        total1 = [NSNumber numberWithFloat:([total1 doubleValue] + [op.productActualPrice doubleValue])];
    }
    self.totalPriceTextField.text = [total1 stringValue];
    self.totalPriceTextField.userInteractionEnabled = NO;
    self.selectQuantityViewController.listItemViewController.viewController.total = total1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productOfCart.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString *CellIdentifier = @"CartDetailsCell";
    static NSString *CellIdentifier = @"CCell";
    //    UITableViewCell *cell = [cartTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    NSLog(@"Cell is: %@", cell);
    //    if (!cell){
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    //    }
    //    UITableViewCell *cell = [[self.cartTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    //    OrderProduct *orderProduct = [productOfCart objectAtIndex:indexPath.row];
    //    NSString *displayDetails = [orderProduct.productName stringByAppendingString: @"   "];
    //    NSString *displayDetails1 = [displayDetails stringByAppendingString: [orderProduct.productQuantity stringValue]];
    //    NSString *displayDetails2= [displayDetails1 stringByAppendingString: @" lb   "];
    //    NSString *finalDisplayDetails = [displayDetails2 stringByAppendingString:[orderProduct.productItemCount stringValue]];
    //    cell.textLabel.text = finalDisplayDetails;
    //    cell.detailTextLabel.text = [@"$ " stringByAppendingString: [orderProduct.productActualPrice stringValue]];
    //
    //    return cell;
    
    CCell *customCell = (CCell *)[self.cartTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (customCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CCell" owner:self options:nil];
        customCell = [nib objectAtIndex:0];
    }
    OrderProduct *orderProduct = [productOfCart objectAtIndex:indexPath.row];
    NSString *productName = orderProduct.productName;
    NSString *productSize = [[orderProduct.productQuantity stringValue] stringByAppendingString:@" LB"];
    NSString *productQuantity = [orderProduct.productItemCount stringValue];
    NSString *actualPrice = [@"$" stringByAppendingString:[orderProduct.productActualPrice stringValue]];
    customCell.productNameLabel.text = productName;
    customCell.actualPrice.text = actualPrice;
    customCell.sizeLabel.text = productSize;
    customCell.quantityLabel.text = productQuantity;
    return customCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        OrderProduct *orderProd = [self.productOfCart objectAtIndex:indexPath.row];
        [self.productOfCart removeObjectAtIndex:indexPath.row];
        [self.selectQuantityViewController.listItemViewController.viewController.myArray removeObject:orderProd];
        [self.cartTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.cartTableView reloadData];
    }
    [self calculateTotal];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToUserRegistration"]) {
        self.customerDetailsViewController = segue.destinationViewController;
        customerDetailsViewController.myCartViewController = self;
        self.customerDetailsViewController.customer = self.customer;
        self.customerDetailsViewController.total = [NSNumber numberWithInteger: [self.totalPriceTextField.text integerValue]];
        self.customerDetailsViewController.title = @"My Info";
        CATransition *transition =[CATransition animation];
        transition.duration = 0.3f;
        transition.type=kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    }
}

- (void) giveErrorAlert : (NSString *) errorMessage{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error Message" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)onProceedToCheckoutButtonClicked:(id)sender {
    NSLog(@"Total Price: %@",self.selectQuantityViewController.listItemViewController.viewController.total);
    if([self.totalPriceTextField.text isEqual: @"0"] || [self.totalPriceTextField.text isEqual: @"0.0"]){
        [self giveErrorAlert:@"There's nothing to checkout in the cart!!!!"];
    }
    else
        [self performSegueWithIdentifier:@"segueToUserRegistration" sender:sender];
}
@end
