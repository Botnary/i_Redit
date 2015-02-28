//
//  RArticle.m
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-24.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import "RArticle.h"

@implementation RArticle
@synthesize title,url,descr,imageURL;

-(id)initWithTitle:(NSString *)aTitle andUri:(NSString *) aUri andDescr:(NSString *) aDescr andImage:(NSString *) aImage{
    if ( self = [super init] )
    {
        self.title = aTitle;
        self.url = aUri;
        self.descr = aDescr;
        self.imageURL = aImage;
    }
    return self;
}

@end
