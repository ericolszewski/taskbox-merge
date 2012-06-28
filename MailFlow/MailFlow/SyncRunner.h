//
//  SyncRunner.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/27/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityUtil.h"

#import "EmailAccount.h"
#import "EmailSync.h"

@interface SyncRunner : NSObject {
	BOOL syncRunning;
	id progIndicator;
	NSDate* lastSync;
}

@property (assign) BOOL syncRunning;
@property (nonatomic, retain) EmailAccount *syncAccount;
@property (nonatomic, retain) id msgTable;
@property (nonatomic, retain) id progIndicator;
@property (nonatomic, retain) NSDate *lastSync;
@property (nonatomic, retain) NSString *statusMsg;

+ (id)getRunner;
- (id)init; 

- (void)run:(EmailAccount *)emailAccount;
- (void)runSync;

// Table items
- (void)registerTableView:(id)tableView;
- (void)doReloadTable;

// Progress items
- (void)registerProgIndicator:(id)delegate;
- (void)changeProgress:(float)progress withMsg:(NSString *)progmsg;
- (void)changeProgMessage:(NSString *)progmsg;

@end
