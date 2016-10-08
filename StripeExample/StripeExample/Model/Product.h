//
//  Product.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#ifndef Product_h
#define Product_h

@interface Product : NSObject{
    //Defining member variables
    NSNumber *productId;
    NSString *productName;
    NSNumber *productPrice;
    NSString *productCategory;
    NSData *displayImage;
}

//Declare all the properties
@property ( readwrite, retain) NSNumber *productId;
@property ( readwrite, retain) NSString *productName;
@property ( readwrite, retain) NSNumber *productPrice;
@property ( readwrite, retain) NSString *productCategory;
@property ( readwrite, retain) NSData *displayImage;

//Message declarations
-(id)init;

@end

#endif /* Product_h */
