//
//  shoppingCart.h
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "item.h"

@interface shoppingCart : NSObject

+ (shoppingCart *)sharedInstance;

- (NSArray*) itemsInCart;

- (BOOL)containsItem:(item*)itemObject;

- (void)addItem:(item*)itemObject;

- (void)removeItem:(item*)itemObject;

- (void)clearCart;

- (NSNumber*)total;



@end
