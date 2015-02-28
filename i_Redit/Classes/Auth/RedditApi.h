//
//  RedditApi.h
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-25.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const REDDIT_URL;
FOUNDATION_EXPORT NSString *const REDDIT_AUTH_URL;
FOUNDATION_EXPORT NSString *const REDDIT_REQUEST_TOKEN_URL;
FOUNDATION_EXPORT NSString *const REDDIT_BOT_NAME;
FOUNDATION_EXPORT NSString *const REDDIT_CALL_BACK_URL;
FOUNDATION_EXPORT NSString *const REDDIT_SCOPE;
FOUNDATION_EXPORT NSString *const REDDIT_API_URI;

@interface RedditApi : NSObject

-(void)userSubreddits:(NSString *)token;
-(void)subRedditArticles:(NSString *)token andSubReditName:(NSString *)uri;

@end
