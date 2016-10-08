//
//  ViewController.m
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/23/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import "ViewController.h"
#import "ListPatientViewController.h"
#import "Hospital.h"
#import "Patient_E.h"
#import "Address.h"
#import "MedicalRecord_E.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize listPatientButton;
@synthesize exitApplicationButton;
@synthesize listPatientViewController;
@synthesize hospital;
@synthesize managedObjectContext;

//- (NSManagedObjectContext *)managedObjectContext
//{
//    NSManagedObjectContext *context = nil;
//    id delegate = [[UIApplication sharedApplication] delegate];
//    if ([delegate performSelector:@selector(managedObjectContext)]) {
//        context = [delegate managedObjectContext];
//    }
//    return context;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hospital = [Hospital sharedHospital];
    //self.hospital = [[Hospital alloc] initWithName:@"Boston Hospital"];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Patient_E" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.hospital.patientList = [[managedObjectContext executeFetchRequest:fetchRequest error:&error]mutableCopy];
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

- (IBAction)onListPatientButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"segueToListPatientVC" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToListPatientVC"]) {
        self.listPatientViewController = segue.destinationViewController;
        self.listPatientViewController.title = @"Patient List";
        listPatientViewController.viewController = self;
        CATransition *transition =[CATransition animation];
        transition.duration = 0.3f;
        transition.type=kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    }
}

- (IBAction)onExitButtonClicked:(id)sender {
    NSLog(@"Exiting application");
    exit(0);
}
@end
