//
//  Kitchen.h
//  UCLARestaurants
//
//  Created by QINGWEI on 11/7/14.
//  Copyright (c) 2014 QINGWEI LAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Kitchen : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nameOfRestaurantBelonged;
@property (nonatomic, strong) NSArray *entries; // of objects Entry
@end
