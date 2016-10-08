//
//  MedicalRecord_E+CoreDataProperties.h
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/26/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MedicalRecord_E.h"

NS_ASSUME_NONNULL_BEGIN

@interface MedicalRecord_E (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *heartRate;
@property (nullable, nonatomic, retain) NSNumber *respiratoryRate;
@property (nullable, nonatomic, retain) NSNumber *systolicBloodPressure;
@property (nullable, nonatomic, retain) NSDate *timeStamp;
@property (nullable, nonatomic, retain) NSNumber *weight;
@property (nullable, nonatomic, retain) Patient_E *patient;

@end

NS_ASSUME_NONNULL_END
