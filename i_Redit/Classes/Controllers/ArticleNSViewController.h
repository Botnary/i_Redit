//
//  ArticleNSViewController.h
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-06.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#include "RedditApi.h"

@interface ArticleNSViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>{
    
}
@property (nonatomic, retain) NSMutableArray *articles;
@property (nonatomic, retain) IBOutlet WebView *webView;
@property (nonatomic, retain) IBOutlet NSTableView *articleTableView;
@property (nonatomic, retain) IBOutlet NSScrollView *articleScrolleView;
@property (nonatomic, retain) RedditApi *redditAPI;

-(IBAction)onAuthButonClicked:(NSButton *)sender;
-(void)authorisationWith:(NSString *)code;
-(void)onSubRedditSelected:(NSNotification*)note;
-(void)onFetchArticlesOK:(NSNotification*)note;

@end
