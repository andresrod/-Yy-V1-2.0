//
//  Burger.m
//  corral1
//
//  Created by Andres Rodriguez on 12-12-21.
//  Copyright (c) 2012 yummy. All rights reserved.
//

#import "Burger.h"

@implementation Burger

-(id)initWithLettuce:(BOOL)lettuce
            tomatoe :(BOOL)tomatoe {
    self = [super init];
    if (self) {
        _lettuce = lettuce;
        _tomatoe = tomatoe;
        _itemType = @"Burger";
        return self;
    }
    return nil;
}

@end
