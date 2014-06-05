//
//  items.h
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface items : NSObject

// This class provides a location for storing the available items

@property (strong, readonly, nonatomic) NSArray *allItems;

+ (items *)sharedInstance;

@end
