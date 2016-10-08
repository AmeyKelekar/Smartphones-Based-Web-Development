//
//  Address_E+CoreDataProperties.h
//  Amey_Kelekar_Assignment7
//
//  Created by Amey Kelekar on 3/26/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Address_E.h"

NS_ASSUME_NONNULL_BEGIN

@interface Address_E (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *apartmentNumber;
@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *state;
@property (nullable, nonatomic, retain) NSString *streetName;
@property (nullable, nonatomic, retain) NSString *zipCode;
@property (nullable, nonatomic, retain) Person_E *person;

@end

NS_ASSUME_NONNULL_END
