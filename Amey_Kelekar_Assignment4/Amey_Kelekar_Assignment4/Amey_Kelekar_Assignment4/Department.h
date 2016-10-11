//
//  Department.h
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/19/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#ifndef Department_h
#define Department_h
#import "Patient.h"

@interface Department : NSObject
{
    //Defining member variables
    NSString *departmentName;
    NSNumber *departmentNumber;
    NSMutableArray<Patient *> *patientList;     
}

//Declare all the properties
@property(readwrite, retain)NSString *departmentName;
@property(readwrite, retain)NSNumber *departmentNumber;
@property(readwrite, retain)NSMutableArray<Patient *> *patientList;

//Message declarations
-(id)init;

// creating a new patient and adding to the list
- (Patient *) createPatient;

//Override the description method of NSObject
- (NSString *)description;

//Enum to implement a method to assign department name and department number
- (void) assignDept : (NSString *) input;

@end

#endif /* Department_h */
