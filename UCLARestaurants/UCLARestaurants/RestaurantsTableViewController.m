//
//  RestaurantsTableViewController.m
//  UCLARestaurants
//
//  Created by QINGWEI on 11/6/14.
//  Copyright (c) 2014 QINGWEI LAN. All rights reserved.
//

#import "RestaurantsTableViewController.h"
#import "MenuTableViewController.h"
#import "Restaurant.h"
#import "Kitchen.h"
#import "Entry.h"

@interface RestaurantsTableViewController ()

@end

@implementation RestaurantsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        
        // set the variables for [destinationViewController]
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSString *mealName = cell.textLabel.text;
        UITableViewHeaderFooterView *header = [self.tableView headerViewForSection:indexPath.section];
        NSString *restaurantName = header.textLabel.text;
        
        // prepare [segue destinationViewController] for segue
        if ([[segue destinationViewController] isKindOfClass:[MenuTableViewController class]]) {
            MenuTableViewController *menuDisplayVC = (MenuTableViewController *)[segue destinationViewController];
            menuDisplayVC.restaurantName = restaurantName;
            menuDisplayVC.mealName = mealName;
        }
    }
}

#pragma mark - UITableViewDataSource
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView :@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - DataDownload & DataHandling

/*
// returns a NSArray containing Restaurant objects which contain Kitchen objects which contain Entry objects
- (NSArray *)restaurantsWithEntryLinesForDate:(NSDate *)date forMeal:(NSString *)meal forRestaurant:(NSString *)restaurant
{
    NSMutableArray *restaurantsWithEntryLines = [[NSMutableArray alloc] init];

    NSString *menuURL = [self menuURLForDate:date forMeal:meal];
    NSError *error;
    NSString *menuString = [NSString stringWithContentsOfURL:[NSURL URLWithString:menuURL] encoding:NSUTF8StringEncoding error:&error];

    NSLog(@"menuString: %@", menuString);

    if (menuString) {
        if ([meal isEqualToString:@"Breakfast"]) {
            Restaurant *deNeve = [[Restaurant alloc] init];
            Restaurant *bruinPlate = [[Restaurant alloc] init];
            deNeve.name = @"De Neve";
            bruinPlate.name = @"Bruin Plate";
            deNeve.meal = meal;
            bruinPlate.meal = meal;
            NSMutableArray *deNeveKitchens = [[NSMutableArray alloc] init];
            NSMutableArray *bruinPlateKitchens = [[NSMutableArray alloc] init];

            NSString *currentCategory;
            NSString *categoryStartIndicator = @"<li class=\"category";
            NSString *categoryEndIndicator = @"</ul>";
            NSRange categoryStartRange;
            NSRange categoryEndRange;
            Kitchen *currentKitchen = [[Kitchen alloc] init];

            while ([menuString containsString:categoryStartIndicator]) {
                categoryStartRange = [menuString rangeOfString:categoryStartIndicator];
                menuString = [menuString substringFromIndex:categoryStartRange.location];
                categoryEndRange = [menuString rangeOfString:categoryEndIndicator];
                currentCategory = [menuString substringToIndex:categoryEndRange.location];

                currentKitchen = [self entryLinesForCurrentKitchenOfMenuString:currentCategory];

                if ([currentKitchen.name isEqualToString:@"Hot Cereals"] && ![deNeveKitchens containsObject:currentKitchen]) {
                    [deNeveKitchens addObject:currentKitchen];
                } else if ([currentKitchen.name isEqualToString:@"Hot Cereals"]) {
                    [bruinPlateKitchens addObject:currentKitchen];
                } else if ([deNeveBreakfastKitchens containsObject:currentKitchen.name] && [restaurant isEqualToString:@"De Neve"]) {
                    [deNeveKitchens addObject:currentKitchen];
                } else if ([bruinPlateBreakfastKitchens containsObject:currentKitchen.name] && [restaurant isEqualToString:@"Bruin Plate"]) {
                    [bruinPlateKitchens addObject:currentKitchen];
                }
            }

            deNeve.kitchens = deNeveKitchens;
            bruinPlate.kitchens = bruinPlateKitchens;
            [restaurantsWithEntryLines addObject:deNeve];
            [restaurantsWithEntryLines addObject:bruinPlate];
        } else if ([meal isEqualToString:@"Lunch"] || [meal isEqualToString:@"Dinner"]) {
            Restaurant *deNeve = [[Restaurant alloc] init];
            Restaurant *bruinPlate = [[Restaurant alloc] init];
            Restaurant *covel = [[Restaurant alloc] init];
            Restaurant *feast = [[Restaurant alloc] init];
            deNeve.name = @"De Neve";
            bruinPlate.name = @"Bruin Plate";
            covel.name = @"Covel";
            feast.name = @"FEAST at Rieber";



            [restaurantsWithEntryLines addObject:deNeve];
            [restaurantsWithEntryLines addObject:bruinPlate];
            [restaurantsWithEntryLines addObject:covel];
            [restaurantsWithEntryLines addObject:feast];
        }
    }

    return restaurantsWithEntryLines;
}
// converts entryLines into objects of Entry
- (void)convertEntryLinesToEntriesOfKitchen:(Kitchen *)kitchen
{
    if ([kitchen.entries count])
    {
        NSMutableArray *kitchenOfEntries = [[NSMutableArray alloc] init];
        for (int i = 0; i < [kitchen.entries count]; i++) {
            if (kitchen.entries[i]) {
                Entry *currentEntry = [self entryForEntryLine:kitchen.entries[i]];
                [kitchenOfEntries addObject:currentEntry];
            }
        }

        kitchen.entries = kitchenOfEntries;
    }
}
// converts a line of menuString into an object Entry
- (Entry *)entryForEntryLine:(NSString *)entryLine
{
    Entry *currentEntry = [[Entry alloc] init];

    NSString *entry;
    NSString *startIndicator = @";\">";
    NSString *endIndicator = @"</a>";
    NSRange startRange;
    NSRange endRange;

    if ([entryLine containsString:@"Vegan"]) {
        currentEntry.dietType = @"Vegan";
    } else if ([entryLine containsString:@"Vegetarian"]) {
        currentEntry.dietType = @"Vegetarian";
    } else {
        currentEntry.dietType = @"Normal";
    }

    if ([entryLine containsString:startIndicator]) {
        startRange = [entryLine rangeOfString:startIndicator];
        entryLine = [entryLine substringFromIndex:startRange.location + startRange.length];
        endRange = [entryLine rangeOfString:endIndicator];
        entry = [entryLine substringToIndex:endRange.location];
        currentEntry.nameOfEntry = entry;
    }

    return currentEntry;
}
// converts a category of menuString into an object Kitchen, with NSArray *entries consisting of entryLines of a category
- (Kitchen *)entryLinesForCurrentKitchenOfMenuString:(NSString *)splitMenuString
{
    Kitchen *currentKitchen = [[Kitchen alloc] init];
    NSMutableArray *kitchenEntries = [[NSMutableArray alloc] init];

    NSString *startIndicator = @"<li class=";
    NSString *endIndicator = @"</li>";
    NSRange nameStartRange = [splitMenuString rangeOfString:startIndicator];
    splitMenuString = [splitMenuString substringFromIndex:nameStartRange.location + nameStartRange.length + 12];
    NSRange nameEndRange = [splitMenuString rangeOfString:endIndicator];
    currentKitchen.name = [splitMenuString substringToIndex:nameEndRange.location];
    splitMenuString = [splitMenuString substringFromIndex:nameEndRange.location + nameEndRange.length];

    NSRange entryLineStartRange;
    NSRange entryLineEndRange;
    NSString *currentLine;

    while ([splitMenuString containsString:startIndicator]) {
        entryLineStartRange = [splitMenuString rangeOfString:startIndicator];
        splitMenuString = [splitMenuString substringFromIndex:entryLineStartRange.location];
        entryLineEndRange = [splitMenuString rangeOfString:endIndicator];
        currentLine = [splitMenuString substringToIndex:entryLineEndRange.location + entryLineEndRange.length];
        [kitchenEntries addObject:currentLine];
        splitMenuString = [splitMenuString substringFromIndex:entryLineEndRange.location + entryLineEndRange.length];
    }

    currentKitchen.entries = kitchenEntries;
    return currentKitchen;
}
// returns the menuURL for a date and meal, in format NSString
- (NSString *)menuURLForDate:(NSDate *)date forMeal:(NSString *)meal
{
    NSString *menuURL;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSInteger year = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger month = [[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger day = [[formatter stringFromDate:date] integerValue];

    NSString *mealCode;
    if ([meal isEqualToString:@"Breakfast"]) {
        mealCode = @"1";
    } else if ([meal isEqualToString:@"Lunch"]) {
        mealCode = @"2";
    } else if ([meal isEqualToString:@"Dinner"]) {
        mealCode = @"3";
    }

    NSString *separator = @"%2F";

    menuURL = [NSString stringWithFormat:@"http://menu.ha.ucla.edu/foodpro/default.asp?date=%ld%@%ld%@%ld&meal=%@&threshold=2", month, separator, day, separator, year, mealCode];

    return menuURL;
}
*/
 
@end
