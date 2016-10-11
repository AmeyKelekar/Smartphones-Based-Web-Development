//
//  Patient.m
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/19/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

//Implementation for Patient Class
@implementation Patient

//Synthesize properties
@synthesize primaryCarePhysician,medicalRecord;

/*
 Message     :   init
 Input       :   none
 Returns     :   self object -- type id
 Function    :   To initialize the patient with Test and dummy values to avoid inconsistent results in case the patient name and/or the address isn't passed
 */
-(id)init{
    self = [super init];
    medicalRecord =[[MedicalRecord alloc]init];
    self.firstName = @"TEST";
    self.lastName = @"DATA";
    self.socialSecurityNumber = [[NSNumber alloc] initWithLong:100000000];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:01];
    [comps setMonth:01];
    [comps setYear:2000];
    self.dateOfBirth = [[NSCalendar currentCalendar] dateFromComponents:comps];
    self.telephoneNumber = [[NSNumber alloc] initWithLong:1000000000];
    self.primaryCarePhysician = @"DOCTOR";
    return self;
}
//End Message init


/*
 Message     :   description
 Input       :   none
 Returns     :   NSString
 Function    :   Override the NSObject description method for each class to display a meaningful patient details for each object when logged to the console
*/
- (NSString *)description {
    return [NSString stringWithFormat: @"Patient Details are:\n First Name=%@\n Last Name=%@\n Social Security Number=%@\n DOB=%@\n Phone Number=%@\n PCP=%@\n Address=%@\n Medical Record=%@\n", firstName, lastName, socialSecurityNumber, dateOfBirth, telephoneNumber, primaryCarePhysician, address, medicalRecord];
}
//End Message description

@end