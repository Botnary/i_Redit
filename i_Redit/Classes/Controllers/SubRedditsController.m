//
//  SubRedditsController.m
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-21.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import "SubRedditsController.h"
#import "AFHTTPRequestOperation.h"
#include "AFHTTPRequestOperationManager.h"
#include "RCategory.h"


@implementation SubRedditsController

@synthesize reddits, redditsTableView, redditApi, redditOAuth;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTokenRequestSuccess:) name:@"onTokenRequestSuccess" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTokenRequestError:) name:@"onTokenRequestError" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFetchSubredditsOK:) name:@"onFetchSubredditsOK" object:nil];
    reddits = [[NSMutableArray alloc] init];
    redditApi = [[RedditApi alloc]init];
    redditOAuth = [[RedditOAuth alloc]init];
    NSString *refreshToken =[[NSUserDefaults standardUserDefaults] stringForKey:@"reddit_refresh_token"];
    if (refreshToken == nil) {
        refreshToken = @"";
    }
    [redditOAuth tokenRefreshRequest:refreshToken];
}

-(void)onTokenRequestError{
    NSLog(@"Token error");
    
}

-(void)onTokenRequestSuccess:(NSNotification*)note{
    NSLog(@"%@",note);
    [redditApi userSubreddits:[[NSUserDefaults standardUserDefaults] stringForKey:@"reddit_access_token"]];
}

-(void)onFetchSubredditsOK:(NSNotification*)note{
    reddits = (NSMutableArray *)[note object];
    [redditsTableView reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return reddits.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    RCategory *item = (RCategory *)[reddits objectAtIndex:row];
    NSTextField *label = [[NSTextField alloc]init];
    if(item.title == nil){
        label.stringValue = @"Title is nill";
    }else{
        label.stringValue = item.title;
    }
    return label;
    
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    // compute and return row height
    return 30.0f;
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex{
    NSLog(@"Selected %ld",(long)rowIndex);
    RCategory *item = (RCategory *)[reddits objectAtIndex:rowIndex];
    NSLog(@"%@ %@ %@", item.title,item.uri,item.cover);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onSubRedditSelected" object:item];
    return YES;
}
@end
