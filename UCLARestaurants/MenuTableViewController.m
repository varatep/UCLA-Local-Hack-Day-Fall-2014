//
//  MenuTableViewController.m
//  UCLARestaurants
//
//  Created by QINGWEI on 12/6/14.
//  Copyright (c) 2014 QINGWEI LAN. All rights reserved.
//

#import "MenuTableViewController.h"

@interface MenuTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) int numberOfKitchens;

// define  *** cell indentifier ***  for menu entries
#define MENU_CELL_IDENTIFIER @"Menu Cell"
// define  *** restaurant key ***  identifier
#define RESTAURANT_KEY @""
// define  *** meal key ***  identifier
#define MEAL_KEY @""
// define  *** kitchen key ***  identifier
#define KITCHEN_KEY @""
// define  *** entry key ***  indentifier
#define ENTRY_KEY @""

// define const for names
#define COVEL @"COVEL"
#define DE_NEVE @"DE NEVE"
#define BRUIN_PLATE @"BRUIN PLATE"
#define FEAST_AT_RIEBER @"FEAST AT RIEBER"
#define BREAKFAST @"Breakfast"
#define LUNCH @"Lunch"
#define DINNER @"Dinner"

@end

@implementation MenuTableViewController

@synthesize locationMapping = _locationMapping;
@synthesize foodItems = _foodItems;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self initLocations];
    NSLog(@"Meal : %@", self.mealName);
    NSLog(@"Restaurant : %@", self.restaurantName);
    
    // ***** SET TO WEEKDAY ******
    // implement weekends later
    self.isWeekday = true;
    self.numberOfKitchens = 0;
    
    [self loadItems];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadItems {
    NSURL *url = [NSURL URLWithString:@"http://menu.ha.ucla.edu/foodpro/default.asp?location=02&date=12%2F6%2F2014"];
    NSData *htmlData = [NSData dataWithContentsOfURL:url];
    
    TFHpple *parser = [TFHpple hppleWithHTMLData:htmlData];
    if ([self.mealName isEqualToString:BREAKFAST]) {
//        NSString *queryString = @"//td[@class='menugridcell']/ul/li/a";
        
        NSArray *parsedItems = [parser searchWithXPathQuery:queryString];
//        for (NSDictionary *unfiltered in parsedItems) {
////            NSDictionary *tmp = parsedItems;
//            NSString *food = [[NSString alloc] init];
//            food = [[[unfiltered objectForKey:@"nodeChildArray"] objectAtIndex:0] objectForKey:@"nodeContent"];
//        }
        
//        for (TFHppleElement *element in parsedItems) {
//            for (TFHppleElement *child in element.children) {
//                NSLog(child);
//            }
//        }
    }
//    NSString *queryString = @"";
    
}

- (void)initLocations {
    self.locationMapping = [[NSDictionary alloc] init];
    self.locationMapping = @{
                             @"DE NEVE" : @"01",
                             @"BRUIN PLATE" : @"02",
                             @"COVEL" : @"07",
                             @"FEAST AT RIEBER" : @"04"
                             };
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    // a more efficient method...
    /*
     
     
     
     */
    
    // FOR WEEKDAY
    if (self.isWeekday) {
        if ([self.restaurantName isEqualToString:COVEL]) {
            if ([self.mealName isEqualToString:LUNCH] || [self.mealName isEqualToString:DINNER]) {
                self.numberOfKitchens = 7;
                return 7;
            }
        } else if ([self.restaurantName isEqualToString:DE_NEVE]) {
            if ([self.mealName isEqualToString:BREAKFAST]) {
                self.numberOfKitchens = 7;
                return 7;
            }
            else if ([self.mealName isEqualToString:LUNCH] || [self.mealName isEqualToString:DINNER]) {
                self.numberOfKitchens = 8;
                return 8;
            }
        } else if ([self.restaurantName isEqualToString:BRUIN_PLATE]) {
            if ([self.mealName isEqualToString:BREAKFAST]) {
                self.numberOfKitchens = 8;
                return 8;
            }
            else if ([self.mealName isEqualToString:LUNCH] || [self.mealName isEqualToString:DINNER]) {
                self.numberOfKitchens = 9;
                return 9;
            }
        } else if ([self.restaurantName isEqualToString:FEAST_AT_RIEBER]) {
            if ([self.mealName isEqualToString:LUNCH] || [self.mealName isEqualToString:DINNER]) {
                self.numberOfKitchens = 8;
                return 8;
            }
        }
    }
    // FOR WEEKEND
    else {
        if ([self.restaurantName isEqualToString:COVEL]) {
            if ([self.mealName isEqualToString:LUNCH]) {
                self.numberOfKitchens = 9;
                return 9;
            }
            else if ([self.mealName isEqualToString:DINNER]) {
                self.numberOfKitchens = 7;
                return 7;
            }
        } else if ([self.restaurantName isEqualToString:DE_NEVE]) {
            if ([self.mealName isEqualToString:LUNCH]) {
                self.numberOfKitchens = 9;
                return 9;
            }
            else if ([self.mealName isEqualToString:DINNER]) {
                self.numberOfKitchens = 8;
                return 8;
            }
        } else if ([self.restaurantName isEqualToString:BRUIN_PLATE]) {
            if ([self.mealName isEqualToString:LUNCH] || [self.mealName isEqualToString:DINNER]) {
                self.numberOfKitchens = 9;
                return 9;
            }
        } else if ([self.restaurantName isEqualToString:FEAST_AT_RIEBER]) {
            if ([self.mealName isEqualToString:LUNCH] || [self.mealName isEqualToString:DINNER]) {
                self.numberOfKitchens = 8;
                return 8;
            }
        }
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            
            if ([self.kitchens[section] isKindOfClass:[NSDictionary class]]) {
                if ([[((NSDictionary *)self.kitchens[section]) objectForKey:@"meals"] isKindOfClass:[NSArray class]])
                    return [((NSArray *)[((NSDictionary *)self.kitchens[section]) objectForKey:@"meals"]) count];
            }
            break;
            
        default:
            return 0;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MENU_CELL_IDENTIFIER
                                                            forIndexPath:indexPath];
    if ([[((NSDictionary *)self.kitchens[indexPath.section]) objectForKey:@"meals"] isKindOfClass:[NSArray class]]) {
        NSArray *kitchen = [((NSDictionary *)self.kitchens[indexPath.section]) objectForKey:@"meals"];
        if ([kitchen[indexPath.row] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *entry = kitchen[indexPath.row];
            cell.textLabel.text = [entry objectForKey:@"name"];
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    switch (section) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            
            if ([self.kitchens[section] isKindOfClass:[NSDictionary class]]) {
                if ([[self.kitchens[section] objectForKey:@"name"] isKindOfClass:[NSString class]]) {
                    sectionName = (NSString *)[self.kitchens[section] objectForKey:@"name"];
                }
            }
            break;
            
        default:
            break;
    }
    
    return sectionName;
}


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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
