//
//  OrderProductList.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#ifndef OrderProductList_h
#define OrderProductList_h

#import "OrderProduct.h"

@interface OrderProductList : NSObject{
    //Defining member variables
    NSMutableArray<OrderProduct *> *orderProductList;
}

//Declare all the properties
@property ( readwrite, retain) NSMutableArray<OrderProduct *> *orderProductList;

//Singleton method
+(id)sharedOrderProductList;

-(id)initWithOrderProductList:(NSMutableArray *)oProductList;

@end

#endif /* OrderProductList_h */
