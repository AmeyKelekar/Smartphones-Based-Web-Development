//
//  Product.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

//Implementation for Product Class
@implementation Product

//Synthesize properties
@synthesize productId, productName, productPrice, productCategory,displayImage;

/*
 Message     :   init
 Input       :   none
 Returns     :   self object -- type id
 Function    :   To initialize the Product with Test and dummy values to avoid inconsistent results in case the product name and/or the other details isn't passed
 */
-(id)init{
    self = [super init];
    self.productId = [[NSNumber alloc] initWithInt:0];
    self.productName = @"PRODUCT_NAME";
    self.productPrice = [[NSNumber alloc] initWithDouble:0.0];
    self.productCategory = @"PRODUCT_CATEGORY";
    return self;
}
//End Message init

@end