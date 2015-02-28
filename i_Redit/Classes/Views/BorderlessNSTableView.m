//
//  BorderlessNSTableView.m
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-21.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import "BorderlessNSTableView.h"

@implementation BorderlessNSTableView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [self setIntercellSpacing:NSMakeSize(1,1)];
    // Drawing code here.
}

@end
