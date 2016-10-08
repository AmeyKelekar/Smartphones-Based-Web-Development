//
//  ListItemViewController.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import "ListItemViewController.h"
#import "SelectQuantityViewController.h"
//#import "MyCartViewController.h"
#import "Product.h"

@interface ListItemViewController ()

@end

@implementation ListItemViewController

@synthesize listItemTableView;
@synthesize listItemSearchBar;
@synthesize viewController;
@synthesize product;
@synthesize selectQuantityViewController;
//@synthesize myCartViewContoller;
@synthesize customer;

int count1 = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    //    NSUInteger numObjects = [self.viewController.myArray count];
    //    NSString *inStr = [NSString stringWithFormat: @"%lu", numObjects];
    //    UIImage *cartImage = [UIImage imageNamed:@"cart_new.png"];
    //    UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [customButton setImage:cartImage forState:UIControlStateNormal];
    //    [customButton setTitle:inStr forState:UIControlStateNormal];
    //    [customButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //    [customButton sizeToFit];
    //    self.viewController.cartButton= [[UIBarButtonItem alloc] initWithCustomView:customButton];
    //    [customButton addTarget:self action: @selector(proceedToCheckout:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *myButtonArray =[[NSArray alloc]initWithObjects:self.viewController.menuButton,self.viewController.cartButton, nil];
    [[self navigationItem] setRightBarButtonItems:myButtonArray];
    
    allItems = self.viewController.productList;
    displayItems = [[NSMutableArray alloc] initWithArray:allItems];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name: UIKeyboardDidShowNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name: UIKeyboardWillHideNotification object: nil];
    self.listItemTableView.allowsMultipleSelectionDuringEditing = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) keyboardShown:(NSNotification *)note{
    CGRect keyboardFrame;
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardFrame];
    CGRect tableViewFrame = listItemTableView.frame;
    tableViewFrame.size.height -= keyboardFrame.size.height;
    [listItemTableView setFrame:tableViewFrame];
    
}

-(void) viewDidAppear:(BOOL)animated{
    NSArray *myButtonArray =[[NSArray alloc]initWithObjects:self.viewController.menuButton,self.viewController.cartButton, nil];
    [[self navigationItem] setRightBarButtonItems:myButtonArray];
}

-(void) keyboardHidden:(NSNotification *)note{
    [listItemTableView setFrame:self.view.bounds];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [displayItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[self.listItemTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    NSLog(@"Cell is: %@", cell);
    CGRect rect =CGRectMake(5,5,40,40);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [[UIImage alloc]init];
    UIImage *uiImage = [[UIImage alloc] init];
    uiImage = [imageView image];
    [[cell imageView] setImage:uiImage];
    UIImage *bigImage = [UIImage imageWithData:[[displayItems objectAtIndex:indexPath.row] displayImage]];
    UIImage *thumb = [self makeThumbnailOfSize:CGSizeMake(50,50) sourceImage:bigImage];
    cell.imageView.image = thumb;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    Product *tempProduct = [displayItems objectAtIndex:indexPath.row];
    NSString *displayDetails = [tempProduct productName];
    NSString *priceDetails = [@"$" stringByAppendingString: [tempProduct.productPrice stringValue]];
    NSString *detailedTextLabel = [priceDetails stringByAppendingString:@"/lb"];
    
    cell.textLabel.text = displayDetails;
    cell.detailTextLabel.text = detailedTextLabel;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

//Method to create a thumbnail out of the main image to display in the table view
- (UIImage *) makeThumbnailOfSize:(CGSize)size sourceImage:(UIImage *)uiImg
{
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    // draw scaled image into thumbnail context
    [uiImg drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newThumbnail = UIGraphicsGetImageFromCurrentImageContext();
    // pop the context
    UIGraphicsEndImageContext();
    if(newThumbnail == nil)
        NSLog(@"could not scale image");
    return newThumbnail;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell is tapped");
    count1 = 1;
    Product *tempProduct = [displayItems objectAtIndex:indexPath.row];
    self.product = tempProduct;
    [self performSegueWithIdentifier:@"segueToSizeAndQuantity" sender:[listItemTableView cellForRowAtIndexPath:indexPath]];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0){
        [displayItems removeAllObjects];
        [displayItems addObjectsFromArray:allItems];
    }
    else{
        [displayItems removeAllObjects];
        for(Product *prod in allItems){
            NSString *prodName = [prod productName];
            NSRange r = [prodName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location != NSNotFound) {
                [displayItems addObject:prod];
            }
        }
    }
    [listItemTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [listItemSearchBar resignFirstResponder];
    [listItemTableView resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [displayItems removeAllObjects];
    [displayItems addObjectsFromArray:allItems];
    [listItemTableView reloadData];
}

//- (void) proceedToCheckout: (UIButton *) button{
//    [self performSegueWithIdentifier:@"segueToMyCartVC1" sender:button];
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToSizeAndQuantity"]) {
        self.selectQuantityViewController = segue.destinationViewController;
        
        [[segue destinationViewController] setInputProduct: self.product] ;
        
        selectQuantityViewController.listItemViewController = self;
        self.selectQuantityViewController.customer = self.customer;
    }
    //    if ([[segue identifier] isEqualToString:@"segueToMyCartVC1"]) {
    //        self.myCartViewContoller = segue.destinationViewController;
    //
    //        //  [[segue destinationViewController] setInputProduct: self.product] ;
    //
    //        myCartViewContoller.listItemViewController = self;
    //        self.myCartViewContoller.customer = self.customer;
    //
    //    }
    CATransition *transition =[CATransition animation];
    transition.duration = 0.3f;
    transition.type=kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // Navigation button was pressed. Do some stuff
        NSUInteger numObjects = [self.viewController.myArray count];
        NSString *inStr = [NSString stringWithFormat: @"%lu", numObjects];
        UIImage *cartImage = [UIImage imageNamed:@"cart_new.png"];
        UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customButton setImage:cartImage forState:UIControlStateNormal];
        [customButton setTitle:inStr forState:UIControlStateNormal];
        [customButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [customButton sizeToFit];
        self.viewController.cartButton= [[UIBarButtonItem alloc] initWithCustomView:customButton];
        
        NSArray *myButtonArray =[[NSArray alloc]initWithObjects:self.viewController.menuButton,self.viewController.cartButton, nil];
        [[self navigationItem] setRightBarButtonItems:myButtonArray];
    }
    NSLog(@"Amey here");
    [super viewWillDisappear:animated];
}

@end
