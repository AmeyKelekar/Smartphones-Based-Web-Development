//
//  ProductList.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductList.h"

//Implementation for ProductList Class
@implementation ProductList

//Synthesize properties
@synthesize productList;

/*
 Message     :   sharedBookedOrderList
 Input       :   none
 Returns     :   self object -- type id
 Function    :   implementing singleton pattern
 */
+(id) sharedProductList {
    static ProductList *sharedProductList = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProductList = [[self alloc] init];
    });
    return sharedProductList;
}

//End Message sharedBookedOrderList

/*
 Message     :   init
 Input       :   none
 Returns     :   self object -- type id
 Function    :   To initialize the Booked order list with Test and dummy values to avoid inconsistent results in case the details are not passed
 */
- (id)init{
    self = [super init];
    self.productList = [[NSMutableArray alloc] init];
    return self;
}
//End Message init

/*
 Message     :   initWithProductList
 Input       :   NSMutableArray *cList
 Returns     :   self object -- type id
 Function    :   To initialize the Product list with the hash map product that are passed as the input
 */
-(id)initWithProductList: (NSMutableArray *)prodList{
    self = [super init];
    self.productList = prodList;
    return self;
}
//End Message initWithProductList

@end