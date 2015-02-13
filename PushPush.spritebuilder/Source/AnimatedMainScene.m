//
//  AnimatedMainScene.m
//  PushPush
//
//  Created by Luke Solomon on 8/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "AnimatedMainScene.h"
#import "GameState.h"
#import "AnimatedCharacterSelectScene.h"

@implementation AnimatedMainScene {
    
    CCLabelTTF *TopPushLabel;
    CCLabelTTF *BottomPushLabel;
    
    //The container nodes
    CCNode *_Middle;
    CCNode *_Right;
    CCNode *_Left;
    
    //color nodes
    CCNodeColor *TopLeftLine;
    CCNodeColor *TopMidLine;
    CCNodeColor *TopRightLine;
    CCNodeColor *BottomLeftLine;
    CCNodeColor *BottomMidLine;
    CCNodeColor *BottomRightLine;
    
    //buttons
    CCButton *moreGames;
}

- (void) didLoadFromCCB {
    if ([GameState sharedInstance].p1Color == NULL) {
        [GameState sharedInstance].p1Color = [CCColor colorWithRed:255.0f/255.0f
                                                             green:255.0f/255.0f
                                                              blue:255.0f/255.0f
                                                             alpha:1.0f];;
    }
    
    if ([GameState sharedInstance].p2Color == NULL) {
        [GameState sharedInstance].p2Color = [CCColor colorWithRed:127.0f/255.0f
                                                             green:000.0f/255.0f
                                                              blue:127.0f/255.0f
                                                             alpha:1.0f];
    }
    [self loadColors];
}

- (void) onePlayer {
    [GameState sharedInstance].gameMode = 1;
    CCScene *countDown = [CCBReader loadAsScene:@"CountDownTimer2"];
    [[CCDirector sharedDirector] replaceScene:countDown];
}


- (void) twoPlayer {
    [GameState sharedInstance].gameMode = 2;
    CCScene *countDown = [CCBReader loadAsScene:@"CountDownTimer2"];
    [[CCDirector sharedDirector] replaceScene:countDown];
}

- (void) TutorialPush {
    //[GameState sharedInstance].gameMode = 2;
    CCScene *TwoPlayerTutorialScene = [CCBReader loadAsScene:@"TutorialPartTwo"];
    [[CCDirector sharedDirector] replaceScene:TwoPlayerTutorialScene];
    
}

- (void) changeColors {
    [GameState sharedInstance].gameMode = 2;
    CCScene *animatedCharSelectScene = [CCBReader loadAsScene:@"AnimatedCharacterSelectScene"];
    [[CCDirector sharedDirector] replaceScene:animatedCharSelectScene];
}

- (void) moreGames {
    
    moreGames.title = @"COMING SOON!";
    
}

- (void) loadColors {
    
    //color nodes
    TopLeftLine.color = [GameState sharedInstance].p2Color;
    TopMidLine.color = [GameState sharedInstance].p2Color;
    TopRightLine.color = [GameState sharedInstance].p2Color;
    BottomLeftLine.color = [GameState sharedInstance].p1Color;
    BottomMidLine.color = [GameState sharedInstance].p1Color;
    BottomRightLine.color = [GameState sharedInstance].p1Color;
    
    //labels
    TopPushLabel.color = [GameState sharedInstance].p1Color;
    BottomPushLabel.color = [GameState sharedInstance].p2Color;
    
}


@end