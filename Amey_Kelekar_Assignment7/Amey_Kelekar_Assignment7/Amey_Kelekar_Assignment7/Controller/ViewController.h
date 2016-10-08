//
//  ViewController.h
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/23/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hospital.h"
@class ListPatientViewController;

@interface ViewController : UIViewController{
    IBOutlet UIButton *listPatientButton;
    IBOutlet UIButton *exitApplicationButton;
}

@property (retain, nonatomic) IBOutlet UIButton *listPatientButton;
@property (retain, nonatomic) IBOutlet UIButton *exitApplicationButton;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) ListPatientViewController *listPatientViewController;
@property (strong, nonatomic) Hospital *hospital;

- (IBAction)onListPatientButtonClicked:(id)sender;
- (IBAction)onExitButtonClicked:(id)sender;

@end
