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
#include "SubRedditsController.h"
#include "AFHTTPRequestOperationManager.h"
#include "RArticle.h"

@interface ArticleNSViewController ()

@end

@implementation ArticleNSViewController

@synthesize articles, webView, articleTableView, articleScrolleView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    // The application decided to join the dark side
    [articleTableView setBackgroundColor:[NSColor clearColor]];
    articleScrolleView.drawsBackground = NO;
    [[[[self view] window] contentView] setState:NSVisualEffectStateActive];
    [WAYTheDarkSide welcomeApplicationWithBlock:^{
        [[[self view] window] setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameVibrantDark]];
        [[[[self view] window] contentView] setMaterial:NSVisualEffectMaterialDark];
    } immediately:YES];

    [self initArticles];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSubRedditSelected:) name:@"onSubRedditSelected" object:nil];
    NSLog(@"%@",articles);
    //NSLog(@"%@",[self parseQueryString:@"about://blank/?state=abc&code=cCKQ-Y65LDTFTqTezIhNzh1wje8"]);
    //SubRedditsController *ctrl = [[SubRedditsController alloc]init];
}

-(void)initArticles{
    articles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 30; i++) {
        NSString *label = [[NSString alloc]initWithFormat:@"Article headline %d",i];
        NSURL *url = [[NSURL alloc]initWithString:@"http://cdn.wallwuzz.com/uploads/game-wallpaper-desktop-wallpapers-games-imagepages-war-images-god-wallwuzz-hd-wallpaper-13506.jpg"];
        [articles addObject:[self createCellWithText:label andImage:url]];
    }
}


-(TableCellController *)createCellWithText:(NSString *) text andImage:(NSURL *)url{
    TableCellController *ctrl = [[TableCellController alloc]initWithText:text andImageUrl:url];
    return ctrl;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return articles.count;
}
/*
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    return [articles objectAtIndex:rowIndex];
}
*/
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    TableCellController * ctrl = [articles objectAtIndex:row];
    return ctrl.view;
    
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    // compute and return row height
    TableCellController * ctrl = [articles objectAtIndex:row];
    return ctrl.view.frame.size.height;
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex{
    NSLog(@"Selected %ld",(long)rowIndex);
    TableCellController * ctrl = [articles objectAtIndex:rowIndex];
    [webView setMainFrameURL:[[NSString alloc]initWithFormat:@"http://google.com/?q=%@",ctrl.headline]];
    return YES;
}

-(IBAction)onAuthButonClicked:(NSButton *)sender{
        [self performSegueWithIdentifier:@"ReditBrowser" sender:self];
}

-(void)authorisationWith:(NSString *)code{
    NSLog(@"Test set %@",code);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"Android app by /u/iamfromk" forHTTPHeaderField:@"User-Agent"];
    NSData *authPass = [@"sCn233gDaZPyAg:" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *basicAuth = [[NSString alloc]initWithFormat:@"Basic %@",[authPass base64EncodedStringWithOptions:0]];
    [manager.requestSerializer setValue:basicAuth forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *params = @{@"grant_type": @"authorization_code",
                             @"code": code,
                             @"redirect_uri": @"about://blank"};
    [manager POST:@"https://www.reddit.com/api/v1/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"access_token"] forKey:@"access_token"];
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"expires_in"] forKey:@"expires_in"];
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"refresh_token"] forKey:@"refresh_token"];
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token_type"] forKey:@"token_type"];
        [[NSUserDefaults standardUserDefaults] setObject:code forKey:@"auth_code"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

-(void)onSubRedditSelected:(NSNotification*)note{
    NSLog(@"Got notified: %@", note);
}

@end
