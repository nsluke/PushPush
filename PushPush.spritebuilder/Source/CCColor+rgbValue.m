//
//  CCColor+rgbValue.m
//  PushPush
//
//  Created by Luke Solomon on 2/23/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCColor+rgbValue.h"

@implementation CCColor(rgbValue)

-(NSString*) rgbValue {
    float r, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    r *= 255;
    g *= 255;
    b *= 255;
    return [NSString stringWithFormat:@"RGBA(%0f, %0f, %0f, %0f)", r, g, b, a];
}

@end
