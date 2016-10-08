//
//  Person_E+CoreDataProperties.h
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/26/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person_E.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person_E (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateOfBirth;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSNumber *socialSecurityNumber;
@property (nullable, nonatomic, retain) NSNumber *telephoneNumber;
@property (nullable, nonatomic, retain) Address_E *address;

@end

NS_ASSUME_NONNULL_END
