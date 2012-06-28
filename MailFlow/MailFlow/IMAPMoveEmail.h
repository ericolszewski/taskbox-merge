//
//  IMAPMoveEmail.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/27/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Email.h"
#import "EmailAccount.h"

#import "CTCoreFolder.h"
#import "CTCoreMessage.h"

@interface IMAPMoveEmail : NSOperation{
    NSError*  error_;
    BOOL executing_;
    BOOL finished_;
    NSMutableData*    data_;
}

@property (nonatomic, strong) Email *_email;
@property (nonatomic, strong) EmailAccount *_account;
@property (nonatomic, strong) NSString *_path;
@property (nonatomic, strong) CTCoreFolder *_folder;
@property (nonatomic,readonly) NSError* error;

- (id)initWithEmail:(Email *)email forAccount:(EmailAccount *)account toPath:(NSString *)path;
- (CTCoreFolder *)connectFolder:(Email *)email forAccount:(EmailAccount *)account;

@end
