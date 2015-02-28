//
//  RCategory.m
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-24.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import "RCategory.h"

@implementation RCategory
@synthesize title,descr,uri,cover;

-(id)initWithTitle:(NSString *)aTitle  andUri:(NSString *)aUri andDescr:(NSString *)aDescr andCover:(NSString *)aCover{
    if ( self = [super init] )
    {
        self.title = aTitle;
        self.uri = aUri;
        self.descr = aDescr;
        self.cover = aCover;
    }
    return self;
}

@end
