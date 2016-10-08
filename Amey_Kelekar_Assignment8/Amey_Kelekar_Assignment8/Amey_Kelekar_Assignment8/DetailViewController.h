//
//  DetailViewController.h
//  Amey_Kelekar_Assignment8
//
//  Created by Amey Kelekar on 4/9/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GitHubIssueTracker.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentsLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentsURLLabel;
@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet UILabel *loginLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *createdAtLabel;

@property (strong, nonatomic) IBOutlet UITextView *titleTextview;
@property (strong, nonatomic) IBOutlet UITextView *bodyTextView;
@property (strong, nonatomic) IBOutlet UITextField *commentsTextField;
@property (strong, nonatomic) IBOutlet UITextView *commentsURLTextView;
@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *stateTextField;
@property (strong, nonatomic) IBOutlet UITextField *createdAtTextField;

@property (strong, nonatomic) GitHubIssueTracker *currentIssue;

- (void) getCurrentIssue: (id) gitHubIssueObject;
- (void) setValues;

@end

