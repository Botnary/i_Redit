//
//  GrayNSView.m
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-18.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import "GrayNSView.h"
#include "ColorHelper.h"

@implementation GrayNSView

- (void)drawRect:(NSRect)dirtyRect {
    
    // add a background colour
    ColorHelper *helper = [[ColorHelper alloc]init];
    [[helper colorWithHexColorString:@"f6f6f6"] setFill];
    NSRectFill(dirtyRect);

    [super drawRect:dirtyRect];   
    // Drawing code here.
}



@end
