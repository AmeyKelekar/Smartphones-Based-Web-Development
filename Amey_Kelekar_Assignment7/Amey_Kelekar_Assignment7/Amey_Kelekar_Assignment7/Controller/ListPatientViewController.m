//
//  ListPatientViewController.m
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/24/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import "ListPatientViewController.h"
#import "AddPatientViewController.h"
#import "Patient_E.h"
#define patientKey @"Name" 

@interface ListPatientViewController ()

@end

@implementation ListPatientViewController

@synthesize patientTableView;
@synthesize patientSearchBar;
@synthesize addPatientViewController;
@synthesize viewController;
@synthesize patient;

int count = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *addPatientButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPatientAction:)];
//    UIBarButtonItem *deletePatientButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deletePatientAction:)];
//    NSArray *myButtonArray =[[NSArray alloc]initWithObjects:addPatientButton,deletePatientButton, nil];
//    [[self navigationItem] setRightBarButtonItems:myButtonArray];
    [[self navigationItem] setRightBarButtonItem:addPatientButton];
    allItems = self.viewController.hospital.patientList;
    displayItems = [[NSMutableArray alloc] initWithArray:allItems];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name: UIKeyboardDidShowNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name: UIKeyboardWillHideNotification object: nil];
    self.patientTableView.allowsMultipleSelectionDuringEditing = NO;
}

-(void) keyboardShown:(NSNotification *)note{
    CGRect keyboardFrame;
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardFrame];
    CGRect tableViewFrame = patientTableView.frame;
    tableViewFrame.size.height -= keyboardFrame.size.height;
    [patientTableView setFrame:tableViewFrame];
    
}

-(void) keyboardHidden:(NSNotification *)note{
    [patientTableView setFrame:self.view.bounds];
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
    UITableViewCell *cell = [patientTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        CGRect rect =CGRectMake(5,5,40,40);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
        imageView.image = [[UIImage alloc]init];
        UIImage *uiImage = [[UIImage alloc] init];
        uiImage = [imageView image];
        [[cell imageView] setImage:uiImage];
    }
    if([[displayItems objectAtIndex:indexPath.row] displayImage] == nil){
        cell.imageView.image = [UIImage imageNamed:@"no_photo.jpeg"];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    else{
        cell.imageView.image = [UIImage imageWithData:[[displayItems objectAtIndex:indexPath.row] displayImage]];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    Patient *tempPatient = [displayItems objectAtIndex:indexPath.row];
    NSString *displayDetails = [tempPatient.firstName stringByAppendingString: @" "];
    NSString *finalDisplayDetails = [displayDetails stringByAppendingString: tempPatient.lastName];
    cell.textLabel.text = finalDisplayDetails;
    cell.detailTextLabel.text = tempPatient.address.city;
    
    return cell;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleDelete;
//}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self managedObjectContext];
        Patient_E *tempPatient = [displayItems objectAtIndex:indexPath.row];
        NSString *displayDetails = [tempPatient.firstName stringByAppendingString: @" "];
        NSString *patientFullName = [displayDetails stringByAppendingString: tempPatient.lastName];
    
        [context deleteObject:[displayItems objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Cannot delete the patient!!! %@ %@", error, [error localizedDescription]);
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error Message" message:[NSString stringWithFormat:@"Patient %@ cannot be deleted",patientFullName] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success Message" message:[NSString stringWithFormat:@"Patient %@ deleted successfully",patientFullName] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];

        Patient *p = [displayItems objectAtIndex:indexPath.row];
        [self.viewController.hospital.patientList removeObject:p];
        [displayItems removeObjectAtIndex:indexPath.row];
        [self.patientTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.patientTableView reloadData];
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell is tapped");
    count = 1;
    Patient *tempPatient = [displayItems objectAtIndex:indexPath.row];
    self.patient = tempPatient;
    [self performSegueWithIdentifier:@"segueToAddPatientVC" sender:[patientTableView cellForRowAtIndexPath:indexPath]];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0){
        [displayItems removeAllObjects];
        [displayItems addObjectsFromArray:allItems];
    }
    else{
        [displayItems removeAllObjects];
        for(Patient *pat in allItems){
            NSString *displayDetails = [pat.firstName stringByAppendingString: @" "];
            NSString *finalDisplayDetails = [displayDetails stringByAppendingString: pat.lastName];
            NSRange r = [finalDisplayDetails rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location != NSNotFound) {
                [displayItems addObject:pat];
            }
        }
    }
    [patientTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [patientSearchBar resignFirstResponder];
    [patientTableView resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [displayItems removeAllObjects];
    [displayItems addObjectsFromArray:allItems];
    [patientTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void) deletePatientAction: (UIButton *) button{
//    [patientTableView setEditing:YES animated:YES];
//}

- (void) addPatientAction: (UIButton *) button{
    [self performSegueWithIdentifier:@"segueToAddPatientVC" sender:button];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToAddPatientVC"]) {
        self.addPatientViewController = segue.destinationViewController;
        self.addPatientViewController.title = @"New Patient";
        if (count == 1){
            self.addPatientViewController.title = @"Complete Patient Details";
            [[segue destinationViewController] setInputPatient:(Patient_E *)self.patient] ;
        }
        addPatientViewController.listPatientViewController = self;
        CATransition *transition =[CATransition animation];
        transition.duration = 0.3f;
        transition.type=kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
