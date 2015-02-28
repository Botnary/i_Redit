//
//  ArticleNSViewController.m
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-06.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import "ArticleNSViewController.h"
#import "TableCellController.h"
#include "WAYTheDarkSide.h"
#include "RArticle.h"
#include "RCategory.h"
#include "RedditOAuth.h"

@interface ArticleNSViewController ()

@end

@implementation ArticleNSViewController

@synthesize articles, webView, articleTableView, articleScrolleView, redditAPI;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    redditAPI = [[RedditApi alloc]init];
    articles = [[NSMutableArray alloc] init];
    //[self initArticles];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSubRedditSelected:) name:@"onSubRedditSelected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFetchArticlesOK:) name:@"onFetchArticlesOK" object:nil];
    
}

-(void)initArticles{
    articles = [[NSMutableArray alloc] init];
    /*
    for (int i = 0; i < 30; i++) {
        NSString *label = [[NSString alloc]initWithFormat:@"Article headline %d",i];
        NSURL *url = [[NSURL alloc]initWithString:@"http://cdn.wallwuzz.com/uploads/game-wallpaper-desktop-wallpapers-games-imagepages-war-images-god-wallwuzz-hd-wallpaper-13506.jpg"];
        [articles addObject:[self createCellWithText:label andImage:url]];
    }
     */
}


-(TableCellController *)createCellWithText:(NSString *) text andImage:(NSURL *)url{
    TableCellController *ctrl = [[TableCellController alloc]initWithText:text andImageUrl:url];
    return ctrl;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return articles.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    RArticle *article = (RArticle *)[articles objectAtIndex:row];
    NSTextField *label = [[NSTextField alloc]init];
    if(article.title == nil){
        label.stringValue = @"Title is nill";
    }else{
        label.stringValue = article.title;
    }
    TableCellController * ctrl = [[TableCellController alloc]initWithText:label.stringValue andImageUrl:[[NSURL alloc]initWithString:article.imageURL]];
    NSLog(@"%f",ctrl.view.frame.size.height);
    return ctrl.view;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    // compute and return row height
    //TableCellController * ctrl = [articles objectAtIndex:row];
    //return ctrl.view.frame.size.height;
    return 46.0f;
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)row{
    RArticle *article = (RArticle *)[articles objectAtIndex:row];
    [webView setMainFrameURL:article.url];
    return YES;
}

-(IBAction)onAuthButonClicked:(NSButton *)sender{
    [self performSegueWithIdentifier:@"ReditBrowser" sender:self];
}

-(void)authorisationWith:(NSString *)code{
    RedditOAuth *api = [[RedditOAuth alloc]init];
    [api tokenRequest:code];
}

-(void)onSubRedditSelected:(NSNotification*)note{
    NSLog(@"Got notified: %@", note);
    RCategory *category = (RCategory *)[note object];
    NSString *token =[[NSUserDefaults standardUserDefaults] stringForKey:@"reddit_access_token"];
    if (token == nil) {
        token = @"";
    }
    [redditAPI subRedditArticles:token andSubReditName:category.uri];
}

-(void)onFetchArticlesOK:(NSNotification*)note{
    articles = (NSMutableArray *)[note object];
    [articleTableView reloadData];
}
@end
