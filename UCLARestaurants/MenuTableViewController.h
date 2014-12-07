//
//  MenuTableViewController.h
//  UCLARestaurants
//
//  Created by QINGWEI on 12/6/14.
//  Copyright (c) 2014 QINGWEI LAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"
#import "constants.h"
#import "TFHppleElement.h"
@interface MenuTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *kitchens;
@property (nonatomic, strong) NSString *restaurantName;
@property (nonatomic, strong) NSString *mealName;
@property (nonatomic) BOOL isWeekday;

@property (nonatomic, strong) NSArray *foodItems;

@property (nonatomic, strong) NSDictionary *locationMapping;

@end
