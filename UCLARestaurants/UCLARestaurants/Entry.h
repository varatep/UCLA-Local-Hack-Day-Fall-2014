//
//  Entry.h
//  UCLARestaurants
//
//  Created by QINGWEI on 11/6/14.
//  Copyright (c) 2014 QINGWEI LAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject
@property (nonatomic, strong) NSString *nameOfEntry;
// includes: Vegetarian, Vegan, Normal
@property (nonatomic, strong) NSString *dietType;
@property (nonatomic, strong) NSString *entryDetails;
@end