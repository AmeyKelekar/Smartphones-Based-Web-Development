//
//  Hospital.m
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/19/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hospital.h"
#import "NSString+ReadString.h"

//Implementation for Address Class
@implementation Hospital

//Synthesize properties
@synthesize name,departmentList;

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
    self.departmentList = [[NSMutableArray alloc] init];
    return self;
}
//End Message init

/*
 Message     :   createDepartment
 Input       :   none
 Returns     :   Department
 Function    :   create a new instance of departmet and adds it to the department list
 */
- (Department *) createDepartment{
    NSLog(@"Selecting a department for the patient");
    Department *department = [[Department alloc]init];
    [self.departmentList addObject:department];
    return department;
}
//End Message createDepartment


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
