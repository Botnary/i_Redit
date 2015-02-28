//
//  SubRedditsController.h
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-21.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "RedditApi.h"
#include "RedditOAuth.h"

@interface SubRedditsController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>
@property (nonatomic, retain) NSMutableArray *reddits;
@property (nonatomic, retain) IBOutlet NSTableView *redditsTableView;
@property (nonatomic, retain) RedditApi *redditApi;
@property (nonatomic, retain) RedditOAuth *redditOAuth;

-(void)onTokenRequestSuccess:(NSNotification*)note;
-(void)onFetchSubredditsOK:(NSNotification*)note;
-(void)onTokenRequestError;
@end
