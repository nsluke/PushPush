//
//  GameOver.m
//  PushPush
//
//  Created by Luke Solomon on 7/22/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameOver.h"

@implementation GameOver {
    CCLabelTTF *p1Label;
    CCLabelTTF *p2Label;
}

-(id) init {
    self = [super init];
    if (self) {

    }
    return self;
}


- (void) didLoadFromCCB {
    
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    
    p1Label.string = @"1";
    p2Label.string = @"0";
    
}

@end
