//
//  MyOrderViewController.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import "MyOrderViewController.h"
#import <Parse/Parse.h>
@interface MyOrderViewController()

@end

@implementation MyOrderViewController

@synthesize myOrderTableView;
@synthesize customer;
@synthesize myDetailsViewController;
@synthesize orderList;


//- (id)initWithCoder:(NSCoder *)aDecoder{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        self.parseClassName = @"Order_Details";
//        self.pullToRefreshEnabled = YES;
//        self.paginationEnabled = NO;
//    }
//    return self;
//}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        //custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    // Return the number of rows in the section.
//    return [self.orderList count];
//}



- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[self.myOrderTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    NSString *displayDetails = [[object objectForKey:@"productName"]stringByAppendingString: @"   "];
    NSString *displayDetails1 = [displayDetails stringByAppendingString: [[object objectForKey:@"size"] stringValue]];
    NSString *displayDetails2= [displayDetails1 stringByAppendingString: @" lb   "];
    NSString *finalDisplayDetails = [displayDetails2 stringByAppendingString:[[object objectForKey:@"quantity"] stringValue]];
    cell.textLabel.text = finalDisplayDetails;
    cell.detailTextLabel.text = [@"$ " stringByAppendingString: [[object objectForKey:@"actualprice"] stringValue]];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    PFObject *object =[self.objects objectAtIndex:indexPath.row];
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.myOrderTableView reloadData];
    }];
}

-(PFQuery *)queryForTable{
    PFQuery *retrieveEvents = [PFQuery queryWithClassName:@"Order_Details"];
    [retrieveEvents whereKey:@"custid" equalTo:self.customer.custid];
    return retrieveEvents;
}

@end

