//
//  MasterViewController.m
//  corral1
//
//  Created by Andres Rodriguez on 12-12-21.
//  Copyright (c) 2012 yummy. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewControllerB.h"
#import "DetailViewControllerFries.h"

#import "OrderController.h"
#import "Burger.h"
#import "Fries.h"
/*
@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end
*/
@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
    self.dataController = [[OrderController alloc] init];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 /*   self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
*/
    UIImageView *backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];

    [self.tableView setBackgroundView:backView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
*/
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    static NSString *CellLabel;
    id orderItem = [self.dataController objectInListAtIndex:indexPath.row];
    if ([orderItem isKindOfClass:[Burger class]]) {
        CellIdentifier = @"BurgerCell";
        CellLabel = @"Hamburguesa";
    }
 //   static NSString *CellIdentifier = @"BurgerCell";
    if ([orderItem isKindOfClass:[Fries class]]) {
        CellIdentifier = @"FriesCell";
        CellLabel = @"Papas";
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
 //   Burger *burgerAtIndex = [self.dataController objectInListAtIndex:indexPath.row];
    [[cell textLabel] setText:CellLabel];
 //   [[cell detailTextLabel] setText:@"ketchup"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
*/
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowItemDetails"]) {
        id orderItem = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
        if ([orderItem isKindOfClass:[Burger class]]) {
            DetailViewControllerB *detailViewController = [segue destinationViewController];
        
            detailViewController.orderItem = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
        }
        
        if ([orderItem isKindOfClass:[Fries class]]) {
            DetailViewControllerFries *detailViewController = [segue destinationViewController];
            
            detailViewController.orderItem = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
        }
    }
}


- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        
        AddItemController *addController = [segue sourceViewController];
        if (addController.burgerItem) {
            [self.dataController addOrderItemWithBurger:addController.burgerItem];
            [[self tableView] reloadData];
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"CancelInput"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}


- (IBAction)doneFries:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        
        AddItemControllerFries *addController = [segue sourceViewController];
        if (addController.friesItem) {
            [self.dataController addOrderItem:addController.friesItem];
            [[self tableView] reloadData];
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}





@end
