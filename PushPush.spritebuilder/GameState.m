//
//  GameState.m
//  PushPush
//
//  Created by Luke Solomon on 7/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameState.h"

@implementation GameState {
    
}


+ (instancetype)sharedInstance {
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^ { _sharedObject = [[self alloc]init]; });
    
    // returns the same object each time
    return _sharedObject;
    
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
    //initialize the colors
}

@end
