//
//  SMTPRunner.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/28/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import "SMTPRunner.h"

@implementation SMTPRunner

static SMTPRunner *singleton = nil;

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

@end
