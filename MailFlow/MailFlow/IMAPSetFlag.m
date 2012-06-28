//
//  IMAPSetFlag.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/28/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import "IMAPSetFlag.h"

@implementation IMAPSetFlag

@synthesize _flag;
@synthesize _email;
@synthesize _account;
@synthesize _folder;
@synthesize error;

- (id)initWithEmail:(Email *)email setFlag:(int)flag forAccount:(EmailAccount *)account
{
    if( (self = [super init]) ) {
        _email = email;
        _flag = flag;
        _account = account;
    }
    return self;
}

- (void)done
{    
    executing_ = NO;
    finished_  = YES;
}

-(void)canceled
{
    error_ = [[NSError alloc] initWithDomain:@"IMAPSetFlag" code:999 userInfo:nil];
    [self done];
}

- (void)start
{
    // Ensure that the operation should execute
    if( finished_ || [self isCancelled] ) { [self done]; return; }
    
    executing_ = YES;
    
    // Execute read of Email
    _folder = [self connectFolder:_email forAccount:_account];
    CTCoreMessage *msg = [_folder messageWithUID:_email.uid];
    
    @try {
        unsigned int flags = [_folder flagsForMessage:msg];
        flags = flags | _flag;
        [_folder setFlags:flags forMessage:msg];
        [_folder expunge];
    }
    @catch (NSException *exception) {
        // TODO: Better exception handling
        [self canceled];
    }
    @finally {
        [self done];
    }
    
}


- (CTCoreFolder *)connectFolder:(Email *)email forAccount:(EmailAccount *)account
{
    CTCoreFolder *ctfold = [account folderWithPath:email.folder];
    [ctfold connect];
    
    return ctfold;
}


#pragma mark Overrides

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isExecuting
{
    return executing_;
}

- (BOOL)isFinished
{
    return finished_;
}

@end
