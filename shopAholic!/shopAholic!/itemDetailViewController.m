//
//  itemDetailViewController.m
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import "itemDetailViewController.h"
#import "shoppingCart.h"
#import <MapKit/MapKit.h>

@interface itemDetailViewController ()

@end

@implementation itemDetailViewController

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
    [self loadData];
    
    _storeMap.showsUserLocation = YES;
    //Create MKLocalSearchRequest
    MKLocalSearchRequest *searchObject = [[MKLocalSearchRequest alloc]init];
    searchObject.naturalLanguageQuery = self.itemObject.retailer;
    searchObject.region = _storeMap.region;
    
    // Create MKLocal Search
    
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:searchObject];
    
    // implement functionalities in the completionHandler
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
     {
         for (MKMapItem *item in response.mapItems)
         {
             MKPointAnnotation *annotation =
             [[MKPointAnnotation alloc]init];
             annotation.title = item.name;
             annotation.coordinate = item.placemark.coordinate;
             
             [_storeMap addAnnotation:annotation];
         }
         
     }];
    
    _storeMap.zoomEnabled = YES;

}

- (void)zoomToUserLocation:(MKUserLocation *)userLocation
{
    if (!userLocation)
        return;
    
    MKCoordinateRegion region;
    region.center = userLocation.location.coordinate;
    region.span = MKCoordinateSpanMake(1.0, 1.0); //Zoom distance
    region = [self.storeMap regionThatFits:region];
    [self.storeMap setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    shoppingCart* checkoutCart = [shoppingCart sharedInstance];
    self.cartIt.enabled = [checkoutCart containsItem:self.itemObject] ? YES : NO;
    
    //[self zoomToUserLocation:self.storeMap.userLocation];
}

- (void)loadData {
    
    self.retailerLabel.text = self.itemObject.retailer;
 
    NSURL *url = [NSURL URLWithString: self.itemObject.photoURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *itemImage = [UIImage imageWithData:data];
    
    self.itemImage.image = itemImage;
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@", self.itemObject.itemName];
    self.priceLabel.text = [NSString stringWithFormat:@"%@", self.itemObject.price];
    
    self.itemDescription.text = [NSString stringWithFormat:@"%@", self.itemObject.description];
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

- (IBAction)cartButton:(id)sender
{
    shoppingCart* checkoutCart = [shoppingCart sharedInstance];
    
    if (!self.cartIt.enabled) {
        [checkoutCart addItem:self.itemObject];
        self.cartIt.enabled = YES;
    }
    else {
        [checkoutCart removeItem:self.itemObject];
        self.cartIt.enabled = NO;
    }
}
@end
