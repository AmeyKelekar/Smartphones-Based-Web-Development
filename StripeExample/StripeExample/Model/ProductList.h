//
//  ProductList.h
//  StripeExample
//
//  Created by Amey Kelekar on 5/5/16.
//  Copyright © 2016 MobStac. All rights reserved.
//

#ifndef ProductList_h
#define ProductList_h

#import "Product.h"

@interface ProductList : NSObject{
    //Defining member variables
    NSMutableArray<Product *> *productList;
}

//Declare all the properties
@property ( readwrite, retain) NSMutableArray<Product *> *productList;

//Singleton method
+(id)sharedProductList;

-(id)initWithProductList: (NSMutableArray *)prodList;

@end

#endif /* ProductList_h */
