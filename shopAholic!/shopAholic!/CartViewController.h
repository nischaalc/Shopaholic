//
//  CartViewController.h
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shoppingCart.h"

@interface CartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *cartTable;

- (IBAction)toCompare:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *compareButton;

@property (strong, nonatomic) shoppingCart* checkoutCart;

@end
