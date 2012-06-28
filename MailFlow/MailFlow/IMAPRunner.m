//
//  IMAPRunner.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/27/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import "IMAPRunner.h"

@implementation IMAPRunner

static IMAPRunner *singleton = nil;

@synthesize imapRunning;
@synthesize opQueue;
@synthesize currentAccount;

+ (id)getRunner
{ 
    @synchronized(self) {
		if (singleton == nil) {
			singleton = [[self alloc] init];
		}
	}
	return singleton;
}

-(id)init 
{
	if (self = [super init]) {
        [self connectAccount];
        
        opQueue = [NSOperationQueue new];
        [opQueue setMaxConcurrentOperationCount:3];
	}
	return self;
}

- (void)connectAccount
{
    
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"LoginData" accessGroup:nil];
    NSString *emailString = [keychain objectForKey:(__bridge id)kSecAttrAccount];
    NSString *passwordString = [keychain objectForKey:(__bridge id)kSecValueData];
    
    currentAccount = [[EmailAccount alloc] init];
    [currentAccount loginToAccount:emailString withPassword:passwordString];
    
}

- (void)moveEmail:(Email *)email toPath:(NSString *)path
{   
    IMAPMoveEmail *mover = [[IMAPMoveEmail alloc] initWithEmail:email forAccount:currentAccount toPath:path];
    [mover addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
    [mover setQueuePriority:NSOperationQueuePriorityLow];
    [opQueue addOperation:mover];
}

- (void)flagEmail:(Email *)email withFlag:(NSString *)flag
{   
    int markFlag = 0;
    if(flag == @"READ"){
        markFlag = CTFlagSeen;
    } else if (flag == @"DELETE") {
        markFlag = CTFlagDeleted;
    }
    
    IMAPSetFlag *flagger = [[IMAPSetFlag alloc] initWithEmail:email setFlag:markFlag forAccount:currentAccount];
    [flagger addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
    [flagger setQueuePriority:NSOperationQueuePriorityVeryLow];
    [opQueue addOperation:flagger];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)operation change:(NSDictionary *)change context:(void *)context 
{
    if ([operation isKindOfClass:[IMAPMoveEmail class]]) {
        
    }
}


@end
