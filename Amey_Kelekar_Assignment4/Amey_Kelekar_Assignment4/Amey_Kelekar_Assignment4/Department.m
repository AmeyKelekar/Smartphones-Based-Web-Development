//
//  Department.m
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/19/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Department.h"


//Implementation for Department Class
@implementation Department

//Synthesize properties
@synthesize departmentName,departmentNumber,patientList;

/*
 Message     :   init
 Input       :   none
 Returns     :   self object -- type id
 Function    :   To initialize the patient with Test and dummy values to avoid inconsistent results in case the patient name and/or the address isn't passed
 */
-(id)init{
    self = [super init];
    self.patientList = [[NSMutableArray alloc] init];
    self.departmentName = @"General";
    self.departmentNumber = [[NSNumber alloc] initWithLong:108];
    return self;
}
//End Message init


/*
 Message     :   assignDept
 Input       :   NSString
 Returns     :   void
 Function    :   Defining an enum and then setting the value of department name and number as per value entered by using a switch case
 */
- (void) assignDept  : (NSString *) input;
{
    typedef NS_ENUM(NSInteger, Departments) {
        Pediatrics,
        Physiotheraphy,
        Gynecology,
        Dentistry,
        Surgery,
        EmergencyRoom,
        ENT,
        General
    };
    NSInteger myInteger = [input integerValue];
    Departments d = myInteger - 1 ;
    switch(d){
        case Pediatrics:
            self.departmentName = @"Pediatrics";
            self.departmentNumber = [[NSNumber alloc] initWithLong:101];
            break;
        case Physiotheraphy:
            self.departmentName = @"Physiotheraphy";
            self.departmentNumber = [[NSNumber alloc] initWithLong:102];
            break;
        case Gynecology:
            self.departmentName = @"Gynecology";
            self.departmentNumber = [[NSNumber alloc] initWithLong:103];
            break;
        case Dentistry:
            self.departmentName = @"Dentistry";
            self.departmentNumber = [[NSNumber alloc] initWithLong:104];
            break;
        case Surgery:
            self.departmentName = @"Surgery";
            self.departmentNumber = [[NSNumber alloc] initWithLong:105];
            break;
        case EmergencyRoom:
            self.departmentName = @"Accident and Emergency Room";
            self.departmentNumber = [[NSNumber alloc] initWithLong:106];
            break;
        case ENT:
            self.departmentName = @"Ear, Nose and Throat";
            self.departmentNumber = [[NSNumber alloc] initWithLong:107];
            break;
        default:
            self.departmentName = @"General";
            self.departmentNumber = [[NSNumber alloc] initWithLong:108];
            break;
    }
}
//End Message assignDept

/*
 Message     :   createPatient
 Input       :   none
 Returns     :   Patient
 Function    :   create a new instance of patient and adds it to the patient list
 */

- (Patient *) createPatient{
    NSLog(@"Adding a new patient to the hospital");
    Patient *patient = [[Patient alloc]init];
    [self.patientList addObject:patient];
    return patient;
}
//End Message createPatient

/*
 Message     :   description
 Input       :   none
 Returns     :   NSString
 Function    :   Override the NSObject description method for each class to display a meaningful Department details for each object when logged to the console
 */
- (NSString *)description {
    return [NSString stringWithFormat: @"Department details are: \n  Name =%@ \n Number=%@ \n ", departmentName, departmentNumber];
}
//End Message description

@end
