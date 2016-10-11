//
//  Hospital.h
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/19/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#ifndef Hospital_h
#define Hospital_h
#import "Department.h"

@interface Hospital : NSObject
{
    //Defining member variables
    NSString *name;
    NSMutableArray<Department *> *departmentList;
}

//Declare all the properties
@property(readwrite,retain)NSString *name;
@property(readwrite, retain) NSMutableArray<Department *> *departmentList;

//Singleton method
+(id)sharedHospital;

// creating a new department and adding to the list
- (Department *) createDepartment;

//Override the description method of NSObject
- (NSString *)description;

@end

#endif /* Hospital_h */
