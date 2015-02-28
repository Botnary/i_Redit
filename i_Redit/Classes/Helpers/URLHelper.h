//
//  URLHelper.h
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-22.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLHelper : NSObject
-(NSDictionary *)parseQueryString:(NSString *)query;
@end
