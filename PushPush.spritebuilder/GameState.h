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

@property (nonatomic) NSInteger p1Score;
@property (nonatomic) NSInteger p2Score;
@property (nonatomic) NSInteger wInteger;

@property (nonatomic) bool colorsLoaded;

@property (nonatomic) NSInteger gameMode;
/*
 So this is going to store what game mode we're in. Currently:
 0 No game mode currently.
 1: 1 Player
 2: 2 Player
 */

@property (nonatomic, strong) CCColor *p1Color;
@property (nonatomic, strong) CCColor *p2Color;

@property (nonatomic, strong) CCColor *black1;
@property (nonatomic, strong) CCColor *violet1;
@property (nonatomic, strong) CCColor *indigo1;
@property (nonatomic, strong) CCColor *blue1;
@property (nonatomic, strong) CCColor *green1;
@property (nonatomic, strong) CCColor *yellow1;
@property (nonatomic, strong) CCColor *orange1;
@property (nonatomic, strong) CCColor *red1;
@property (nonatomic, strong) CCColor *white1;

+ (instancetype)sharedInstance;

@end
