//
//  Address.m
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/19/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"

//Implementation for Address Class
@implementation Address

//Synthesize properties
@synthesize streetName,apartmentNumber,city,state,zipCode;

/*
 Message     :   init
 Input       :   none
 Returns     :   self object -- type id
 Function    :   To initialize the address with Test and dummy values to avoid inconsistent results in case the street name and/or the zipcode isn't passed
 */
-(id)init{
    self = [super init];
    self.streetName = @"STREET";
    self.apartmentNumber = [[NSNumber alloc] initWithInt:0];;
    self.city = @"CITY";
    self.state = @"STATE";
    self.zipCode = @"00000";
    return self;
}
//End Message init

/*
 Message     :   description
 Input       :   none
 Returns     :   NSString
 Function    :   Override the NSObject description method for each class to display a meaningful address details for each object when logged to the console
 */
- (NSString *)description {
    return [NSString stringWithFormat: @"Home Address is:\n Street Name=%@\n Apartment Number=%@\n City=%@\n State=%@\n Zip Code=%@\n", streetName, apartmentNumber, city, state, zipCode];
}
//End Message description

@end
