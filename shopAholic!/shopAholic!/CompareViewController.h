//
//  CompareViewController.h
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/5/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import "shoppingCart.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "item.h"

@interface CompareViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *finalMap;
@property (weak, nonatomic) IBOutlet UITableView *finalTable;

@property (strong, nonatomic) item* itemObject;
@property (strong, nonatomic) shoppingCart* finalCart;

@end
