//
//  NSString+ReadString.h
//  Amey_Kelekar_Assignment4
//
//  Created by Amey Kelekar on 2/19/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ReadString)

//Read simple string input from the console
-(NSString *) readString;

//Validates the entered phone number by matching it with the regular expression and returning a value
-(BOOL) validatePhoneNumber : (NSString *) input;

//Validates the entered ssn by matching it with the regular expression and returning a value
-(BOOL) validateSSN : (NSString *) input;

//Validates the entered zip code by matching it with the regular expression and returning a value
-(BOOL) validateZipCode : (NSString *) input;

//Validates the entered date by matching it with the date format
-(NSDate *) validateDate : (NSString *) input;

@end
