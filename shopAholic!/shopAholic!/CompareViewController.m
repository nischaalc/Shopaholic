//
//  CompareViewController.m
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/5/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import "CompareViewController.h"
#import "item.h"
#import "items.h"

@interface CompareViewController ()

@property (strong, nonatomic) NSMutableArray* retailerList;

@end

@implementation CompareViewController

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
    
    _finalMap.showsUserLocation = YES;
    //Create MKLocalSearchRequest
    
    [self fillRetailerList];
    MKLocalSearchRequest *searchObject = [[MKLocalSearchRequest alloc]init];
    searchObject.naturalLanguageQuery = self.itemObject.retailer;
    searchObject.region = _finalMap.region;
    
    // Create MKLocal Search

    for (int i = 0; i < self.retailerList.count; i++)
    {
        MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:[self.retailerList objectAtIndex:i]];
        
        [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
         {
             for (MKMapItem *item in response.mapItems)
             {
                 MKPointAnnotation *annotation =
                 [[MKPointAnnotation alloc]init];
                 annotation.title = item.name;
                 annotation.coordinate = item.placemark.coordinate;
                 
                 [_finalMap addAnnotation:annotation];
             }
             
         }];
    }
    
    _finalMap.zoomEnabled = YES;
    
    NSLog(@"%@", self.retailerList);
    
}

- (void)zoomToUserLocation:(MKUserLocation *)userLocation
{
    if (!userLocation)
        return;
    
    MKCoordinateRegion region;
    region.center = userLocation.location.coordinate;
    region.span = MKCoordinateSpanMake(1.0, 1.0); //Zoom distance
    region = [self.finalMap regionThatFits:region];
    [self.finalMap setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fillRetailerList
{
    int counter = 0;
    
    item* itemObject;
    NSString *retailerName;
    
    for (int i = 0; i < self.checkoutCart.itemsInCart.count;i++)
    {
        itemObject = self.checkoutCart.itemsInCart[i];
        retailerName = itemObject.retailer;
        
        [self.retailerList addObject:retailerName];
        
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.checkoutCart.itemsInCart.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        item* itemObject = self.checkoutCart.itemsInCart[indexPath.row];
        
        static NSString *simpleTableIdentifier = @"finalCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
        cell.textLabel.text = [self.retailerList objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = itemObject.price;

        return cell;

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

@end
