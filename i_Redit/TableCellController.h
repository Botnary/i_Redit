//
//  TableCellController.h
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-07.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TableCellController : NSViewController{
    NSString *headline;
    NSURL *imageUrl;
}
@property(nonatomic, retain) IBOutlet NSImageView *cover;
@property(nonatomic, retain) IBOutlet NSTextField *lable;

-(id)initWithText:(NSString *) text andImageUrl:(NSURL *)url;
-(NSString *)headline;
-(NSURL *)imageUrl;
- (void) setHeadline: (NSString*)aHeadline;
- (void) setImageUrl: (NSURL*)aUrl;

@end
