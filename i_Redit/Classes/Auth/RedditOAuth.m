//
//  RedditOAuth.m
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-25.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import "RedditOAuth.h"
#include "RedditApi.h"
#include "AFHTTPRequestOperationManager.h"

@implementation RedditOAuth

-(NSString *)requestAuthorisationURL{
    return [[NSString alloc]initWithFormat:@"%@?client_id=%@&response_type=code&state=abc&redirect_uri=%@&duration=permanent&scope=%@",REDDIT_AUTH_URL,REDDIT_APP,REDDIT_CALL_BACK_URL,REDDIT_SCOPE];
}

-(void)tokenRequest:(NSString *)authCode{
    NSData *authPass = [[[NSString alloc]initWithFormat:@"%@:",REDDIT_APP] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *basicAuth = [[NSString alloc]initWithFormat:@"Basic %@",[authPass base64EncodedStringWithOptions:0]];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:REDDIT_BOT_NAME forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:basicAuth forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *params = @{@"grant_type": @"authorization_code",
                             @"code": authCode,
                             @"redirect_uri": REDDIT_CALL_BACK_URL};
    [manager POST:REDDIT_REQUEST_TOKEN_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response statusCode] != 401) {
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"access_token"] forKey:@"reddit_access_token"];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"expires_in"] forKey:@"reddit_expires_in"];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"refresh_token"] forKey:@"reddit_refresh_token"];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token_type"] forKey:@"reddit_token_type"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onTokenRequestSuccess" object:responseObject[@"access_token"]];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"reddit_access_token"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"reddit_expires_in"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"reddit_refresh_token"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"reddit_token_type"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onTokenRequestError" object:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onTokenRequestError" object:nil];
    }];
}

-(void)tokenRefreshRequest:(NSString *)expireToken{
    NSData *authPass = [[[NSString alloc]initWithFormat:@"%@:",REDDIT_APP] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *basicAuth = [[NSString alloc]initWithFormat:@"Basic %@",[authPass base64EncodedStringWithOptions:0]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:REDDIT_BOT_NAME forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:basicAuth forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *params = @{@"grant_type": @"refresh_token",
                             @"refresh_token": expireToken,
                             @"redirect_uri": REDDIT_CALL_BACK_URL};
    
    [manager POST:REDDIT_REQUEST_TOKEN_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response statusCode] != 401) {
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"access_token"] forKey:@"reddit_access_token"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onTokenRequestSuccess" object:responseObject[@"access_token"]];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onTokenRequestError" object:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"onTokenRequestError" object:nil];
    }];
}

@end
