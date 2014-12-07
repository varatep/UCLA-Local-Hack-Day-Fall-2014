//
//  Restaurant.h
//  UCLARestaurants
//
//  Created by QINGWEI on 11/7/14.
//  Copyright (c) 2014 QINGWEI LAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *meal;
@property (nonatomic, strong) NSArray *kitchens; // of objects Kitchen
@end
