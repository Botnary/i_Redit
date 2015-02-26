//
//  ColorHelper.h
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-18.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface ColorHelper : NSObject
- (NSColor*)colorWithHexColorString:(NSString*)inColorString;
@end
