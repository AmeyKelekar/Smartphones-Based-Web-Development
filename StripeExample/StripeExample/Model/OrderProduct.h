//
//  OrderProduct.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#ifndef OrderProduct_h
#define OrderProduct_h

@interface OrderProduct : NSObject{
    //Defining member variables
    NSNumber *productId;
    NSString *productName;
    NSNumber *productPrice;
    NSNumber *productQuantity;
    NSNumber *productItemCount;
    NSNumber *productActualPrice;
    NSString *productCategory;
}

//Declare all the properties
@property ( readwrite, retain) NSNumber *productId;
@property ( readwrite, retain) NSString *productName;
@property ( readwrite, retain) NSNumber *productPrice;
@property ( readwrite, retain) NSNumber *productQuantity;
@property ( readwrite, retain) NSNumber *productItemCount;
@property ( readwrite, retain) NSNumber *productActualPrice;
@property ( readwrite, retain) NSString *productCategory;

//Message declarations
-(id)init;

@end

#endif /* OrderProduct_h */
