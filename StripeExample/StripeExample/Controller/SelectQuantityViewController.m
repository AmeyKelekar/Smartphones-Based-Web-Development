//
//  SelectQuantityViewController.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import "SelectQuantityViewController.h"
#import "MyCartViewController.h"
#import "OrderProductList.h"
#import "OrderProduct.h"
@interface SelectQuantityViewController ()

@end

@implementation SelectQuantityViewController
@synthesize productNameLabel;
@synthesize productPriceLabel;
@synthesize selectSizeLabel;
@synthesize selectQuantityLabel;
@synthesize productImageView;
@synthesize selectSizeButton;
@synthesize selectSizeTable;
@synthesize selectQuantityButton;
@synthesize selectQuantityTable;
@synthesize actualPriceLabel;
@synthesize actualPriceTextField;
@synthesize data;
@synthesize data1;
@synthesize addToCartButton;

@synthesize listItemViewController;
@synthesize myCartViewController;
@synthesize orderProductList;
@synthesize customer;
//@synthesize inputProduct;
NSNumber *size;
NSNumber *quantity;
double actualPrice;
//UIBarButtonItem *cartButton;
//UIBarButtonItem *menuButton;
//NSMutableArray *myArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUInteger numObjects = [self.listItemViewController.viewController.myArray count];
    NSString *inStr = [NSString stringWithFormat: @"%lu", numObjects];
    UIImage *cartImage = [UIImage imageNamed:@"cart_new.png"];
    UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setImage:cartImage forState:UIControlStateNormal];
    [customButton setTitle:inStr forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [customButton sizeToFit];
    self.listItemViewController.viewController.cartButton= [[UIBarButtonItem alloc] initWithCustomView:customButton];
    [customButton addTarget:self action: @selector(proceedToCheckout:) forControlEvents:UIControlEventTouchUpInside];
    NSArray *myButtonArray =[[NSArray alloc]initWithObjects:self.listItemViewController.viewController.menuButton,self.listItemViewController.viewController.cartButton, nil];
    [[self navigationItem] setRightBarButtonItems:myButtonArray];
    self.productNameLabel.text = self.listItemViewController.product.productName;
    NSString *priceDetails = [@"$" stringByAppendingString: [self.listItemViewController.product.productPrice stringValue]];
    NSString *detailedTextLabel = [priceDetails stringByAppendingString:@"/lb"];
    self.productPriceLabel.text = detailedTextLabel;
    [self.productImageView setImage:[UIImage imageWithData:self.listItemViewController.product.displayImage]];
    self.data = [[NSArray alloc]initWithObjects:@"1 lb", @"2 lb", @"3 lb", @"4 lb", @"5 lb", @"6 lb", @"7 lb", @"8 lb", @"9 lb", @"10 lb",nil];
    self.data1 = [[NSArray alloc]initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10",nil];
    
    self.selectSizeTable.delegate = self;
    self.selectSizeTable.dataSource = self;
    self.selectQuantityTable.delegate = self;
    self.selectQuantityTable.dataSource = self;
    
    self.actualPriceTextField.userInteractionEnabled = NO;
    self.actualPriceTextField.text = [self.listItemViewController.product.productPrice stringValue];
    actualPrice = [self.listItemViewController.product.productPrice doubleValue];
    size = [[NSNumber alloc] initWithInt:1];
    quantity = [[NSNumber alloc] initWithInt:1];
    self.orderProductList =[OrderProductList sharedOrderProductList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(tableView == self.selectSizeTable)
        return [self.data count];
    else
        return [self.data1 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == self.selectSizeTable){
        static NSString *CellIdentifier = @"SizeTableItem";
        UITableViewCell *cell = [selectSizeTable dequeueReusableCellWithIdentifier:CellIdentifier];
        NSLog(@"Cell is: %@", cell);
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"QuantityTableItem";
        UITableViewCell *cell = [selectQuantityTable dequeueReusableCellWithIdentifier:CellIdentifier];
        NSLog(@"Cell is: %@", cell);
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [self.data1 objectAtIndex:indexPath.row];
        return cell;
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    if(tableView == self.selectSizeTable){
        UITableViewCell * cell = [self.selectSizeTable cellForRowAtIndexPath:indexPath];
        [self.selectSizeButton setTitle: cell.textLabel.text forState:UIControlStateNormal];
        NSLog(@"Button value is %@",self.selectSizeButton.titleLabel.text);
        size = [f numberFromString:[cell.textLabel.text substringToIndex:2]];
        self.selectSizeTable.hidden = YES;
    }
    else{
        UITableViewCell * cell = [self.selectQuantityTable cellForRowAtIndexPath:indexPath];
        [self.selectQuantityButton setTitle: cell.textLabel.text forState:UIControlStateNormal];
        quantity = [f numberFromString: cell.textLabel.text];
        self.selectQuantityTable.hidden = YES;
    }
    
    NSNumber *price = self.listItemViewController.product.productPrice;
    actualPrice = [price doubleValue] * [quantity intValue] * [size intValue];
    NSNumber *myDoubleNumber = [NSNumber numberWithDouble:actualPrice];
    self.actualPriceTextField.text = [myDoubleNumber stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)selectSizeButtonAction:(id)sender {
    if (self.selectSizeTable.hidden == YES) {
        self.selectSizeTable.hidden = NO;
    }
    else{
        self.selectSizeTable.hidden = YES;
    }
}

- (IBAction)selectQuantityButonAction:(id)sender {
    if (self.selectQuantityTable.hidden == YES) {
        self.selectQuantityTable.hidden = NO;
    }
    else{
        self.selectQuantityTable.hidden = YES;
    }
}

- (IBAction)onAddToCartButtonClicked:(id)sender {
    OrderProduct *oProduct = [[OrderProduct alloc]init];
    oProduct.productName = self.listItemViewController.product.productName;
    oProduct.productId = self.listItemViewController.product.productId;
    oProduct.productCategory = self.listItemViewController.product.productCategory;
    oProduct.productPrice = self.listItemViewController.product.productPrice;
    oProduct.productQuantity = size;
    oProduct.productItemCount = quantity;
    oProduct.productActualPrice = [NSNumber numberWithDouble:actualPrice];
    [self.listItemViewController.viewController.myArray addObject:oProduct];
    NSLog(@"List of objects: %@",[self.listItemViewController.viewController.myArray objectAtIndex:0]);
    self.orderProductList = (OrderProductList *)self.listItemViewController.viewController.myArray;
    NSLog(@"Order Product Name is: %@", oProduct.productName);
    NSUInteger numObjects = [self.listItemViewController.viewController.myArray count];
    NSString *inStr = [NSString stringWithFormat: @"%lu", numObjects];
    UIImage *cartImage = [UIImage imageNamed:@"cart_new.png"];
    UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setImage:cartImage forState:UIControlStateNormal];
    [customButton setTitle:inStr forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [customButton sizeToFit];
    self.listItemViewController.viewController.cartButton= [[UIBarButtonItem alloc] initWithCustomView:customButton];
    
    NSArray *myButtonArray =[[NSArray alloc]initWithObjects:self.listItemViewController.viewController.menuButton,self.listItemViewController.viewController.cartButton, nil];
    [[self navigationItem] setRightBarButtonItems:myButtonArray];
    
    NSString *successMessage = [@"Product added to cart succesfully\n" stringByAppendingString: oProduct.productName];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success Message" message:successMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void) proceedToCheckout: (UIButton *) button{
    [self performSegueWithIdentifier:@"segueToMyCartVC" sender:button];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToMyCartVC"]) {
        self.myCartViewController = segue.destinationViewController;
        
        //  [[segue destinationViewController] setInputProduct: self.product] ;
        
        myCartViewController.selectQuantityViewController = self;
        self.myCartViewController.customer = self.customer;
        CATransition *transition =[CATransition animation];
        transition.duration = 0.3f;
        transition.type=kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        NSArray *myButtonArray =[[NSArray alloc]initWithObjects:self.listItemViewController.viewController.menuButton,self.listItemViewController.viewController.cartButton, nil];
        [[self navigationItem] setRightBarButtonItems:myButtonArray];
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSUInteger numObjects = [self.listItemViewController.viewController.myArray count];
    NSString *inStr = [NSString stringWithFormat: @"%lu", numObjects];
    UIImage *cartImage = [UIImage imageNamed:@"cart_new.png"];
    UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setImage:cartImage forState:UIControlStateNormal];
    [customButton setTitle:inStr forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [customButton sizeToFit];
    self.listItemViewController.viewController.cartButton= [[UIBarButtonItem alloc] initWithCustomView:customButton];
    [customButton addTarget:self action: @selector(proceedToCheckout:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *myButtonArray =[[NSArray alloc]initWithObjects:self.listItemViewController.viewController.menuButton,self.listItemViewController.viewController.cartButton, nil];
    [[self navigationItem] setRightBarButtonItems:myButtonArray];
}

@end
