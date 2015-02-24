//
//  AnimatedCharacterSelectScene.m
//  PushPush
//
//  Created by Luke Solomon on 8/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "AnimatedCharacterSelectScene.h"
#import "GameState.h"
#import "Mixpanel.h"
#import "CCColor+rgbValue.h"

@implementation AnimatedCharacterSelectScene {
    
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
    //gradient color nodes (windicators)
    CCNodeGradient *MWD;
    CCNodeGradient *RWD;
    CCNodeGradient *LWD;
    
    //particles
    //upper particles
    CCParticleSystem *PUM;
    CCParticleSystem *PUL;
    CCParticleSystem *PUR;
    //lower particles
    CCParticleSystem *PDM;
    CCParticleSystem *PDR;
    CCParticleSystem *PDL;
    //corner particles
    CCParticleSystem *BRP;
    CCParticleSystem *BLP;
    CCParticleSystem *TRP;
    CCParticleSystem *TLP;
    
    //Color select buttons
    CCButton *black;
    CCButton *white;
    CCButton *violet;
    CCButton *indigo;
    CCButton *blue;
    CCButton *green;
    CCButton *yellow;
    CCButton *orange;
    CCButton *red;
    
    //CCLabels
    CCLabelTTF *pickLabel1;
    CCLabelTTF *pickLabel2;
    
    //select buttons
    CCButton *OnePButton;
    CCButton *TwoPButton;
    
    int toggle;
    
    CCColor *black1;
    CCColor *violet1;
    CCColor *indigo1;
    CCColor *blue1;
    CCColor *green1;
    CCColor *yellow1;
    CCColor *orange1;
    CCColor *red1;
    CCColor *white1;
    
}

- (id) init {
    self = [super init];
    if (self) {
    }
    return self;
}


// -------------------------------------------------------------------------------

- (void) didLoadFromCCB {
    
    //allow touches
    self.userInteractionEnabled = TRUE;
    
    //notifies the scene has loaded
    CCLOG(@"Scene Loaded");
    
    //set the toggle to 1
    toggle = 1;
    
    //select buttons
    /*
    if ([GameState sharedInstance].gameMode == 1) {
        
        OnePButton.visible = TRUE;
        TwoPButton.visible = FALSE;
        black.visible = FALSE;
        [GameState sharedInstance].p2Color = black1;
    
    } else if ([GameState sharedInstance].gameMode == 2) {
        
        OnePButton.visible = FALSE;
        TwoPButton.visible = TRUE;
        
    }
    */
    
    TwoPButton.visible = TRUE;
    
    //initialize the colors
    black1  = [CCColor colorWithRed:000.0f/255.0f
                              green:000.0f/255.0f
                               blue:000.0f/255.0f
                              alpha:1.0f];
    violet1 = [CCColor colorWithRed:127.0f/255.0f
                              green:000.0f/255.0f
                               blue:127.0f/255.0f
                              alpha:1.0f];
    indigo1 = [CCColor colorWithRed:000.0f/255.0f
                              green:000.0f/255.0f
                               blue:255.0f/255.0f
                              alpha:1.0f];
    blue1   = [CCColor colorWithRed:000.0f/255.0f
                              green:255.0f/255.0f
                               blue:255.0f/255.0f
                              alpha:1.0f];
    green1  = [CCColor colorWithRed:000.0f/255.0f
                              green:255.0f/255.0f
                               blue:000.0f/255.0f
                              alpha:1.0f];
    yellow1 = [CCColor colorWithRed:255.0f/255.0f
                              green:255.0f/255.0f
                               blue:000.0f/255.0f
                              alpha:1.0f];
    orange1 = [CCColor colorWithRed:255.0f/255.0f
                              green:165.0f/255.0f
                               blue:000.0f/255.0f
                              alpha:1.0f];
    red1    = [CCColor colorWithRed:255.0f/255.0f
                              green:000.0f/255.0f
                               blue:000.0f/255.0f
                              alpha:1.0f];
    white1  = [CCColor colorWithRed:255.0f/255.0f
                              green:255.0f/255.0f
                               blue:255.0f/255.0f
                              alpha:1.0f];
    
    [self loadColors];
    
}

// -------------------------------------------------------------------------------
// These are the methods that control the color selection screen. They all pass the setColor method a parameter

- (void) white {
    [self setColor :white1];
}
- (void) Red {
    [self setColor :red1];
}
- (void) Orange {
    [self setColor :orange1];
}
- (void) Yellow {
    [self setColor :yellow1];
}
- (void) Green {
    [self setColor :green1];
}
- (void) Blue {
    [self setColor :blue1];
}
- (void) Indigo {
    [self setColor :indigo1];
}
- (void) Violet {
    [self setColor :violet1];
}
- (void) Black {
    [self setColor :black1];
}


// -------------------------------------------------------------------------------
- (void) setColor:(CCColor *)theColor {
    
    //if ([self arePlayersSameColor] == false){
    if ([GameState sharedInstance].gameMode == 1) {
        
        [GameState sharedInstance].p1Color = theColor;
        [self loadColors];
        
    }
    if ([GameState sharedInstance].gameMode == 2) {
        if (toggle == 1) {
            
            [GameState sharedInstance].p1Color = theColor;
            [self loadColors];

        } else if (toggle == 2) {
            
            [GameState sharedInstance].p2Color = theColor;
            [self loadColors];

        }
        [self PlayerSelect];
    //}
    }
}

// -------------------------------------------------------------------------------
- (void) loadColors {
    
    if ([GameState sharedInstance].gameMode == 1 || toggle == 1) {
        
        //color nodes
        BottomLeftLine.color = [GameState sharedInstance].p1Color;
        BottomMidLine.color = [GameState sharedInstance].p1Color;
        BottomRightLine.color = [GameState sharedInstance].p1Color;
        
        //gradient color nodes (windicators)
        MWD.startColor = [GameState sharedInstance].p1Color;
        RWD.startColor = [GameState sharedInstance].p1Color;
        LWD.startColor = [GameState sharedInstance].p1Color;
        
        //particles
        PUM.startColor = [GameState sharedInstance].p1Color;
        PUM.endColor = [GameState sharedInstance].p1Color;
        PUL.startColor = [GameState sharedInstance].p1Color;
        PUL.endColor = [GameState sharedInstance].p1Color;
        PUR.startColor = [GameState sharedInstance].p1Color;
        PUR.endColor = [GameState sharedInstance].p1Color;
        
        TRP.startColor = [GameState sharedInstance].p1Color;
        TLP.startColor = [GameState sharedInstance].p1Color;
        
    } else if (toggle == 2) {
        
        //color nodes
        TopLeftLine.color = [GameState sharedInstance].p2Color;
        TopMidLine.color = [GameState sharedInstance].p2Color;
        TopRightLine.color = [GameState sharedInstance].p2Color;
        
        MWD.endColor = [GameState sharedInstance].p2Color;
        RWD.endColor = [GameState sharedInstance].p2Color;
        LWD.endColor = [GameState sharedInstance].p2Color;
        
        //particles
        PDM.startColor = [GameState sharedInstance].p2Color;
        PDM.endColor = [GameState sharedInstance].p2Color;
        PDR.startColor = [GameState sharedInstance].p2Color;
        PDR.endColor = [GameState sharedInstance].p2Color;
        PDL.startColor = [GameState sharedInstance].p2Color;
        PDL.endColor = [GameState sharedInstance].p2Color;
        
        //corner particles
        BRP.startColor = [GameState sharedInstance].p2Color;
        BLP.startColor = [GameState sharedInstance].p2Color;
        BRP.endColor = [GameState sharedInstance].p2Color;
        BLP.endColor = [GameState sharedInstance].p2Color;
        
        TRP.endColor = [GameState sharedInstance].p1Color;
        TLP.endColor = [GameState sharedInstance].p1Color;
    }
}

// -------------------------------------------------------------------------------
- (void) PlayerSelect {
    
    if ([GameState sharedInstance].gameMode == 1) {
        pickLabel1.string = @"PICK YOUR COLOR!";
    }
    
    else if ([GameState sharedInstance].gameMode == 2) {
        
        if (toggle == 1) {
            
            pickLabel1.string = @"";
            pickLabel2.string = @"PICK YOUR COLOR!";
            toggle = 2;
            
            //NSLog(@"toggle is now %d", toggle);
            
        } else if (toggle == 2) {
            
            pickLabel1.string = @"PICK YOUR COLOR!";
            pickLabel2.string = @"";
            toggle = 1;
            
            //NSLog(@"toggle is now %d", toggle);
        }
        
        [self rotater: black];
        [self rotater: white];
        [self rotater: violet];
        [self rotater: indigo];
        [self rotater: blue];
        [self rotater: green];
        [self rotater: orange];
        [self rotater: yellow];
        [self rotater: red];
    }
}

-(void) rotater: (CCButton*) whichButton {
    whichButton.rotation = whichButton.rotation+180;
}

// -------------------------------------------------------------------------------
- (BOOL) arePlayersSameColor {
    
    if ([GameState sharedInstance].p2Color == [GameState sharedInstance].p1Color) {
    
        pickLabel1.string = @"YOU CAN'T BOTH BE THE SAME COLOR!";
        pickLabel2.string = @"YOU CAN'T BOTH BE THE SAME COLOR!";
        
        TwoPButton.title = @"Fix your colors!";
        TwoPButton.userInteractionEnabled = FALSE;
        
        return true;
    } else {
        
        return false;
    }
}

- (void) TwoPButtonPush {
    
    CCScene *mainScene = [CCBReader loadAsScene:@"AnimatedMainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
    
    //OLD CODE!!!! IMPORTANT!!!!
    /*
    CCScene *endlessScene = [CCBReader loadAsScene:@"EndlessScene"];
    [[CCDirector sharedDirector] replaceScene:endlessScene];
    
    //[[CCDirector sharedDirector] replaceScene:[ZoomTransition CCTransitionWithDuration:1.0 scene:endlessScene]];
     */
        
    NSDictionary *colors = @{@"p1Color": [[GameState sharedInstance].p1Color rgbValue], @"p2color": [[GameState sharedInstance].p2Color rgbValue]};
    [[Mixpanel sharedInstance] track:@"Started Two-Player" properties: colors];

}

- (void) OnePButtonPush {
    CCScene *onePlayerScene = [CCBReader loadAsScene:@"OnePlayerScene"];
    [[CCDirector sharedDirector] replaceScene:onePlayerScene];
    //[[CCDirector sharedDirector] replaceScene:endlessScene withTransition:( *)];
}

@end
