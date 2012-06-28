//
//  IMAPSetFlag.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/28/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Email.h"
#import "EmailAccount.h"

#import "CTCoreFolder.h"
#import "CTCoreMessage.h"
#import "MailCoreTypes.h"

@interface IMAPSetFlag : NSOperation{
    NSError*  error_;
    BOOL executing_;
    BOOL finished_;
}

@property (assign) int _flag;
@property (nonatomic, strong) Email *_email;
@property (nonatomic, strong) EmailAccount *_account;
@property (nonatomic, strong) CTCoreFolder *_folder;
@property (nonatomic,readonly) NSError* error;

- (id)initWithEmail:(Email *)email setFlag:(int)flag forAccount:(EmailAccount *)account;
- (CTCoreFolder *)connectFolder:(Email *)email forAccount:(EmailAccount *)account;

@end
