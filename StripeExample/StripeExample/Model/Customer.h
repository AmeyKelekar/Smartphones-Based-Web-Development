//
//  Customer.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#ifndef Customer_h
#define Customer_h

@interface Customer : NSObject{
    //Defining member variables
    NSNumber *custid;
    NSString *firstname;
    NSNumber *mobilenumber;
    NSString *lastname;
    NSString *emailid;
}

//Declare all the properties
@property ( readwrite, retain) NSNumber *custid;
@property ( readwrite, retain) NSString *firstname;
@property ( readwrite, retain) NSNumber *mobilenumber;
@property ( readwrite, retain) NSString *lastname;
@property ( readwrite, retain) NSString *emailid;

//Message declarations
-(id)init;

@end


#endif /* Customer_h */
