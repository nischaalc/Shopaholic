//
//  items.m
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import "items.h"
#import "item.h"

@implementation items


+ (items *)sharedInstance {
    static items*  _sharedItems;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedItems = [[items alloc] init];
    });
    return _sharedItems;
}

- (id)init
{
    if((self = [super init]))
    {
        _allItems = [self loadItemsFromJSON];
    }
    return self;
}

- (NSArray *)loadItemsFromJSON {
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"dogs" ofType:@"json"];
    
    NSError* error;
    NSData* jsonData =  [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    NSMutableArray* itemArray = [[NSMutableArray alloc] initWithCapacity:jsonArray.count];
    
    for (NSDictionary* itemDictionary in jsonArray)
    {
        item* itemObject = [[item alloc] init];
        
        itemObject.ID = itemDictionary[@"id"];
        itemObject.retailer = itemDictionary[@"Retailer"];
        itemObject.itemName = itemDictionary[@"ProductName"];
        itemObject.photoURL = itemDictionary[@"URL"];
        itemObject.price = itemDictionary[@"Price"];
        itemObject.type = itemDictionary[@"ProductType"];
        itemObject.quality = itemDictionary[@"Quality"];
        [itemArray addObject:itemObject];
    }
    
    return itemArray;
}

@end
