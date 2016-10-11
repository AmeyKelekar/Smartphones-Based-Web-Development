//
//  Person.m
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/20/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

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