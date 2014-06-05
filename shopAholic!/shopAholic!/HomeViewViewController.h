//
//  HomeViewViewController.h
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "item.h"


@interface HomeViewViewController : UIViewController

@property (strong, nonatomic) item* itemObject; //featured item

- (IBAction)toRetail:(id)sender;

- (IBAction)toItem:(id)sender;
- (IBAction)addToCartButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *featureName;
@property (weak, nonatomic) IBOutlet UILabel *featurePrice;
@property (weak, nonatomic) IBOutlet UIImageView *featureImage;
@property (weak, nonatomic) IBOutlet UIButton *addToCart;


@end
