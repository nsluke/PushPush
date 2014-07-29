//
//  GameState.h
//  PushPush
//
//  Created by Luke Solomon on 7/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameState : NSObject

@property (nonatomic, assign) NSInteger p1Score;
@property (nonatomic, assign) NSInteger p2Score;
@property (nonatomic, assign) NSInteger wInteger;

@property (nonatomic, assign) CCColor *p1Color;
@property (nonatomic, assign) CCColor *p2Color;

@property (nonatomic, assign) bool colorsLoaded;

+ (instancetype)sharedInstance;

@end
