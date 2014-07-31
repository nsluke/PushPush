//
//  GameState.h
//  PushPush
//
//  Created by Luke Solomon on 7/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCNode.h"

@interface GameState : NSObject

@property (nonatomic, assign) NSInteger p1Score;
@property (nonatomic, assign) NSInteger p2Score;
@property (nonatomic, assign) NSInteger wInteger;

@property (nonatomic, assign) CCColor *p1Color;
@property (nonatomic, assign) CCColor *p2Color;

@property (nonatomic, assign) bool colorsLoaded;

@property (nonatomic, assign) NSInteger gameMode;

@property (nonatomic, assign) float testFloat;

/*
 So this is going to store what game mode we're in. Currently:
 0 No game mode currently.
 1 Arcade
 2 Endless
 3 
 */


+ (instancetype)sharedInstance;

@end
