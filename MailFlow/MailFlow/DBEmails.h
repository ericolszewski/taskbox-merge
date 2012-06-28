//
//  DBEmails.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/19/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Util.h"
#import "StringUtil.h"

#import "FMDatabase.h"
#import "FMResultSet.h"

#import "Email.h"
#import "SettingsViewController.h"
#import "CTCoreFolder.h"
#import "EmailAccount.h"

@interface DBEmails : NSObject
{
    NSString *emailString, *passwordString;
    EmailAccount *currentAccount;
    CTCoreFolder *inbox;
    CTCoreMessage *msg;
}

- (NSMutableArray *)getEmailsForState:(int)state_id;
- (Email *)getEmail:(int)email_id;

- (BOOL)insertEmail:(Email *)email;
- (BOOL)deleteEmail:(Email *)email;
- (BOOL)isRead:(Email *)email;
- (BOOL)hasTask:(Email *)email;
- (BOOL)moveFolder:(Email *)email:(NSString *)path;

@end
