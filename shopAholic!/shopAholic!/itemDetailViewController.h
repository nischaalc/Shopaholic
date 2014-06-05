//
//  itemDetailViewController.h
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "item.h"

@interface itemDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *retailerLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *itemDescription;
@property (weak, nonatomic) IBOutlet MKMapView *storeMap;

@property (strong, nonatomic) item* itemObject;
- (IBAction)cartButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cartIt;


@end
