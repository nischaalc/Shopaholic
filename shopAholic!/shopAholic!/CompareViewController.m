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

@end

@implementation CompareViewController
{
    NSMutableArray *retailerList;
    NSMutableArray *priceList;
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
    
    _finalMap.showsUserLocation = YES;
    //Create MKLocalSearchRequest
    
    retailerList = [[NSMutableArray alloc]initWithArray:[self fillRetailerList]];

    MKLocalSearchRequest *searchObject = [[MKLocalSearchRequest alloc]init];
    
    // Create MKLocal Search
    
    for (int i = 0; i < retailerList.count; i++)
    {
        searchObject.naturalLanguageQuery = [NSString stringWithFormat:@"%@", [retailerList objectAtIndex:i]];
        searchObject.region = _finalMap.region;
        MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:searchObject];
        
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self zoomToUserLocation:self.finalMap.userLocation];
}
    - (void)mapView:(MKMapView *)theMapView didUpdateToUserLocation:(MKUserLocation *)location
{
    [self zoomToUserLocation:location];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray*)fillRetailerList
{
    NSMutableArray* inputArray = [[NSMutableArray alloc]init];
    item* itemObj;
    NSString *retailerName;
    
    for (int i = 0; i < self.finalCart.itemsInCart.count;i++)
    {
        itemObj = [self.finalCart.itemsInCart objectAtIndex:i];
        
        if (![inputArray containsObject:itemObj.retailer] == YES)
        {
            retailerName = [NSString stringWithFormat: @"%@", itemObj.retailer];
            [inputArray addObject:retailerName];
        }
        
        [priceList addObject:itemObj];
    }
    return inputArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return retailerList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *simpleTableIdentifier = @"finalCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    
        cell.textLabel.text = [retailerList objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %@", [self.finalCart total]];
    
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
