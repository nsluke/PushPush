//
//  IntroScene.m
//  PushPush
//
//  Created by Luke Solomon on 7/8/14.
//  Copyright Luke Solomon 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "HelloWorldScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f]];
    [self addChild:background];
    
    // 1st Push
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Push" fontName:@"Verdana" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor blueColor];
    label.position = ccp(.4f, 0.6f); // left of Middle of screen
    [self addChild:label];
    
    // 1st Push
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Push" fontName:@"Verdana" fontSize:36.0f];
    label2.positionType = CCPositionTypeNormalized;
    label2.color = [CCColor redColor];
    label2.position = ccp(.6f, 0.4f); // right of Middle of screen
    [self addChild:label2];
    
    
    // Start button
    CCButton *helloWorldButton = [CCButton buttonWithTitle:@"[ Start ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    helloWorldButton.positionType = CCPositionTypeNormalized;
    helloWorldButton.position = ccp(0.5f, 0.5f);
    helloWorldButton.color = [CCColor blackColor];
    [helloWorldButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:helloWorldButton];

    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[HelloWorldScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
