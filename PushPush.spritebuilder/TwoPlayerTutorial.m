//
//  TwoPlayerTutorial.m
//  PushPush
//
//  Created by Luke Solomon on 8/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "TwoPlayerTutorial.h"

@implementation TwoPlayerTutorial {
    
//    CCLabelTTF *P1Label;
//    CCLabelTTF *P2Label;
//    CCButton *P1Button;
//    CCButton *P2Button;
//    CCNodeGradient *CenterGradient;
    
    BOOL player1Ready;
    BOOL player2Ready;
    
}

- (void) didLoadFromCCB {
    player1Ready = FALSE;
    player2Ready = FALSE;
}

- (void) P1ButtonReady {
    
    if (player1Ready == FALSE){
        player1Ready = TRUE;
    } else if (player1Ready == TRUE){
        player1Ready = FALSE;
    }
    [self nextSceneCheck ];
}

- (void) P2ButtonReady {
    
    if (player2Ready == FALSE){
        player2Ready = TRUE;
    } else if (player2Ready == TRUE){
        player2Ready = FALSE;
    }
    [self nextSceneCheck ];
}

- (void) nextSceneCheck {
    
    if (player1Ready == TRUE && player2Ready == TRUE) {
        
        CCScene *TutorialPartTwoScene = [CCBReader loadAsScene:@"TutorialPartTwo"];
        [[CCDirector sharedDirector] replaceScene:TutorialPartTwoScene];
    }
}

@end
