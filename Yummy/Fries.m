//
//  Fries.m
//  corral1
//
//  Created by Andres Rodriguez on 12-12-26.
//  Copyright (c) 2012 yummy. All rights reserved.
//

#import "Fries.h"

@implementation Fries

-(id)initWithSalt:(BOOL)salt
            pepper :(BOOL)pepper
            size : (NSString*) size{
    self = [super init];
    if (self) {
        _salt = salt;
        _pepper = pepper;
        _itemType = @"Fries";
        _size = size;
        return self;
    }
    return nil;
}


@end
