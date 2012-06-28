//
//  EmailUtility.m
//  MailFlow
//
//  Created by Eric on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmailUtility.h"

@implementation EmailUtility

- (void)moveMessage:(Email *)email toPath:(NSString *)path
{
    DBEmails *dbe = [[DBEmails alloc] init];
    [dbe moveFolder:email:path];
    
    IMAPRunner *irun = [IMAPRunner getRunner];
    [irun moveEmail:email toPath:path];
}

- (void)markRead:(Email *)email
{
    DBEmails *dbe = [[DBEmails alloc] init];
    [dbe isRead:email];
    
    IMAPRunner *irun = [IMAPRunner getRunner];
    [irun flagEmail:email withFlag:@"READ"];
}

- (void)markDeleted:(Email *)email
{
    DBEmails *dbe = [[DBEmails alloc] init];
    [dbe deleteEmail:email];
    
    IMAPRunner *irun = [IMAPRunner getRunner];
    [irun flagEmail:email withFlag:@"DELETE"];
}

- (NSString *)GetPassword
{
    KeychainItemWrapper *keychain = 
    [[KeychainItemWrapper alloc] initWithIdentifier:@"LoginData" accessGroup:nil];
    return [keychain objectForKey:(__bridge id)kSecValueData];
}

- (NSString *)GetEmail
{
    KeychainItemWrapper *keychain = 
    [[KeychainItemWrapper alloc] initWithIdentifier:@"LoginData" accessGroup:nil];
    return [keychain objectForKey:(__bridge id)kSecAttrAccount];
}

- (void)sendMessage:(NSString *)To:(NSString *)Subject:(NSString *)Body:(NSString *)passwordkey:(NSString *)emailkey
{
    CTCoreMessage *msg = [[CTCoreMessage alloc] init];
    [msg setTo:[NSSet setWithObject:[CTCoreAddress addressWithName:@"Holder" email:To]]];
    [msg setSubject:Subject];
    [msg setBody:Body];
    [CTSMTPConnection sendMessage:msg server:@"smtp.gmail.com" username:emailkey password:passwordkey port:587 useTLS:YES useAuth:YES];
    
    NSArray *chunks = [To componentsSeparatedByString: @"@"];
    NSString *domain = [chunks objectAtIndex: 1];
    
    if ([domain isEqualToString:@"gmail.com"]) {
        [CTSMTPConnection sendMessage:msg server:@"smtp.gmail.com" username:emailkey password:passwordkey port:587 useTLS:YES useAuth:YES];
    }    
    else if ([domain isEqualToString:@"yahoo.com"]) {
        [CTSMTPConnection sendMessage:msg server:@"smtp.mail.yahoo.com" username:emailkey password:passwordkey port:465 useTLS:YES useAuth:YES];
    }
    else if ([domain isEqualToString:@"aol.com"]) {
        [CTSMTPConnection sendMessage:msg server:@"smtp.aol.com" username:emailkey password:passwordkey port:587 useTLS:YES useAuth:YES];
    }
}

- (BOOL)isRead:(Email *)email
{
    [self markRead:email];
    
    DBEmails *dbe = [[DBEmails alloc] init];
    BOOL success = [dbe isRead:email];
    
    return success;
}

- (BOOL)updateEmail:(Email *)stateEmail forState:(int)state_id atPath:(NSString *)statePath
{
    BOOL success = NO;
    DBEmails *dbe = [[DBEmails alloc] init];
    DBTask *dbt = [[DBTask alloc] init];
    Task *task = [[Task alloc] init];
    task = [dbt getTask:stateEmail.email_id];
    if (task.task_id == 0) {
        task.email_id = stateEmail.email_id;
        task.state_id = state_id;
        task.title = stateEmail.subject;
        task.assign = stateEmail.to;
        success = [dbt insertTask:task];
        if (success){
            [dbe hasTask:stateEmail];
        }
    } else {
        success = [dbt setState:state_id forTask:task];
    }
    
    [self moveMessage:stateEmail toPath:statePath];
    
    return success;
}

- (NSSet *)getAllreplies:(Email *)email
{
    int i = 0;
    NSString *name, *address;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myEmail = [prefs stringForKey:@"emailKey"];
    NSArray *addresses = [email.to componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<,>"]];
    NSMutableArray *test = [[NSMutableArray alloc] init];
    while (i < ([addresses count]-1)) {
        name = [addresses objectAtIndex: i];
        if ([name isEqualToString:@""] || [name isEqualToString:@"|"]) {
            name = [addresses objectAtIndex: ++i];
        }
        address = [addresses objectAtIndex: (i+1)];
        if ([address isEqualToString:@""] || [address isEqualToString:@"|"]) {
            address = [addresses objectAtIndex: ++i];
        }
        i+=2;
        
        if(![myEmail isEqualToString:address])
            [test addObject:[CTCoreAddress addressWithName:name email:address]];
    }
    NSArray *array = [NSArray arrayWithArray:test];
    NSSet *emails = [NSSet setWithArray:array];
    return emails;
}

- (NSString *)getReplyString:(Email *)email
{
    int i = 0;
    NSString *name, *address;
    NSMutableString *list = [[NSMutableString alloc]
                            initWithString:@" "];
    NSArray *addresses = [email.to componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<,>"]];
    while (i < ([addresses count]-1)) {
        name = [addresses objectAtIndex: i];
        if ([name isEqualToString:@""] || [name isEqualToString:@"|"]) {
            name = [addresses objectAtIndex: ++i];
        }
        address = [addresses objectAtIndex: (i+1)];
        if ([address isEqualToString:@""] || [address isEqualToString:@"|"]) {
            address = [addresses objectAtIndex: ++i];
        }
        i+=2;
        [list appendString:address];
        [list appendString:@","];
    }
    return list;
}

@end
