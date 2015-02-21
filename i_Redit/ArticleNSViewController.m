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
    NSLog(@"%@",articles);
}

-(void)initArticles{
    articles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
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
    return 46.0f;
}
- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex{
    NSLog(@"Selected %ld",(long)rowIndex);
    TableCellController * ctrl = [articles objectAtIndex:rowIndex];
    [webView setMainFrameURL:[[NSString alloc]initWithFormat:@"http://google.com/?q=%@",ctrl.headline]];
    return YES;
}
@end
