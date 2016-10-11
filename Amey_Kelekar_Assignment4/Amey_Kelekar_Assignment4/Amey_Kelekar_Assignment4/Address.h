//
//  Address.h
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/19/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#ifndef Address_h
#define Address_h

@interface Address : NSObject
{
    //Defining member variables
    NSString *streetName;
    NSNumber *apartmentNumber;
    NSString *city;
    NSString *state;
    NSString *zipCode;
}

//Declare all the properties
@property(readwrite, retain)NSString *streetName;
@property(readwrite, retain)NSNumber *apartmentNumber;
@property(readwrite, retain)NSString *city;
@property(readwrite, retain)NSString *state;
@property(readwrite, retain)NSString *zipCode;

//Message declarations
-(id)init;

@end

#endif /* Address_h */
