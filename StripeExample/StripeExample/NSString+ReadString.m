//
//  NSString+ReadString.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import "NSString+ReadString.h"

@implementation NSString (ReadString)

/*
 Message     :   readString
 Input       :   none
 Returns     :   NSString
 Function    :   Read simple string input from the console
 */
-(NSString *) readString{
    NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
    NSData *inputData = [NSData dataWithData:[input availableData]];
    NSString *inputString = [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];
    inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return inputString;
}
//End Message readString

/*
 Message     :   validatePhoneNumber
 Input       :   NSString
 Returns     :   Boolean
 Function    :   Validates the entered phone by matching it with the regular expression and returning a value
 */
-(BOOL) validatePhoneNumber : (NSString *) input;
{
    NSString *phoneRegex = @"[123456789][0-9]{6}([0-9]{1})?([0-9]{1})?([0-9]{1})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL matches = [test evaluateWithObject:input];
    return matches;
}
//End Message validatePhoneNumber

/*
 Message     :   validateSSN
 Input       :   NSString
 Returns     :   Boolean
 Function    :   Validates the entered ssn by matching it with the regular expression and returning a value
 */
-(BOOL) validateSSN:(NSString *)input ;
{
    //NSString *ssnRegex = @"^([0-9]{3}-?[0-9]{2}-?[0-9]{4}|XXX-XX-XXXX)$";
    NSString *ssnRegex = @"[0-9]{9}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ssnRegex];
    BOOL matches = [test evaluateWithObject:input];
    return matches;
}
//End Message validateSSN

/*
 Message     :   validateZipCode
 Input       :   NSString
 Returns     :   Boolean
 Function    :   Validates the entered zip code by matching it with the regular expression and returning a value
 */
-(BOOL) validateZipCode : (NSString *) input;
{
    NSString *ssnRegex = @"[0-9]{5}([0-9]{1})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ssnRegex];
    BOOL matches = [test evaluateWithObject:input];
    return matches;
}
//End Message validateZipCode

/*
 Message     :   validateDate
 Input       :   NSString
 Returns     :   NSDate
 Function    :   Validates the entered date by matching it with the date format and returns date if format is correct otherwise returns null
 */
-(NSDate *) validateDate : (NSString *) input;
{
    NSDateFormatter *nsDateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so we have to be careful
    [nsDateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *correctedDate = [[NSDate alloc] init];
    correctedDate = [nsDateFormatter dateFromString:input];
    return correctedDate;
}
//End Message validateDate

/*
 Message     :   NSStringIsValidEmail
 Input       :   NSString
 Returns     :   Boolean
 Function    :   Validates the entered zip code by matching it with the regular expression and returning a value
 */
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
//End Message NSStringIsValidEmail

@end

