//
//  MasterViewController.h
//  Amey_Kelekar_Assignment8
//
//  Created by Amey Kelekar on 4/9/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) IBOutlet UITableView *issueDetailTableView;
@property (strong, nonatomic) NSMutableArray *jsonArray;
@property (strong, nonatomic) NSMutableArray *githubIssueTrackerArray;

-(void) retrieveData;

@end

