//
//  CartViewController.m
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController ()

@end

@implementation CartViewController

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
    self.checkoutCart = [shoppingCart sharedInstance];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.cartTable reloadData];
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

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? self.checkoutCart.itemsInCart.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0)
    {
        item* itemObject = self.checkoutCart.itemsInCart[indexPath.row];
        
        static NSString *simpleTableIdentifier = @"cartCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        cell.textLabel.text =  itemObject.itemName;
        cell.detailTextLabel.text = itemObject.retailer;
        
        NSURL *url = [NSURL URLWithString: itemObject.photoURL];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        UIImage *itemImage = [UIImage imageWithData:data];
        
        cell.imageView.image = itemImage;
        return cell;
    }
    
    return nil;
}

- (IBAction)toCompare:(id)sender
{
}
@end
