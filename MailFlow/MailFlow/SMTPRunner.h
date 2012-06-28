//
//  SMTPRunner.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/28/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityUtil.h"
#import "Util.h"

#import "CTCoreAddress.h"
#import "CTCoreFolder.h"
#import "CTCoreMessage.h"
#import "CTSMTPConnection.h"

#import "Email.h"
#import "EmailAccount.h"

@interface SMTPRunner : NSObject{
    BOOL smtpRunning;
}

@property (assign) BOOL imapRunning;
@property (nonatomic, retain) NSOperationQueue *opQueue;
@property (nonatomic, retain) EmailAccount *currentAccount;

+ (id)getRunner;
- (id)init;

- (void)connectAccount;



@end
