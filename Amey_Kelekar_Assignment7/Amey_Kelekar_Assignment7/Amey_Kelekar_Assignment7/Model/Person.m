//
//  Person.m
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/23/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

#define firstNameKey @"First Name"
#define lastNameKey @"Last Name"
#define ssnKey @"Social Security Number"
#define dobKey @"Date of Birth"
#define phoneKey @"Phone Number"
#define addressKey @"Address"

//Implementation for Person Class
@implementation Person

//Synthesize properties
@synthesize firstName,lastName,socialSecurityNumber,dateOfBirth,telephoneNumber,address;

/*
 Message     :   init
 Input       :   none
 Returns     :   self object -- type id
 Function    :   To initialize the patient with Test and dummy values to avoid inconsistent results in case the patient name and/or the address isn't passed
 */
-(id)init{
    self = [super init];
    address=[[Address alloc]init];
    return self;
}
//End Message init

@end