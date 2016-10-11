//
//  MedicalRecord.m
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/19/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MedicalRecord.h"

//Implementation for MedicalRecord Class
@implementation MedicalRecord

//Synthesize properties
@synthesize respiratoryRate,heartRate,systolicBloodPressure,weight,timeStamp;

/*
 Message     :   init
 Input       :   none
 Returns     :   self object -- type id
 Function    :   To initialize the Medical Record with Test and dummy values to avoid inconsistent results in case the heart rate  and/or the weight isn't passed
 */
-(id)init{
    self = [super init];
    self.respiratoryRate = [[NSNumber alloc] initWithDouble:0.0];
    self.heartRate = [[NSNumber alloc] initWithDouble:0.0];
    self.systolicBloodPressure = [[NSNumber alloc] initWithDouble:0.0];
    self.weight = [[NSNumber alloc] initWithDouble:0.0];
    return self;
}
//End Message init

/*
 Message     :   description
 Input       :   none
 Returns     :   NSString
 Function    :   Override the NSObject description method for each class to display a meaningful Medical record details for each object when logged to the console
 */
- (NSString *)description {
    return [NSString stringWithFormat: @"Vital sign Details are:\n Respiratory Rate=%@\n Heart Rate=%@\n Blood Pressure=%@\n Weight=%@\n Date=%@\n", respiratoryRate, heartRate, systolicBloodPressure, weight, timeStamp];
}
//End Message description

@end
