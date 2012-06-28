//
//  DBEmails.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/19/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Util.h"
#import "State.h"

#import "FMDatabase.h"
#import "FMResultSet.h"

@interface DBStates : NSObject
{

}
- (NSMutableArray *)getAllStates;
- (NSMutableArray *)getAllResponses:(int)identifier;
- (NSMutableArray *)getAllTemplates:(int)identifier;
- (NSString *)getPath:(int)identifier;
@end