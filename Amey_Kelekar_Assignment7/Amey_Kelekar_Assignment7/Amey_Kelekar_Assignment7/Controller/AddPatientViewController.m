//
//  AddPatientViewController.m
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/24/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import "AddPatientViewController.h"
#import "NSString+ReadString.h"
#import "ListPatientViewController.h"
#import <CoreData/CoreData.h>
#import "Patient_E+CoreDataProperties.h"
#import "Address_E+CoreDataProperties.h"
#import "MedicalRecord_E+CoreDataProperties.h"

@interface AddPatientViewController ()

@end

@implementation AddPatientViewController

@synthesize firstNameLabel;
@synthesize lastNameLabel;
@synthesize socialSecurityNumberLabel;
@synthesize dateOfBirthLabel;
@synthesize phoneNumberLabel;
@synthesize primaryCarePhysicianLabel;
@synthesize heartRateLabel;
@synthesize respiratoryRateLabel;
@synthesize bloodPressureLabel;
@synthesize weightLabel;
@synthesize streetNameLabel;
@synthesize apartmentNumberLabel;
@synthesize cityLabel;
@synthesize stateLabel;
@synthesize zipCodeLabel;
@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize ssnTextField;
@synthesize dobTextField;
@synthesize phoneTextField;
@synthesize pcpTextField;
@synthesize heartRateTextField;
@synthesize respRateTextField;
@synthesize bloodPressureTextField;
@synthesize weightTextField;
@synthesize streetNameTextField;
@synthesize apartmentNumberTextField;
@synthesize cityTextField;
@synthesize stateTextField;
@synthesize zipCodeNumberTextField;
@synthesize savePatientButton;
@synthesize patientImageView;
@synthesize selectedImage;
@synthesize imagePickerController;
@synthesize string;
@synthesize listPatientViewController;
@synthesize datePicker;
@synthesize currentResponder;
@synthesize editPatientButton;

double dValue;
int buttonFlag = 0;
Patient *currentPatient;

//NSCoreData BEGIN
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Image Gesture Recgnizer
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPatientImageClicked:)];
    singleTap.numberOfTapsRequired = 1;
    [self.patientImageView setUserInteractionEnabled:YES];
    [self.patientImageView addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *singleTapForTextField = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTapForTextField setNumberOfTapsRequired:1];
    [singleTapForTextField setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTapForTextField];
    
    //Date picker logic for date of birth
    self.datePicker = [[UIDatePicker alloc]init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    //setting maximium date to current date
    self.datePicker.maximumDate = [[NSDate alloc]init];
    [self.dobTextField setInputView:datePicker];
    [self.view addSubview:self.dobTextField];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(displayDate)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneButton, nil]];
    [self.dobTextField setInputAccessoryView:toolBar];
    
    //Setting Photo in the profile section by Default
    self.patientImageView.image = [UIImage imageNamed:@"no_image.jpeg"];
    
    self.string =[[NSString alloc]init];
    NSDateFormatter *nsDateFormatter = [[NSDateFormatter alloc] init];
    [nsDateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSLog(@"Patient entity is: %@",self.inputPatient);
    
    if(self.inputPatient != nil){
        self.firstNameTextField.text= self.listPatientViewController.patient.firstName;
        self.lastNameTextField.text = self.listPatientViewController.patient.lastName;
        self.ssnTextField.text= [self.listPatientViewController.patient.socialSecurityNumber stringValue];
        NSString *stringFromDate = [nsDateFormatter stringFromDate:self.listPatientViewController.patient.dateOfBirth];
        self.dobTextField.text = stringFromDate;
        self.phoneTextField.text = [self.listPatientViewController.patient.telephoneNumber stringValue];
        self.pcpTextField.text = self.listPatientViewController.patient.primaryCarePhysician;
        self.heartRateTextField.text = [self.listPatientViewController.patient.medicalRecord.respiratoryRate stringValue];
        self.respRateTextField.text = [self.listPatientViewController.patient.medicalRecord.heartRate stringValue];
        self.bloodPressureTextField.text = [self.listPatientViewController.patient.medicalRecord.systolicBloodPressure stringValue];
        self.weightTextField.text = [self.listPatientViewController.patient.medicalRecord.weight stringValue];
        self.streetNameTextField.text = self.listPatientViewController.patient.address.streetName;
        self.apartmentNumberTextField.text = [self.listPatientViewController.patient.address.apartmentNumber stringValue];
        self.cityTextField.text = self.listPatientViewController.patient.address.city;
        self.stateTextField.text = self.listPatientViewController.patient.address.state;
        self.zipCodeNumberTextField.text = self.listPatientViewController.patient.address.zipCode;
        [self.patientImageView setImage:[UIImage imageWithData:self.listPatientViewController.patient.displayImage]];
        
        //disabling the fields
        self.firstNameTextField.userInteractionEnabled = NO;
        self.lastNameTextField.userInteractionEnabled = NO;
        self.ssnTextField.userInteractionEnabled = NO;
        self.dobTextField.userInteractionEnabled = NO;
        self.phoneTextField.userInteractionEnabled = NO;
        self.pcpTextField.userInteractionEnabled = NO;
        self.heartRateTextField.userInteractionEnabled = NO;
        self.respRateTextField.userInteractionEnabled = NO;
        self.bloodPressureTextField.userInteractionEnabled = NO;
        self.weightTextField.userInteractionEnabled = NO;
        self.streetNameTextField.userInteractionEnabled = NO;
        self.apartmentNumberTextField.userInteractionEnabled = NO;
        self.cityTextField.userInteractionEnabled = NO;
        self.stateTextField.userInteractionEnabled = NO;
        self.zipCodeNumberTextField.userInteractionEnabled = NO;
        self.patientImageView.userInteractionEnabled = NO;
        
        self.savePatientButton.hidden = TRUE;
        currentPatient = self.listPatientViewController.patient;
        self.listPatientViewController.patient = nil;
    }
    else{
        //hidding right bar button
        self.navigationItem.rightBarButtonItem = nil;
    }
    //setting delegate to self i.e current view controller for all text field
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.ssnTextField.delegate = self;
    self.dobTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.pcpTextField.delegate = self;
    self.heartRateTextField.delegate = self;
    self.respRateTextField.delegate = self;
    self.bloodPressureTextField.delegate = self;
    self.weightTextField.delegate = self;
    self.streetNameTextField.delegate = self;
    self.apartmentNumberTextField.delegate = self;
    self.cityTextField.delegate = self;
    self.stateTextField.delegate = self;
    self.zipCodeNumberTextField.delegate = self;
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

- (IBAction)onSaveButtonClicked:(id)sender {
    //Checking whether string contains only whitespace.
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    //UIBarButtonItem *oldButton = self.navigationItem.rightBarButtonItem;
    
    if ([[self.firstNameTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.firstNameTextField : @"First name contains only white spaces"];
    }
    
    else if ([[self.lastNameTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.lastNameTextField : @"Last name contains only white spaces"];
    }
    
    else if ([[self.ssnTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.ssnTextField : @"Social Security number contains only white spaces"];
    }
    
    
    else if([self.ssnTextField.text validateSSN:self.ssnTextField.text] == false){
        [self giveAlert: self.ssnTextField: @"Entered ssn should be 9 digits"];
    }
    
    else if ([[self.dobTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.dobTextField : @"Date of Birth contains only white spaces"];
    }
    
    else if([self.dobTextField.text validateDate:self.dobTextField.text] == NULL){
        [self giveAlert: self.dobTextField: @"Entered date doesn't match the date format"];
    }
    
    else if ([[self.phoneTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.phoneTextField : @"Phone number contains only white spaces"];
    }
    
    else if([self.phoneTextField.text validatePhoneNumber:self.phoneTextField.text] == false){
        [self giveAlert: self.phoneTextField: @"Entered phone number should be minimum 7 digits, maximum 10 digits and the first digit must be 1,2,3,4,5,6,7,8 or 9"];
    }
    
    else if ([[self.pcpTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.pcpTextField : @"Primary Care Physician contains only white spaces"];
    }
    
    else if ([[self.respRateTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.respRateTextField : @"Respiratory Rate contains only white spaces"];
    }
    
    else if (self.respRateTextField.text.length > 0 && !([[NSScanner scannerWithString:self.respRateTextField.text] scanDouble:&dValue])) {
        [self giveAlert: self.respRateTextField : @"Only numerical values are accepted"];
    }
    
    else if ([[self.heartRateTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.heartRateTextField : @"Heart Rate contains only white spaces"];
    }
    
    else if (self.heartRateTextField.text.length > 0 && !([[NSScanner scannerWithString:self.heartRateTextField.text] scanDouble:&dValue])) {
        [self giveAlert: self.heartRateTextField : @"Only numerical values are accepted"];
    }
    
    else if ([[self.bloodPressureTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.bloodPressureTextField : @"Systolic Blood Pressure contains only white spaces"];
    }
    
    else if (self.bloodPressureTextField.text.length > 0 && !([[NSScanner scannerWithString:self.bloodPressureTextField.text] scanDouble:&dValue])) {
        [self giveAlert: self.bloodPressureTextField : @"Only numerical values are accepted"];
    }
    
    else if ([[self.weightTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.weightTextField : @"Weight contains only white spaces"];
    }
    
    else if (self.weightTextField.text.length > 0 && !([[NSScanner scannerWithString:self.weightTextField.text] scanDouble:&dValue])) {
        [self giveAlert: self.weightTextField : @"Only numerical values are accepted"];
    }
    
    else if ([[self.streetNameTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.streetNameTextField : @"Street name contains only white spaces"];
    }
    
    else if ([[self.apartmentNumberTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.apartmentNumberTextField : @"Apartment number contains only white spaces"];
    }
    
    else if (self.apartmentNumberTextField.text.length > 0 && !([[NSScanner scannerWithString:self.apartmentNumberTextField.text] scanDouble:&dValue])) {
        [self giveAlert: self.apartmentNumberTextField : @"Only numerical values are accepted"];
    }
    
    else if ([[self.cityTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.cityTextField : @"City name contains only white spaces"];
    }
    
    else if ([[self.stateTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.stateTextField :@"State name contains only white spaces"];
    }
    
    else if ([[self.zipCodeNumberTextField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        [self giveAlert: self.stateTextField :@"Zip Code contains only white spaces"];
    }
    
    else if([self.zipCodeNumberTextField.text validateZipCode:self.zipCodeNumberTextField.text] == false){
        [self giveAlert: self.zipCodeNumberTextField: @"Entered zip code should be minimum 5 digits and maximum 6 digits"];
    }
    
    else{
        NSManagedObjectContext *context = [self managedObjectContext];
        NSLog(@"After add button clicked current patient object is: %@ /n",currentPatient);
        Patient_E *patientInfo;
        Address_E *addressInfo;
        MedicalRecord_E *medicalRecordInfo;
        if (self.inputPatient == nil) {
            patientInfo = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Patient_E"
                                  inManagedObjectContext:context];
            addressInfo = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Address_E"
                                  inManagedObjectContext:context];
            medicalRecordInfo = [NSEntityDescription
                                              insertNewObjectForEntityForName:@"MedicalRecord_E"
                                              inManagedObjectContext:context];
            self.listPatientViewController.patient = [self.listPatientViewController.viewController.hospital createPatient];
        }
        else{
            patientInfo = self.inputPatient;
            addressInfo =  self.inputPatient.address;
            medicalRecordInfo = self.inputPatient.medicalRecord;
            self.listPatientViewController.patient = currentPatient;
        }
        BOOL successFlag = YES;
        
        
        self.listPatientViewController.patient.firstName = [self.firstNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        self.listPatientViewController.patient.lastName = [self.lastNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        self.listPatientViewController.patient.socialSecurityNumber = [NSNumber numberWithInteger: [self.ssnTextField.text integerValue]];
        self.listPatientViewController.patient.dateOfBirth = [self.dobTextField.text validateDate: self.dobTextField.text] ;
        self.listPatientViewController.patient.telephoneNumber = [NSNumber numberWithInteger: [self.phoneTextField.text integerValue]];
        self.listPatientViewController.patient.primaryCarePhysician = [self.pcpTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        self.listPatientViewController.patient.medicalRecord.respiratoryRate = [NSNumber numberWithDouble: [self.respRateTextField.text  doubleValue]];
        self.listPatientViewController.patient.medicalRecord.heartRate = [NSNumber numberWithDouble: [self.heartRateTextField.text doubleValue]];
        self.listPatientViewController.patient.medicalRecord.systolicBloodPressure = [NSNumber numberWithDouble: [self.bloodPressureTextField.text doubleValue]];
        self.listPatientViewController.patient.medicalRecord.weight = [NSNumber numberWithDouble: [self.weightTextField.text doubleValue]];
        self.listPatientViewController.patient.medicalRecord.timeStamp = [[NSDate alloc]init];
        self.listPatientViewController.patient.address.streetName = [self.streetNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        self.listPatientViewController.patient.address.apartmentNumber = [NSNumber numberWithInteger: [self.apartmentNumberTextField.text integerValue]];
        self.listPatientViewController.patient.address.city = [self.cityTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
        self.listPatientViewController.patient.address.state = [self.stateTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        self.listPatientViewController.patient.address.zipCode = [self.zipCodeNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        self.listPatientViewController.patient.displayImage = UIImageJPEGRepresentation([self.patientImageView image],1.0);
        
        patientInfo.firstName = self.listPatientViewController.patient.firstName;
        patientInfo.lastName = self.listPatientViewController.patient.lastName;
        patientInfo.socialSecurityNumber = self.listPatientViewController.patient.socialSecurityNumber;
        patientInfo.dateOfBirth = self.listPatientViewController.patient.dateOfBirth;
        patientInfo.telephoneNumber = self.listPatientViewController.patient.telephoneNumber;
        patientInfo.primaryCarePhysician = self.listPatientViewController.patient.primaryCarePhysician;
        patientInfo.displayImage = self.listPatientViewController.patient.displayImage;
        medicalRecordInfo.heartRate = self.listPatientViewController.patient.medicalRecord.heartRate;
        medicalRecordInfo.respiratoryRate = self.listPatientViewController.patient.medicalRecord.respiratoryRate;
        medicalRecordInfo.systolicBloodPressure = self.listPatientViewController.patient.medicalRecord.systolicBloodPressure;
        medicalRecordInfo.weight = self.listPatientViewController.patient.medicalRecord.weight;
        medicalRecordInfo.timeStamp = self.listPatientViewController.patient.medicalRecord.timeStamp;
        addressInfo.streetName = self.listPatientViewController.patient.address.streetName;
        addressInfo.apartmentNumber = self.listPatientViewController.patient.address.apartmentNumber;
        addressInfo.city =  self.listPatientViewController.patient.address.city;
        addressInfo.state = self.listPatientViewController.patient.address.state;
        addressInfo.zipCode = self.listPatientViewController.patient.address.zipCode;
        
        patientInfo.address = addressInfo;
        patientInfo.medicalRecord = medicalRecordInfo;
        medicalRecordInfo.patient = patientInfo;
        addressInfo.person = (Person_E *)patientInfo;
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            successFlag = NO;
        }
        
        //saving a hospital object to a file.
        if(successFlag == YES){
            if (self.inputPatient == nil) {
                NSString *successMessage = [@"Patient details added succesfully\n" stringByAppendingString: self.listPatientViewController.patient.description];
                [self giveSuccessAlert:successMessage];
            }
            else{
                NSString *patientFullName = [[((Patient_E *)patientInfo).firstName stringByAppendingString:@" "]stringByAppendingString:((Patient_E *)patientInfo).lastName];
                [self giveSuccessAlert: [NSString stringWithFormat:@"Patient %@ updated successfully",patientFullName]];
                
            }
            NSString *successMessage = [@"Patient details added succesfully\n" stringByAppendingString: self.listPatientViewController.patient.description];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success Message" message:successMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [self.navigationController popToRootViewControllerAnimated:NO];
            }];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else{
            [self giveErrorAlert:@"Patient details could not be saved/updated"];
        }
        currentPatient = nil;
    }
}

- (IBAction)onEditButtonClicked:(id)sender {
    self.firstNameTextField.userInteractionEnabled = YES;
    self.lastNameTextField.userInteractionEnabled = YES;
    self.ssnTextField.userInteractionEnabled = YES;
    self.dobTextField.userInteractionEnabled = YES;
    self.phoneTextField.userInteractionEnabled = YES;
    self.pcpTextField.userInteractionEnabled = YES;
    self.heartRateTextField.userInteractionEnabled = YES;
    self.respRateTextField.userInteractionEnabled = YES;
    self.bloodPressureTextField.userInteractionEnabled = YES;
    self.weightTextField.userInteractionEnabled = YES;
    self.streetNameTextField.userInteractionEnabled = YES;
    self.apartmentNumberTextField.userInteractionEnabled = YES;
    self.cityTextField.userInteractionEnabled = YES;
    self.stateTextField.userInteractionEnabled = YES;
    self.zipCodeNumberTextField.userInteractionEnabled = YES;
    self.patientImageView.userInteractionEnabled = YES;
    self.savePatientButton.hidden = FALSE;
    NSLog(@"After button clicked patient object is: %@ /n",self.listPatientViewController.patient);
    NSLog(@"After edit button clicked current patient object is: %@ /n",currentPatient);
}

- (IBAction)onPatientImageClicked:(id)sender{
    self.imagePickerController = [[UIImagePickerController alloc]init];
    self.imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePickerController.delegate = self;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.selectedImage = info[UIImagePickerControllerOriginalImage];
    self.patientImageView.image = self.selectedImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void) giveAlert: (UITextField*) textField : (NSString *) errorMessage{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error Message" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [textField becomeFirstResponder];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) giveErrorAlert : (NSString *) errorMessage{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error Message" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) giveSuccessAlert: (NSString *) successMessage{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success Message" message:successMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)displayDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    dobTextField.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:datePicker.date]];
    [dobTextField resignFirstResponder];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

//Implement the below delegate method:

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentResponder = textField;
}

//Implement resignOnTap:

- (void)resignOnTap:(id)iSender {
    [self.currentResponder resignFirstResponder];
}

@end
