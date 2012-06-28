//
//  DBEmails.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/19/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import "DBEmails.h"

@implementation DBEmails

- (NSMutableArray *)getEmailsForState:(int)state_id
{
    NSMutableArray *emails = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    FMResultSet *results = [[FMResultSet alloc] init];
    
    if(state_id == 0){
        results = [db executeQuery:@"SELECT * FROM Emails WHERE HasTask = 0 ORDER BY Datetime DESC"];
    } else {
        NSString *select = [NSString stringWithFormat:@"SELECT Emails.* FROM Emails JOIN Tasks ON Emails.Email_ID = Tasks.Email_ID WHERE Tasks.State_ID = %i ORDER BY Datetime DESC", state_id];
        results = [db executeQuery:select];
    }
    
    while([results next]){
        Email *email = [[Email alloc] init];
        
        email.email_id = [results intForColumn:@"Email_ID"];
        email.uid = [results stringForColumn:@"Msg_UID"];
        email.to = [results stringForColumn:@"ToValue"];
        email.from = [results stringForColumn:@"FromValue"];
        email.fromName = [results stringForColumn:@"FromName"];
        email.fromEmail = [results stringForColumn:@"FromEmail"];
        email.cc = [results stringForColumn:@"CC"];
        email.bcc = [results stringForColumn:@"BCC"];
        email.subject = [results stringForColumn:@"Subject"];
        email.body = [StringUtil getQuotted:[results stringForColumn:@"Body"]];
        email.bodyHTML = [results stringForColumn:@"BodyHTML"];
        email.attachment = [results stringForColumn:@"Attachment"];
        email.headers = [results stringForColumn:@"Headers"];
        email.folder = [results stringForColumn:@"Folder"];
        email.datetime = [results stringForColumn:@"Datetime"];
        email.modified = [results stringForColumn:@"Modified"];
        email.read = [results boolForColumn:@"Read"];
        email.has_task = [results boolForColumn:@"HasTask"];
        
        [emails addObject:email];
    }
    
    [db close];
    
    return emails;
}

- (Email *)getEmail:(int)email_id{
    
    Email *email = [[Email alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM Emails WHERE Email_ID = %i", email_id];
    
    while([results next]){
        email.email_id = [results intForColumn:@"Email_ID"];
        email.uid = [results stringForColumn:@"Msg_UID"];
        email.to = [results stringForColumn:@"ToValue"];
        email.from = [results stringForColumn:@"FromValue"];
        email.fromName = [results stringForColumn:@"FromName"];
        email.fromEmail = [results stringForColumn:@"FromEmail"];
        email.cc = [results stringForColumn:@"CC"];
        email.bcc = [results stringForColumn:@"BCC"];
        email.subject = [results stringForColumn:@"Subject"];
        email.body = [StringUtil getQuotted:[results stringForColumn:@"Body"]];
        email.bodyHTML = [results stringForColumn:@"BodyHTML"];
        email.attachment = [results stringForColumn:@"Attachment"];
        email.headers = [results stringForColumn:@"Headers"];
        email.folder = [results stringForColumn:@"Folder"];
        email.datetime = [results stringForColumn:@"Datetime"];
        email.modified = [results stringForColumn:@"Modified"];
        email.read = [results boolForColumn:@"Read"];
        email.has_task = [results boolForColumn:@"HasTask"];
    }
    
    [db close];
    
    return email;
}

- (BOOL)insertEmail:(Email *)email
{    
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    
    [db open];
    
    NSString *insertString = [NSString stringWithFormat:@"INSERT INTO Emails (Msg_UID, ToValue, FromValue, FromName, FromEmail, CC, BCC, Subject, Body, Attachment, Headers, Datetime, Folder ) VALUES ('%@','%@','%@','%@','%@','%@','%@',\"%@\",\"%@\",'%@','%@','%@','%@')", email.uid, email.to, email.from, email.fromName, email.fromEmail, email.cc, email.bcc, email.subject, [StringUtil getUnquotted:email.body], email.attachment, email.headers, email.datetime, email.folder];
    BOOL success = [db executeUpdate:insertString];   
    
    [db close];
    return success;
}

- (BOOL)deleteEmail:(Email *)email
{
    FMDatabase *db = [FMDatabase databaseWithPath:[(AppDelegate *)[[UIApplication sharedApplication]delegate] databasePath]];
    [db open];
    
    BOOL success =  [db executeUpdate:@"DELETE FROM Emails WHERE Msg_UID = ?", email.uid, nil]; 
        
    [db close];
    return success;
}

- (BOOL)isRead:(Email *)email
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    NSString *updateString = [NSString stringWithFormat:@"UPDATE Emails SET Read = '1' WHERE Msg_UID = '%@'", email.uid];
    BOOL success = [db executeUpdate:updateString];  
    
    [db close];
    
    return success;
}

- (BOOL)hasTask:(Email *)email
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    NSString *updateString = [NSString stringWithFormat:@"UPDATE Emails SET HasTask = 1 WHERE Email_ID = %i", email.email_id];
    BOOL success = [db executeUpdate:updateString];  
    
    [db close];
    
    return success;
}

- (BOOL)moveFolder:(Email *)email:(NSString *)path
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];

    NSString *updateString = [NSString stringWithFormat:@"UPDATE Emails SET Folder = '%@' WHERE Msg_UID = '%@'", path, email.uid];
    BOOL success = [db executeUpdate:updateString];  

    [db close];

    return success;
}
@end
