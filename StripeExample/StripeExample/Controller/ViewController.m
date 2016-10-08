//
//  ViewController.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import "ViewController.h"
#import "ListItemViewController.h"
#import "MyDetailsViewController.h"
#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "Product.h"
#import "Customer.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize cakeImageView;
@synthesize sweetImageView;
@synthesize shopCakesButton;
@synthesize shopSweetsButton;
@synthesize footerLabel;
@synthesize listItemViewController;
@synthesize myDetailsViewController;
@synthesize loginViewController;
@synthesize prodList;
@synthesize productList;
@synthesize customer;
@synthesize cartButton;
@synthesize menuButton;
@synthesize myArray;
@synthesize total;

int count = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    UIBarButtonItem *cartButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cart_new.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    //    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hdpiwhite.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    // NSArray *myButtonArray =[[NSArray alloc]initWithObjects:menuButton,cartButton, nil];
    // [[self navigationItem] setRightBarButtonItems:myButtonArray];
    // NSMutableArray *array = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Key"] mutableCopy];
    if(myArray == nil){
        myArray = [[NSMutableArray alloc]init];
    }
    if(total == nil){
        total = [[NSNumber alloc]initWithDouble:0.0];
    }
    
    NSUInteger numObjects = [myArray count];
    NSString *inStr = [NSString stringWithFormat: @"%lu", numObjects];
    UIImage *cartImage = [UIImage imageNamed:@"cart_new.png"];
    UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setImage:cartImage forState:UIControlStateNormal];
    [customButton setTitle:inStr forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [customButton sizeToFit];
    cartButton= [[UIBarButtonItem alloc] initWithCustomView:customButton];
    menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hdpiwhite.png"] style:UIBarButtonItemStylePlain target:self action:@selector(myDetails:)];
    NSArray *myButtonArray =[[NSArray alloc]initWithObjects:menuButton,cartButton, nil];
    [[self navigationItem] setRightBarButtonItems:myButtonArray];
    
    cakeImageView.image = [UIImage imageNamed:@"shopcakesmall.png"];
    sweetImageView.image = [UIImage imageNamed:@"shopsweetssmall.png"];
    shopCakesButton.layer.cornerRadius = 10; // this value vary as per your desire
    shopCakesButton.clipsToBounds = YES;
    shopSweetsButton.layer.cornerRadius = 10; // this value vary as per your desire
    shopSweetsButton.clipsToBounds = YES;
    
    footerLabel.lineBreakMode = NSLineBreakByWordWrapping;
    footerLabel.numberOfLines = 0;
    self.productList = [ProductList sharedProductList];
    // Register our parse app with the service
    [Parse setApplicationId:@"Wqip6okW5ZL4bn4IikxII9bbk12DS5KVarCkGr8Q"
                  clientKey:@"ef2zLzF6jTT3Ahq9tOyf1Gt2mKcabL90bdxo4npe"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];
    //[query whereKey:@"Category" equalTo:@"Cake"];//2
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {//4
        if (!error) {
            NSLog(@"Successfully retrieved: %@", objects);
            NSMutableArray<Product *> *pList =[[NSMutableArray alloc]init];
            for (PFObject *p in objects) {
                Product *prod = [[Product alloc]init];
                prod.productName  = [p valueForKey:@"name"];
                prod.productId = [p valueForKey:@"ID"];
                prod.productPrice = [p valueForKey:@"Price"];
                prod.productCategory = [p valueForKey:@"Category"];
                PFFile *imageFile = [p objectForKey:@"DisplayImage"];
                [imageFile getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
                    if (!error) {
                        prod.displayImage = UIImagePNGRepresentation([UIImage imageWithData:result]);
                        
                    }
                }];
                [pList addObject:prod];
            }
            self.productList = (ProductList *)pList;
            self.prodList = pList;
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
    }];
}

-(void) viewDidAppear:(BOOL)animated{
    NSArray *myButtonArray =[[NSArray alloc]initWithObjects:self.menuButton,self.cartButton, nil];
    [[self navigationItem] setRightBarButtonItems:myButtonArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchRespectiveProducts : (NSString *) categories{
    NSMutableArray * array = [NSMutableArray array];
    for (Product *p in self.prodList){
        if ([[p productCategory] isEqualToString:categories]){
            [array addObject:p];
        }
    }
    NSLog(@"Filtered list for %@ is %@",categories,array);
    self.productList = (ProductList *)array;
}



- (IBAction)onShopCakesButtonClicked:(id)sender {
    count = 1;
    [self fetchRespectiveProducts:@"Cake"];
    [self performSegueWithIdentifier:@"segueToListItemVC" sender:sender];
}

- (IBAction)onShopSweetsButtonClicked:(id)sender {
    count = 2;
    [self fetchRespectiveProducts:@"Sweet"];
    [self performSegueWithIdentifier:@"segueToListItemVC" sender:sender];
}

- (void) myDetails: (UIButton *) button{
    NSString *data;
    NSLog(@"customer is: %@", customer);
    if (customer == nil){
        data = @"segueToLoginPage";
    }
    else{
        data = @"segueToMyDetailsVC";
    }
    NSLog(@"Segue selected is: %@",data);
    [self performSegueWithIdentifier:data sender:button];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToListItemVC"]) {
        self.listItemViewController = segue.destinationViewController;
        if(count == 1){
            self.listItemViewController.title = @"List of Cakes";
        }
        else if( count == 2){
            self.listItemViewController.title = @"List of Sweets";
        }
        listItemViewController.viewController = self;
        self.listItemViewController.customer = self.customer;
    }
    else if ([[segue identifier] isEqualToString:@"segueToMyDetailsVC"]){
        self.myDetailsViewController = segue.destinationViewController;
        self.myDetailsViewController.title = @"My Details";
        myDetailsViewController.viewController = self;
        self.myDetailsViewController.customer = self.customer;
    }
    else if ([[segue identifier] isEqualToString:@"segueToLoginPage"]){
        self.loginViewController = segue.destinationViewController;
        self.loginViewController.title = @"Login Details";
        loginViewController.viewController = self;
        self.loginViewController.customer = self.customer;
        self.loginViewController.flag = @1.0;
    }
    CATransition *transition =[CATransition animation];
    transition.duration = 0.3f;
    transition.type=kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
}

@end
