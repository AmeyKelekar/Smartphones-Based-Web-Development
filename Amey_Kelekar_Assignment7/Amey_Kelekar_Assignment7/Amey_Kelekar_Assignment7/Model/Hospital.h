//
//  Hospital.h
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/23/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#ifndef Hospital_h
#define Hospital_h
#import "Patient.h"

@interface Hospital : NSObject
{
    //Defining member variables
    NSString *name;
    NSMutableArray<Patient *> *patientList;
    
}

//Declare all the properties
@property(readwrite,retain)NSString *name;
@property(readwrite, retain)NSMutableArray<Patient *> *patientList;

//Singleton method
+(id)sharedHospital;

-(id)initWithName:(NSString *)hName;

// creating a new department and adding to the list
- (Patient *) createPatient;

//Override the description method of NSObject
- (NSString *)description;

@end

#endif /* Hospital_h */
