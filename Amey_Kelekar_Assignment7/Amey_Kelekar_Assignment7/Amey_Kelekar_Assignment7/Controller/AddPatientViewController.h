//
//  AddPatientViewController.h
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/24/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+ReadString.h"
#import "ListPatientViewController.h"
#import "Patient_E+CoreDataProperties.h"

@interface AddPatientViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate>{
    IBOutlet UILabel *firstNameLabel;
    IBOutlet UILabel *lastNameLabel;
    IBOutlet UILabel *socialSecurityNumberLabel;
    IBOutlet UILabel *dateOfBirthLabel;
    IBOutlet UILabel *phoneNumberLabel;
    IBOutlet UILabel *primaryCarePhysicianLabel;
    IBOutlet UILabel *heartRateLabel;
    IBOutlet UILabel *respiratoryRateLabel;
    IBOutlet UILabel *bloodPressureLabel;
    IBOutlet UILabel *weightLabel;
    IBOutlet UILabel *streetNameLabel;
    IBOutlet UILabel *apartmentNumberLabel;
    IBOutlet UILabel *cityLabel;
    IBOutlet UILabel *stateLabel;
    IBOutlet UILabel *zipCodeLabel;
    
    IBOutlet UIButton *savePatientButton;
    
    IBOutlet UITextField *firstNameTextField;
    IBOutlet UITextField *lastNameTextField;
    IBOutlet UITextField *ssnTextField;
    IBOutlet UITextField *dobTextField;
    IBOutlet UITextField *phoneTextField;
    IBOutlet UITextField *pcpTextField;
    IBOutlet UITextField *heartRateTextField;
    IBOutlet UITextField *respRateTextField;
    IBOutlet UITextField *bloodPressureTextField;
    IBOutlet UITextField *weightTextField;
    IBOutlet UITextField *streetNameTextField;
    IBOutlet UITextField *apartmentNumberTextField;
    IBOutlet UITextField *cityTextField;
    IBOutlet UITextField *stateTextField;
    IBOutlet UITextField *zipCodeNumberTextField;
    IBOutlet UIBarButtonItem *editPatientButton;
    
    IBOutlet UIImageView *patientImageView;
    
    NSString *string ;
    ListPatientViewController *listPatientViewController;
}

@property (retain, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *lastNameLabel;;
@property (retain, nonatomic) IBOutlet UILabel *socialSecurityNumberLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (retain, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (retain, nonatomic) IBOutlet UILabel *primaryCarePhysicianLabel;
@property (retain, nonatomic) IBOutlet UILabel *respiratoryRateLabel;
@property (retain, nonatomic) IBOutlet UILabel *heartRateLabel;
@property (retain, nonatomic) IBOutlet UILabel *bloodPressureLabel;
@property (retain, nonatomic) IBOutlet UILabel *weightLabel;
@property (retain, nonatomic) IBOutlet UILabel *streetNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *apartmentNumberLabel;
@property (retain, nonatomic) IBOutlet UILabel *cityLabel;
@property (retain, nonatomic) IBOutlet UILabel *stateLabel;
@property (retain, nonatomic) IBOutlet UILabel *zipCodeLabel;

@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *ssnTextField;
@property (strong, nonatomic) IBOutlet UITextField *dobTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *pcpTextField;
@property (strong, nonatomic) IBOutlet UITextField *respRateTextField;
@property (strong, nonatomic) IBOutlet UITextField *heartRateTextField;
@property (strong, nonatomic) IBOutlet UITextField *bloodPressureTextField;
@property (strong, nonatomic) IBOutlet UITextField *weightTextField;
@property (strong, nonatomic) IBOutlet UITextField *streetNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *apartmentNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) IBOutlet UITextField *stateTextField;
@property (strong, nonatomic) IBOutlet UITextField *zipCodeNumberTextField;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *editPatientButton;
@property (strong, nonatomic) IBOutlet UIButton *savePatientButton;
@property (strong, nonatomic) IBOutlet UIImageView *patientImageView;
@property (nonatomic, assign) id currentResponder;
@property (strong, nonatomic) UIImage *selectedImage;
@property (strong,nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSString *string;
@property (strong, nonatomic) ListPatientViewController *listPatientViewController;
@property (strong, nonatomic) Patient_E *inputPatient;


- (IBAction)onSaveButtonClicked:(id)sender;
- (IBAction)onEditButtonClicked:(id)sender;
- (IBAction)onPatientImageClicked:(id)sender;

@end
