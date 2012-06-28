//
//  EmailUtility.h
//  MailFlow
//
//  Created by Eric on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTCoreAddress.h"
#import "CTCoreFolder.h"
#import "CTCoreMessage.h"
#import "CTSMTPConnection.h"
#import "MailCoreTypes.h"

#import "FMDatabase.h"
#import "FMResultSet.h"

#import "EmailAccount.h"
#import "Email.h"
#import "DBEmails.h"
#import "Task.h"
#import "DBTask.h"

#import "IMAPRunner.h"

@interface EmailUtility : NSObject{
    EmailAccount *currentAccount;
    CTCoreFolder *inbox;
    struct mailmessage *myMessage;
}

- (void)moveMessage:(Email *)email toPath:(NSString *)path;
- (void)markRead:(Email *)email;
- (void)markDeleted:(Email *)email;

- (NSString *)GetPassword;
- (NSString *)GetEmail;
- (void)sendMessage:(NSString *)To:(NSString *)Subject:(NSString *)Body:(NSString *)passwordkey:(NSString *)emailkey;

- (BOOL)isRead:(Email *)email;
- (BOOL)updateEmail:(Email *)stateEmail forState:(int)state_id atPath:(NSString *)statePath;

- (NSSet *)getAllreplies:(Email *)email;
- (NSString *)getReplyString:(Email *)email;

@end
