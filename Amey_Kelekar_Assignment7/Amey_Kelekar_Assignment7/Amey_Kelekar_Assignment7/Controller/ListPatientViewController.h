//
//  ListPatientViewController.h
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/24/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Patient.h"
@class AddPatientViewController;

@interface ListPatientViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    NSMutableArray *allItems;
    NSMutableArray *displayItems;
    IBOutlet UITableView *patientTableView;
    IBOutlet UISearchBar *patientSearchBar;
    ViewController *viewController;
    Patient *patient;
}

@property (retain, nonatomic) IBOutlet UITableView *patientTableView;
@property (retain, nonatomic) IBOutlet UISearchBar *patientSearchBar;
@property (strong, nonatomic) AddPatientViewController *addPatientViewController;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) Patient *patient;

@end