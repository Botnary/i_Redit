//
//  RedditApi.m
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-25.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import "RedditApi.h"
#include "AFHTTPRequestOperationManager.h"
#include "RCategory.h"
#include "RArticle.h"

NSString *const REDDIT_URL = @"https://www.reddit.com";
NSString *const REDDIT_AUTH_URL = @"https://www.reddit.com/api/v1/authorize";
NSString *const REDDIT_REQUEST_TOKEN_URL = @"https://www.reddit.com/api/v1/access_token";
NSString *const REDDIT_BOT_NAME = @"App by /u/iamfromk";
NSString *const REDDIT_CALL_BACK_URL = @"about://blank";
NSString *const REDDIT_SCOPE = @"read mysubreddits";
NSString *const REDDIT_API_URI = @"https://oauth.reddit.com";

@implementation RedditApi

-(void)userSubreddits:(NSString *)token{
    NSString *baseAuth = [[NSString alloc]initWithFormat:@"bearer %@",token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:REDDIT_BOT_NAME forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:baseAuth forHTTPHeaderField:@"Authorization"];
    NSString *requestURL = [[NSString alloc]initWithFormat:@"%@/subreddits/mine/subscriber.json?limit=100",REDDIT_API_URI];
    [manager GET:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response statusCode] != 401) {
            NSMutableArray *categories = [[NSMutableArray alloc]init];
            long total = [[[responseObject objectForKey: @"data"] objectForKey:@"children"] count];
            for (int i = 0; i < total; i++) {
                id obj = responseObject[@"data"][@"children"][i];
                [categories addObject:[[RCategory alloc]initWithTitle:obj[@"data"][@"display_name"] andUri:obj[@"data"][@"url"] andDescr:obj[@"data"][@"public_description"] andCover:obj[@"data"][@"header_img"]]];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onFetchSubredditsOK" object:categories];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onFetchSubredditsFail" object:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"onFetchSubredditsFail" object:nil];
    }];
}

-(void)subRedditArticles:(NSString *)token andSubReditName:(NSString *)uri{
    //NSString *baseAuth = [[NSString alloc]initWithFormat:@"bearer %@",token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //[manager.requestSerializer setValue:REDDIT_BOT_NAME forHTTPHeaderField:@"User-Agent"];
    //[manager.requestSerializer setValue:baseAuth forHTTPHeaderField:@"Authorization"];
    NSString *requestURL = [[NSString alloc]initWithFormat:@"%@%@hot.json?limit=100",REDDIT_URL,uri];
    [manager GET:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response statusCode] != 401) {
            NSMutableArray *articles = [[NSMutableArray alloc]init];
            long total = [[[responseObject objectForKey: @"data"] objectForKey:@"children"] count];
            for (int i = 0; i < total; i++) {
                id obj = responseObject[@"data"][@"children"][i];
                [articles addObject:[[RArticle alloc]initWithTitle:obj[@"data"][@"title"] andUri:obj[@"data"][@"url"] andDescr:obj[@"data"][@"selftext_html"] andImage:obj[@"data"][@"thumbnail"]]];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onFetchArticlesOK" object:articles];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onFetchArticlesFail" object:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"onFetchArticlesFail" object:nil];
    }];
}

@end
