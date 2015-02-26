//
//  LeftBarNSView.m
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-19.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import "LeftBarNSView.h"
#include "ColorHelper.h"

@implementation LeftBarNSView

- (void)drawRect:(NSRect)dirtyRect {
    
    ColorHelper *helper = [[ColorHelper alloc]init];
    [[helper colorWithHexColorString:@"5fc5cf"] setFill];
    NSRectFill(dirtyRect);

    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
