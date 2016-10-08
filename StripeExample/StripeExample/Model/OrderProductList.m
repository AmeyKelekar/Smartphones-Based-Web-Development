//
//  OrderProductList.m
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderProductList.h"

//Implementation for OrderProductList Class
@implementation OrderProductList

//Synthesize properties
@synthesize orderProductList;

/*
 Message     :   sharedOrderProductList
 Input       :   none
 Returns     :   self object -- type id
 Function    :   implementing singleton pattern
 */
+(id) sharedOrderProductList {
    static OrderProductList *sharedOrderProductList = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOrderProductList = [[self alloc] init];
    });
    return sharedOrderProductList;
}
//End Message sharedOrderProductList

/*
 Message     :   init
 Input       :   none
 Returns     :   self object -- type id
 Function    :   To initialize the Order Product list with Test and dummy values to avoid inconsistent results in case the details are not passed
 */
- (id)init{
    self = [super init];
    self.orderProductList = [[NSMutableArray alloc] init];
    return self;
}
//End Message init

/*
 Message     :   initWithOrderProductList
 Input       :   NSMutableArray *cList
 Returns     :   self object -- type id
 Function    :   To initialize the Order Product list with the order product that are passed as the input
 */
-(id)initWithOrderProductList:(NSMutableArray *)oProductList{
    self = [super init];
    self.orderProductList = oProductList;
    return self;
}
//End Message initWithOrderProductList

@end