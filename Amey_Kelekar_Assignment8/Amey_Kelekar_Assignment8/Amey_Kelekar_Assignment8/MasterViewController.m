//
//  MasterViewController.m
//  Amey_Kelekar_Assignment8
//
//  Created by Amey Kelekar on 4/9/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "GitHubIssueTracker.h"

#define getDataURL @"https://api.github.com/repos/rails/rails/issues?state=all"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

@synthesize issueDetailTableView, jsonArray, githubIssueTrackerArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    self.title = @"List of issues";
    [self retrieveData];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = self.objects[indexPath.row];
        GitHubIssueTracker *object = [githubIssueTrackerArray objectAtIndex:indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        //[controller setDetailItem:object];
        [controller getCurrentIssue:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.objects.count;
    return githubIssueTrackerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//
//    NSDate *object = self.objects[indexPath.row];
//    cell.textLabel.text = [object description];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[self.issueDetailTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    CGRect rect =CGRectMake(5,5,40,40);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [[UIImage alloc]init];
    UIImage *uiImage = [[UIImage alloc] init];
    uiImage = [imageView image];
    [[cell imageView] setImage:uiImage];
    
    //Configure the cell...
    GitHubIssueTracker *gitHubIssueTrackerObject;
    gitHubIssueTrackerObject = [githubIssueTrackerArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [gitHubIssueTrackerObject.number stringValue];
    if([gitHubIssueTrackerObject.state caseInsensitiveCompare:@"open"] == NSOrderedSame )
        cell.imageView.image = [UIImage imageNamed:@"open.png"];
    else
        cell.imageView.image = [UIImage imageNamed:@"closed.png"];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.detailTextLabel.text = gitHubIssueTrackerObject.title;
    
    //Accessory
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(void) retrieveData{
    NSURL *url = [NSURL URLWithString:getDataURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //Set up our github issue Tracker Array
    githubIssueTrackerArray = [[NSMutableArray alloc]init];
    
    //Loop through our jsonArray
    for(int i=0; i < jsonArray.count; i++){
        //Create GitHubIssueTracker Object
        NSString *issueIitle =[[jsonArray objectAtIndex:i] objectForKey:@"title"];
        NSString *issueBody = [[jsonArray objectAtIndex:i] objectForKey:@"body"];
        NSNumber *issueComments = [[jsonArray objectAtIndex:i] objectForKey:@"comments"];
        NSString *issueComments_url = [[jsonArray objectAtIndex:i] objectForKey:@"html_url"];
        NSNumber *issueUser = [[jsonArray objectAtIndex:i] valueForKeyPath:@"user.id"];
        NSString *issueLogin = [[jsonArray objectAtIndex:i] valueForKeyPath:@"user.login"];
        NSString *issueState = [[jsonArray objectAtIndex:i] objectForKey:@"state"];
        NSNumber *issueNumber = [[jsonArray objectAtIndex:i] objectForKey:@"number"];
        NSString *issueCreatedAt = [[jsonArray objectAtIndex:i] objectForKey:@"created_at"];
        
        NSDateFormatter *nsDateFormatter = [[NSDateFormatter alloc] init];
        [nsDateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [nsDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSDate *createdDate = [nsDateFormatter dateFromString:issueCreatedAt];

        
        //Add the GitHubIssueTracker Object to our githubIssueTrackerArray
        [githubIssueTrackerArray addObject:[[GitHubIssueTracker alloc]initWithTitle:issueIitle andBody:issueBody andComments:issueComments andCommentsURL:issueComments_url andUser:issueUser andLogin:issueLogin andState:issueState andNumber:issueNumber andCreatedAt:createdDate]];
        
    }
    
    [self.issueDetailTableView reloadData];
}

@end
