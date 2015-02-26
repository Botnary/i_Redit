//
//  TableCellController.m
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-07.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import "TableCellController.h"
#import "GrayNSView.h"
@interface TableCellController ()

@end

@implementation TableCellController

@synthesize cover,lable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    NSImage *image = [[NSImage alloc]initWithContentsOfURL:self.imageUrl];
    if(!image){
        NSLog(@"cant init image");
    }
    [cover setImage:image];
    [lable setStringValue:self.headline];
}

-(id)initWithText:(NSString *) text andImageUrl:(NSURL *)url{
    if ( self = [super init] )
    {
        [self setHeadline:text];
        [self setImageUrl:url];        
    }
    return self;
}

-(NSString *)headline{
    return headline;
}
-(NSURL *)imageUrl{
    return imageUrl;
}
- (void) setHeadline: (NSString*)aHeadline{
    headline = aHeadline;
}
- (void) setImageUrl: (NSURL*)aUrl{
    imageUrl = aUrl;
}

@end
