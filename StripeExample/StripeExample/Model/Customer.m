//
//  Customer.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"

//Implementation for Customer Class
@implementation Customer

//Synthesize properties
@synthesize custid,firstname,lastname,mobilenumber,emailid;

/*
 Message     :   init
 Input       :   none
 Returns     :   self object -- type id
 Function    :   To initialize the Customer with Test and dummy values to avoid inconsistent results in case the first name and/or the other details isn't passed
 */
-(id)init{
    self = [super init];
    self.custid = [[NSNumber alloc] initWithInt:10000000];
    self.firstname = @"FIRST_NAME";
    self.lastname = @"LAST_NAME";
    self.mobilenumber = [[NSNumber alloc] initWithInt:10000000];
    self.emailid = @"EMAILID@xyz.com";
    return self;
}
//End Message init

@end