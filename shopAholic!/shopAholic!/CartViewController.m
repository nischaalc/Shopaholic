//
//  CartViewController.m
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import "CartViewController.h"
#import "CompareViewController.h"
#import "itemDetailViewController.h"
#import "item.h"
#import "items.h"

@interface CartViewController ()

@property (assign, nonatomic) NSInteger selectedIndex;

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
    
    UIAlertView *info = [[UIAlertView alloc]initWithTitle:nil message:@"To remove an item from your cart, just tap it." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Got it", nil];
    
    [info show];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    
    UIAlertView *removedAlert = [[UIAlertView alloc]initWithTitle:@"Successful" message:@"Item removed from cart!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [self.cartTable deselectRowAtIndexPath:indexPath animated:YES];
    
    item* itemObject = self.checkoutCart.itemsInCart[indexPath.row];
    
    [_checkoutCart removeItem:itemObject];
    
    [self.cartTable reloadData];
    
    [removedAlert show];
}

- (IBAction)toCompare:(id)sender
{
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toCompare"])
    {
        CompareViewController *destView = segue.destinationViewController;
        
        destView.finalCart = self.checkoutCart;
    }
}

@end
