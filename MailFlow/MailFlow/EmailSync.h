//
//  EmailSync.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Util.h"

#import "SyncRunner.h"

#import "MailCoreTypes.h"
#import "MailCoreUtilities.h"
#import "CTCoreAccount.h"
#import "CTCoreAddress.h"
#import "CTCoreFolder.h"
#import "CTCoreMessage.h"

#import "EmailAccount.h"
#import "Email.h"
#import "State.h"

#import "DBEmails.h"
#import "DBStates.h"

@interface EmailSync : NSObject
{
    CTCoreMessage *_message;
    Email *newEmail;
    float progFloat;
    NSArray *messages, *attachmentsArray, *ccArray, *bccArray;
    NSMutableArray *states;
    NSSet *to, *from;
    NSString *attachmentsField, *toField, *fromField, *fromName, *fromEmail, *ccField, *bccField, *subjectField, *bodyField, *bodyHTML, *Date, *uidField, *statusMsg;
}

@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) CTCoreFolder *folder;


- (void)syncAllFoldersForAccount:(EmailAccount *)emailAccount;
- (void)syncFolderWithName:(NSString *)folderName forAccount:(EmailAccount *)folderAccount;

@end
