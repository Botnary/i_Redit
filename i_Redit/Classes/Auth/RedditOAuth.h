//
//  RedditOAuth.h
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-25.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "AppID.h"
//  AppID.h and AppID.m contains secret app ID from Reddit app.
//  FOUNDATION_EXPORT NSString *const REDDIT_APP; > AppID.h
//  NSString *const REDDIT_APP = @"YOUR_APP_ID"; > AppID.m

@interface RedditOAuth : NSObject

-(NSString *)requestAuthorisationURL;
-(void)tokenRequest:(NSString *)code;
-(void)tokenRefreshRequest:(NSString *)expireToken;
@end
