//
//  ItemsViewController.m
//  shopAholic!
//
//  Created by Zoltan Gercsak on 6/4/14.
//  Copyright (c) 2014 Zoltan Gercsak. All rights reserved.
//

#import "ItemsViewController.h"
#import "item.h"
#import "items.h"
#import "itemDetailViewController.h"

@interface ItemsViewController ()

@property (assign, nonatomic) NSInteger selectedIndex;


@end

@implementation ItemsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewData

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[items sharedInstance].allItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    item* itemObject = [items sharedInstance].allItems[indexPath.row];
    
    static NSString *simpleTableIdentifier = @"itemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    NSURL *url = [NSURL URLWithString: itemObject.photoURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    cell.detailTextLabel.text =  itemObject.retailer;
    cell.textLabel.text = itemObject.itemName;
    cell.imageView.image = [UIImage imageWithData:data];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;

    [self.itemTable deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toDetail"])
    {
    itemDetailViewController* viewController = (itemDetailViewController*) segue.destinationViewController;
    viewController.itemObject = [items sharedInstance].allItems[self.selectedIndex];
    }
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}


@end
