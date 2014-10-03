//
//  Unit.h
//  Prismatadex
//
//  Created by Ritchie Bui on 2014-10-03.
//  Copyright (c) 2014 Ritchie Bui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Unit : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger cost;
@property (nonatomic) NSInteger health;
@property (nonatomic) NSString *status;
@property (nonatomic) NSInteger supply;
@property (nonatomic) Boolean blocker;
@property (nonatomic) NSString *activeAbility;
@property (nonatomic) NSString *passiveAbility;
@property (nonatomic) NSString *details;

@end
