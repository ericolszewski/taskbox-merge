//
//  EmailAccount.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmailAccount.h"

@implementation EmailAccount

@synthesize states;

- (void)loginToAccount:(NSString *)EmailText withPassword:(NSString *)PasswordText
{    
    ParsedEmail = [EmailText componentsSeparatedByString: @"@"];
    Domain = [ParsedEmail objectAtIndex: 1];
    
    if ([Domain isEqualToString:@"gmail.com"]) {
        [self connectToServer:@"imap.gmail.com" port:993 connectionType:CONNECTION_TYPE_TLS
                     authType:IMAP_AUTH_TYPE_PLAIN login:EmailText password:PasswordText];
    }
    else if ([Domain isEqualToString:@"yahoo.com"] || [Domain isEqualToString:@"sbcglobal.net"])
    {
        [self connectToServer:@"imap.mail.yahoo.com" port:993 connectionType:CONNECTION_TYPE_TLS
                     authType:IMAP_AUTH_TYPE_PLAIN login:EmailText password:PasswordText];
    }
    else if ([Domain isEqualToString:@"aol.com"])
    {
        [self connectToServer:@"imap.aol.com" port:993 connectionType:CONNECTION_TYPE_TLS
                     authType:IMAP_AUTH_TYPE_PLAIN login:EmailText password:PasswordText];
    }
    
}

- (void)StoreCredentials:(NSString *)email Password:(NSString *)password
{
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"LoginData" accessGroup:nil];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:email forKey:@"emailKey"];
    [prefs setObject:password forKey:@"passKey"];
    [prefs synchronize];
    
    // Store Username
    [keychain setObject:email forKey:(__bridge id)kSecAttrAccount];
    
    // Store password
    [keychain setObject:password forKey:(__bridge id)kSecValueData];  
}

- (void)checkFolders:(NSSet *)theFolders
{
    if(![theFolders containsObject:@"MailFlow"]){ [self createFolderWithPath:@"MailFlow"];}
    
    statesPlist = [[NSBundle mainBundle] pathForResource:@"states" ofType:@"plist"];
    states = [[NSDictionary alloc] initWithContentsOfFile:statesPlist];
    
    for(NSString *key in states){
        if(![theFolders containsObject:key]){ [self createFolderWithPath:key];}
    }
    
}

- (void)createFolderWithPath:(NSString *)folderPath
{
    newFolder = [[CTCoreFolder alloc] initWithPath:folderPath inAccount:self];
    [newFolder create];
    
}


@end