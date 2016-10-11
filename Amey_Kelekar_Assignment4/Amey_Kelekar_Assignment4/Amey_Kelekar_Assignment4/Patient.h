//
//  Patient.h
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/19/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#ifndef Patient_h
#define Patient_h
#import "Person.h"
#import "MedicalRecord.h"

@interface Patient : Person
{
    //Defining member variables
    NSString *primaryCarePhysician;
    MedicalRecord *medicalRecord;
}

//Declare all the properties
@property(readwrite, retain)NSString *primaryCarePhysician;
@property(readwrite, retain)MedicalRecord *medicalRecord;

//Message declarations
-(id)init;

//Override the description method of NSObject
- (NSString *)description;

@end

#endif /* Patient_h */
