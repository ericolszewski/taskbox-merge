//
//  IMAPRunner.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/27/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityUtil.h"
#import "Util.h"

#import "CTCoreFolder.h"
#import "CTCoreMessage.h"
#import "MailCoreTypes.h"

#import "Email.h"
#import "EmailAccount.h"

#import "IMAPMoveEmail.h"
#import "IMAPSetFlag.h"

@interface IMAPRunner : NSObject {
	BOOL imapRunning;
}

@property (assign) BOOL imapRunning;
@property (nonatomic, retain) NSOperationQueue *opQueue;
@property (nonatomic, retain) EmailAccount *currentAccount;

+ (id)getRunner;
- (id)init;

- (void)connectAccount;

- (void)moveEmail:(Email *)email toPath:(NSString *)path;
- (void)flagEmail:(Email *)email withFlag:(NSString *)flag;

@end
