//
//  Person.h
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/20/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#ifndef Person_h
#define Person_h
#import "Address.h"

@interface Person : NSObject
{
    //Defining member variables
    NSString *firstName;
    NSString *lastName;
    NSNumber *socialSecurityNumber;
    NSDate *dateOfBirth;
    NSNumber *telephoneNumber;
    Address *address;
}

//Declare all the properties
@property(readwrite, retain)NSString *firstName;
@property(readwrite, retain)NSString *lastName;
@property(readwrite, retain)NSNumber *socialSecurityNumber;
@property(readwrite, retain)NSDate *dateOfBirth;
@property(readwrite, retain)NSNumber *telephoneNumber;
@property(readwrite, retain)Address *address;

//Message declarations
-(id)init;

@end

#endif /* Person_h */
