//
//  shoppingCart.m
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import "shoppingCart.h"

@interface shoppingCart()

@property (strong, nonatomic) NSMutableArray* itemArray;

@end

@implementation shoppingCart

- (id)init {
    self = [super init];
    if (self) {
        //Custom initialization
        self.itemArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (shoppingCart *)sharedInstance
{
    static shoppingCart*  _sharedCart;
    
    static dispatch_once_t once;
    dispatch_once(&once,^{
        _sharedCart = [[shoppingCart alloc] init];
    });
    
    return _sharedCart;
}

- (NSArray*)itemsInCart
{
    return self.itemArray;
}

- (BOOL)containsItem:(item*)itemObject
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"ID=%@", itemObject.ID];
    NSArray* duplicateItems = [self.itemArray filteredArrayUsingPredicate:predicate];
    return (duplicateItems.count > 0) ? YES : NO;
}

- (void)addItem:(item*)itemObject
{
   if (![self containsItem:itemObject]) {
        [self.itemArray addObject:itemObject];
    }
}

- (void)removeItem:(item *)itemObject {
    [self.itemArray removeObject:itemObject];
}

- (void)clearCart {
    self.itemArray = [[NSMutableArray alloc] init];
}

- (NSNumber*)total {
    
    int total = 0;
    for (item* itemObject in self.itemsInCart)
    {
        total += [itemObject.price intValue];
    }
    return @(total);
}


@end
