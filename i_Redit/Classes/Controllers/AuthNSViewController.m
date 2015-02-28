//
//  AuthNSViewController.m
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-22.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import "AuthNSViewController.h"
#include "ArticleNSViewController.h"
#include "URLHelper.h"
#include "RedditOAuth.h"

@interface AuthNSViewController ()

@end

@implementation AuthNSViewController

@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    RedditOAuth *api = [[RedditOAuth alloc]init];
    [webView setMainFrameURL:[api requestAuthorisationURL]];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame{
    NSString *currentURL = [[[[frame dataSource] request] URL] absoluteString];
    BOOL existsReddit = [currentURL localizedCaseInsensitiveContainsString:@"about"];
    BOOL existsAauthorize = [currentURL localizedCaseInsensitiveContainsString:@"authorize"];
    if(existsReddit && !existsAauthorize){
        URLHelper *urlHelper = [[URLHelper alloc]init];
        NSDictionary *query = [urlHelper parseQueryString:currentURL];
        [(ArticleNSViewController*)self.presentingViewController authorisationWith:query[@"code"]];
        [self dismissViewController:self];
        [self.presentingViewController dismissViewController:self];
    }
}
@end
