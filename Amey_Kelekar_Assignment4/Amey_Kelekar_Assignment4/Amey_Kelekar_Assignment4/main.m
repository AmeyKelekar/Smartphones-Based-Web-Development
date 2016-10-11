//
//  main.m
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/19/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hospital.h"
#import "NSString+ReadString.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Hospital *hospital = [Hospital sharedHospital];

        NSString *string =[[NSString alloc]init];
        double dValue;
        int iValue;
        Department *department;
        NSString *selection;
        
        NSLog(@"Please enter a option to perform following\n 1. A/a = Add a Patient \n 2. S/s = Search for a Patient \n 3. L/l = listall existing Patients \n 4. E/e = exit the application");
        //reading value from the console
        NSString *inpString = [string readString];
        //Executing the application till user enters E/e
        while (!([inpString isEqualToString:@"E"] || [inpString isEqualToString:@"e"]))
        {
            NSLog(@"input string is: %@",inpString);
            //Checks if entered option is to add a patient
            if ([inpString isEqualToString:@"A"] || [inpString isEqualToString:@"a"]) {
                //Select department by giving any option from 1-8
                NSLog(@"Please enter digits(1-8) to select a department \n 1: Pediatrics \n 2: Physiotheraphy \n 3: Gynecology \n 4: Dentistry \n 5: Surgery \n 6: Accident and Emergency Room \n 7: Ear, nose and throat \n 8: General ");
                selection = [string readString];
                department = [hospital createDepartment];

                //Checking if entered value is a valid numeric value
                if (selection.length > 0 && [[NSScanner scannerWithString:selection] scanInt:&iValue]) {
                    [department assignDept:selection];
                    
                }
                else{
                    NSLog(@"Error: Only numerical values are accepted, entered string will be replaced by default value ");
                }
                Patient *patient = [department createPatient];
            
                NSLog(@"Enter Patient's first name:");
                //reading value from the console
                NSString *fName = [string readString];
                
                // Checking whether string contains only whitespace.
                NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
                if ([[fName stringByTrimmingCharactersInSet: set] length] == 0)
                {
                    NSLog(@"First name contains only white spaces, will be replaced by default data!!!");
                }
                else{
                    patient.firstName = fName;
                }
                
                NSLog(@"Enter Patient's last name:");
                //reading value from the console
                NSString *lName = [string readString];
                // Checking whether string contains only whitespace.
                if ([[lName stringByTrimmingCharactersInSet: set] length] == 0)
                {
                    NSLog(@"Last name contains only white spaces, will be replaced by default data!!!");
                }
                else{
                    patient.lastName = lName;
                }
                NSLog(@"Enter Patient's SSN:");
                //reading value from the console
                NSString *ssn = [string readString];
                //validates if entered ssn matches the pattern
                BOOL matches = [ssn validateSSN:ssn];
                if(matches ==false){
                    NSLog(@"Entered ssn should be 9 digits!!!");
                }
                else{
                    patient.socialSecurityNumber = [NSNumber numberWithInteger: [ssn integerValue]];
                }
            
                NSLog(@"Enter Patient's DOB: (dd-MM-yyyy)");
                //reading value from the console
                NSString *dob = [string readString];
                //validates if entered date is as per the date format dd-MM-yyyy
                NSDate *correctedDt = [dob validateDate:dob];
                if(correctedDt == NULL)
                {
                    NSLog(@"Entered date doesn't match the date format, will be replaced by default data!!! ");
                }
                else{
                    patient.dateOfBirth= correctedDt;
                }
                
                NSLog(@"Enter Patient's Phone Number:");
                //reading value from the console
                NSString *phone = [string readString];
                //validates if entered phone matches the pattern
                matches = [phone validatePhoneNumber:phone];
                if(matches ==false){
                    NSLog(@"Entered phone number should be minimum 7 digits, maximum 10 digits and the first digit must be 1,2,3,4,5,6,7,8 or 9");
                }
                else{
                    patient.telephoneNumber = [NSNumber numberWithInteger: [phone integerValue]];
                }
                
                NSLog(@"Enter Patient's PCP:");
                //reading value from the console
                NSString *pcp = [string readString];
                // Checking whether string contains only whitespace.
                if ([[pcp stringByTrimmingCharactersInSet: set] length] == 0)
                {
                    NSLog(@"Primary Care Physician contains only white spaces, will be replaced by default value!!!");
                }
                else{
                    patient.primaryCarePhysician = pcp;
                }

                NSLog(@"Adding the patient's vital sign details below");
                
                NSLog(@"Please enter the respiratory Rate:");
                //reading value from the console
                NSString *respRate = [string readString];
                //checks if respiratory rate is numeric
                if (respRate.length > 0 && [[NSScanner scannerWithString:respRate] scanDouble:&dValue]) {
                   patient.medicalRecord.respiratoryRate = [NSNumber numberWithDouble: [respRate doubleValue]];
                }
                else{
                    NSLog(@"Error: Only numerical values are accepted, entered string will be replaced by default value ");
                }
            
                NSLog(@"Please enter the Heart Rate");
                //reading value from the console
                NSString * hRate = [string readString];
                //checks if heart rate is numeric
                if (hRate.length > 0 && [[NSScanner scannerWithString:hRate] scanDouble:&dValue]) {
                    patient.medicalRecord.heartRate = [NSNumber numberWithDouble: [hRate doubleValue]];
                }
                else{
                    NSLog(@"Error: Only numerical values are accepted, entered string will be replaced by default value ");
                }

                
                NSLog(@"Please enter the Systoic Blood Pressure");
                //reading value from the console
                NSString * bloodPressure = [string readString];
                //checks if blood pressure is numeric
                if (bloodPressure.length > 0 && [[NSScanner scannerWithString:bloodPressure] scanDouble:&dValue]) {
                    patient.medicalRecord.systolicBloodPressure = [NSNumber numberWithDouble: [bloodPressure doubleValue]];
                }
                else{
                    NSLog(@"Error: Only numerical values are accepted, entered string will be replaced by default value ");
                }

                
                NSLog(@"Please enter the weight (in pounds):");
                //reading value from the console
                NSString *wt = [string readString];
                //checks if weight is numeric
                if (wt.length > 0 && [[NSScanner scannerWithString:wt] scanDouble:&dValue]) {
                    patient.medicalRecord.weight = [NSNumber numberWithDouble: [wt doubleValue]];
                }
                else{
                    NSLog(@"Error: Only numerical values are accepted, entered string will be replaced by default value ");
                }

                
                patient.medicalRecord.timeStamp = [[NSDate alloc]init];
                
                NSLog(@"Adding the patient's address below");
                NSLog(@"Please enter the street name:");
                //reading value from the console
                NSString *street = [string readString];
                if ([[street stringByTrimmingCharactersInSet: set] length] == 0)
                {
                    NSLog(@"Street Name contains only white spaces, will be replaced by default value!!!");
                }
                else{
                    patient.address.streetName = street;
                }
                
                NSLog(@"Please enter the apartment no:");
                //reading value from the console
                NSString *aptNumber = [string readString];
                //checks if apartment is numeric
                if (aptNumber.length > 0 && [[NSScanner scannerWithString:aptNumber] scanInt:&iValue]) {
                    patient.address.apartmentNumber = [NSNumber numberWithInteger: [aptNumber integerValue]];
                }
                else{
                    NSLog(@"Error: Only numerical values are accepted, entered string will be replaced by default value ");
                }
                
                NSLog(@"Please enter the city:");
                //reading value from the console
                NSString *cityName= [string readString];
                // Checking whether string contains only whitespace.
                if ([[cityName stringByTrimmingCharactersInSet: set] length] == 0)
                {
                    NSLog(@"City contains only white spaces, will be replaced by default value!!!");
                }
                else{
                    patient.address.city = cityName;
                }
                
                NSLog(@"Please enter the state:");
                //reading value from the console
                NSString *stateName = [string readString];
                // Checking whether string contains only whitespace.
                if ([[stateName stringByTrimmingCharactersInSet: set] length] == 0)
                {
                    NSLog(@"State contains only white spaces, will be replaced by default value!!!");
                }
                else{
                    patient.address.state = stateName;
                }
                NSLog(@"Please enter the zip code:");
                //reading value from the console
                NSString *zip = [string readString];
                //validates if zip code matches the pattern
                matches = [zip validateZipCode:zip];
                if(matches ==false){
                    NSLog(@"Entered zip code should be minimum 5 digits and maximum 6 digits");
                }
                else{
                    patient.address.zipCode = zip;
                }
                NSLog(@"Patient details added successfully\n %@ \n %@",department,patient);
            }
            
            //Checks if entered option is to search a patient
            else if ([inpString isEqualToString:@"S"] || [inpString isEqualToString:@"s"]) {
                NSLog(@"Please enter the first name to search the patient details:");
                //reading value from the console
                NSString *searchAnswer = [string readString];
                Patient *patient;
                int count = 0;
                //for each loop to traverse all departments in a hospital
                for(department in hospital.departmentList){
                    //for each loop to traverse all patients in a department
                    for(patient in department.patientList){
                        //compares entered string with patient's first name ignoring case and returns list of patient
                        if([patient.firstName compare :searchAnswer options:NSCaseInsensitiveSearch] == NSOrderedSame){
                            NSLog(@"Details of patients are as follows:%@\n",patient);
                            count ++;
                        }
                    }
                }
                //checks above for loop returns no row
                if (count == 0) {
                    NSLog(@"Nothing to search!!!");
                }
            }
            
            else if ([inpString isEqualToString:@"L"] || [inpString isEqualToString:@"l"]) {
                NSLog(@"Please enter \n 1:List patients for a particular department 2: List of all patients");
                //reading value from the console
                NSString *listOption = [string readString];
                NSLog(@"List of patients");
                Patient *patient;
                int row =0;
                //Checks if user opted to list patients department wise
                if ([listOption isEqualToString: @"1"]){
                    NSLog(@"Please select a department \n 1: Pediatrics \n 2: Physiotheraphy \n 3: Gynecology \n 4: Dentistry \n 5: Surgery \n 6: Accident and Emergency Room \n 7: Ear, nose and throat \n 8: General");
                    //reading value from the console
                    NSString *departmentOption = [string readString];
                    //for each loop to traverse all departments in a hospital
                    for(department in hospital.departmentList){
                        //checks if entered string is equal to department name by ignoring case
                        if([department.departmentName compare: departmentOption options:NSCaseInsensitiveSearch] == NSOrderedSame)
                        {   //displays all the patient lists if department name matches
                            for(patient in department.patientList)
                            {
                                NSLog(@"details of patients:%@",patient);
                                row++;
                            }
                        }
                    }
                    //checks above for loop returns no row
                    if (row == 0) {
                        NSLog(@"Nothing to list!!!");
                    }
                }
                
                //checks if user opted for list of all patients
                else if ([listOption isEqualToString: @"2"]){
                    //for each loop to traverse all departments in a hospital
                    for(department in hospital.departmentList){
                        //for each loop to traverse all patients in a department
                        for(patient in department.patientList)
                        {
                            NSLog(@"details of patients:%@",patient);
                            row ++;
                        }
                    }
                    //checks above for loop returns no row
                    if (row == 0) {
                        NSLog(@"Nothing to list!!!");
                    }
                }
                
                //checks if user selected wrong option
                else{
                    NSLog(@"You have entered a wrong option!");
                }
            }
            
            //checks if user selected wrong option
            else {
                NSLog(@"You have seleted a wrong option!!! Please select a valid option");
            }
            NSLog(@"Please enter a option to perform following\n 1. A/a = Add a Patient \n 2. S/s = Search for a Patient \n 3. L/l = list all existing Patients \n 4. E/e = exit the application");
            //reading value from the console
            inpString = [string readString];
        }
    }
    return 0;
}
