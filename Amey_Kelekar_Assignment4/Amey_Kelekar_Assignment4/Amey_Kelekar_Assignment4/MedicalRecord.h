//
//  MedicalRecord.h
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/19/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#ifndef MedicalRecord_h
#define MedicalRecord_h

@interface MedicalRecord : NSObject
{
    //Defining member variables
    NSNumber *respiratoryRate;
    NSNumber *heartRate;
    NSNumber *systolicBloodPressure;
    NSNumber *weight;
    NSDate *timeStamp;
}

//Declare all the properties
@property(readwrite, retain)NSNumber *respiratoryRate;
@property(readwrite, retain)NSNumber *heartRate;
@property(readwrite, retain)NSNumber *systolicBloodPressure;
@property(readwrite, retain)NSNumber *weight;
@property(readwrite, retain)NSDate *timeStamp;

//Message declarations
-(id)init;

//Override the description method of NSObject
- (NSString *)description;

@end

#endif /* MedicalRecord_h */
