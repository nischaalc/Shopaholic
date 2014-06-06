//
//  HomeViewViewController.m
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import "HomeViewViewController.h"
#import "item.h"
#import "items.h"
#import "shoppingCart.h"
#import "ItemsViewController.h"

@implementation HomeViewViewController
{
    BOOL canSegue;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.itemObject = [items sharedInstance].allItems[0];
    [self populateData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    shoppingCart* checkoutCart = [shoppingCart sharedInstance];
    self.addToCart.selected = [checkoutCart containsItem:self.itemObject] ? YES : NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)populateData
{
    
    self.featureName.text = [NSString stringWithFormat:@"Item Name: %@", self.itemObject.itemName];
    
    self.featurePrice.text = [NSString stringWithFormat:@"Price: $ %@", self.itemObject.price];
    
    NSURL *url = [NSURL URLWithString: self.itemObject.photoURL];

    NSData *data = [NSData dataWithContentsOfURL:url];
    
    _featureImage.image = [UIImage imageWithData:data];
    _featureImage.contentMode = UIViewContentModeScaleAspectFit;
}

- (IBAction)toRetail:(id)sender
{
    
}

- (IBAction)toItem:(id)sender
{
    
}
- (IBAction)addToCartButton:(id)sender
{
    shoppingCart* checkoutCart = [shoppingCart sharedInstance];
    if (!self.addToCart.selected) {
        [checkoutCart addItem:self.itemObject];
        self.addToCart.selected = YES;
        [sender setTitle:@"Remove from cart" forState:UIControlStateNormal];
    }
    else {
        [checkoutCart removeItem:self.itemObject];
        self.addToCart.selected = NO;
        [sender setTitle:@"Add to cart" forState:UIControlStateNormal];
    }
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"homeToItem"])
//    {
//        ItemsViewController *destView = segue.destinationViewController;
//    }
//}


@end
