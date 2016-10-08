//
//  Patient_E+CoreDataProperties.h
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/26/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Patient_E.h"

NS_ASSUME_NONNULL_BEGIN

@interface Patient_E (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *displayImage;
@property (nullable, nonatomic, retain) NSString *primaryCarePhysician;
@property (nullable, nonatomic, retain) MedicalRecord_E *medicalRecord;

@end

NS_ASSUME_NONNULL_END
