//
//  RCategory.h
//  i_Redit
//
//  Created by Constantin Botnari on 2015-02-24.
//  Copyright (c) 2015 Constantin Botnari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCategory : NSObject
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *uri;
@property (nonatomic, retain) NSString *descr;
@property (nonatomic, retain) NSString *cover;

-(id)initWithTitle:(NSString *)title andUri:(NSString *) uri andDescr:(NSString *) descr andCover:(NSString *) cover;

@end
