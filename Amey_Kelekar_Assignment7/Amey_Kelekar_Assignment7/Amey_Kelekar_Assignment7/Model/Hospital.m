//
//  Hospital.m
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/23/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hospital.h"
#import "NSString+ReadString.h"

#define nameKey @"hospitalName"
#define patientListKey @"patientList"

//Implementation for Hospital Class
@implementation Hospital

//Synthesize properties
@synthesize name,patientList;

/*
 Message     :   sharedHospital
 Input       :   none
 Returns     :   self object -- type id
 Function    :   implementing singleton pattern
 */
+(id) sharedHospital {
    static Hospital *sharedMyHospital = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyHospital = [[self alloc] init];
    });
    return sharedMyHospital;
}
//End Message sharedHospital

/*
 Message     :   init
 Input       :   none
 Returns     :   self object -- type id
 Function    :   To initialize the patient with Test and dummy values to avoid inconsistent results in case the patient name and/or the address isn't passed
 */
- (id)init{
    self = [super init];
    self.name = @"Boston Hospital";
    self.patientList = [[NSMutableArray alloc] init];
    return self;
}
//End Message init

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

- (void) removePatient: (Patient *) patient{
    [self.patientList removeObject:patient];
}

/*
 Message     :   initWithName
 Input       :   NSString *hName
 NSMutableArray *dList
 Returns     :   self object -- type id
 Function    :   To initialize the hospital with the name and the department that is passed as the input
 */
-(id)initWithName:(NSString *)hName {
    self = [super init];
    self.name = hName;
    return self;
}
//End Message initWithName

/*
 Message     :   description
 Input       :   none
 Returns     :   NSString
 Function    :   Override the NSObject description method for each class to display a meaningful Hospital details for each object when logged to the console
 */
- (NSString *)description {
    return [NSString stringWithFormat: @"Hostipal name is: Name =%@", name];
}
//End Message description

@end