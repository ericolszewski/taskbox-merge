//
//  IMAPMoveEmail.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/27/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import "IMAPMoveEmail.h"

@implementation IMAPMoveEmail

@synthesize _email;
@synthesize _account;
@synthesize _path;
@synthesize _folder;
@synthesize error;

- (id)initWithEmail:(Email *)email forAccount:(EmailAccount *)account toPath:(NSString *)path
{
    if( (self = [super init]) ) {
        _email = email;
        _account = account;
        _path = path;
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
    error_ = [[NSError alloc] initWithDomain:@"IMAPMoveEmail" code:999 userInfo:nil];
    [self done];
}

- (void)start
{
    // Ensure that this operation starts on the main thread
    /*if (![NSThread isMainThread])
    {
        NSLog(@"Not on main thread, adjusting");
        [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
        return;
    }*/
    
    // Ensure that the operation should execute
    if( finished_ || [self isCancelled] ) { [self done]; return; }
    
    executing_ = YES;
    
    // Execute move of Email
    _folder = [self connectFolder:_email forAccount:_account];
    CTCoreMessage *msg = [_folder messageWithUID:_email.uid];
    
    @try {
        [_folder moveMessage:_path forMessage:msg];
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
