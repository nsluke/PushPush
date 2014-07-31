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

@property (nonatomic, assign) bool colorsLoaded;


@property (nonatomic, assign) NSInteger gameMode;
/*
 So this is going to store what game mode we're in. Currently:
 0 No game mode currently.
 1 Arcade
 2 Endless
 3
 */

//Not really being used yet
@property (nonatomic, strong) CCColor *p1Color;
@property (nonatomic, strong) CCColor *p2Color;



+ (instancetype)sharedInstance;

@end
