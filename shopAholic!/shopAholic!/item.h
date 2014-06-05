//
//  item.h
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface item : NSObject

@property (strong, nonatomic) NSString* retailer;
@property (strong, nonatomic) NSString* itemName;
@property (strong, nonatomic) NSString* photoURL;
@property (strong, nonatomic) NSString* quality;
@property (strong, nonatomic) NSString* type;
@property (strong, nonatomic) NSString* price;

@end
