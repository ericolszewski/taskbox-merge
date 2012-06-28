//
//  EmailSync.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmailSync.h"

@implementation EmailSync

@synthesize messages;
@synthesize folder;

- (void)syncAllFoldersForAccount:(EmailAccount *)emailAccount
{
	[NSThread setThreadPriority:0.1];
    
    [self syncFolderWithName:@"INBOX" forAccount:emailAccount];
    
    /*
    [self syncFolderWithName:[Util getAppName] forAccount:emailAccount];
    
    DBStates *sdb = [[DBStates alloc] init];
    states = [sdb getAllStates];
    
    for(State *state in states){
        [self syncFolderWithName:state.path forAccount:emailAccount];
    }*/
}

- (void)syncFolderWithName:(NSString *)folderName forAccount:(EmailAccount *)folderAccount
{
    SyncRunner *sr = [SyncRunner getRunner];

    folder = [folderAccount folderWithPath:folderName];
    [folder connect];
    
    int folderCount = [folder totalMessageCount];
    
    @try {
        messages = [[folder messageObjectsFromIndex:0 toIndex:1] allObjects];
        IfTrue_RaiseException(messages == nil, CTUnknownError, NSLocalizedString(@"Empty message list",nil));						
    } @catch (NSException *exp) {
        // TODO: Handle exception casess
    }
    
    for (int i = 0; i < [messages count]; i++) {
        
        _message = [messages objectAtIndex:i];
        
        if ([[Util getLastSync] compare:_message.sentDateLocalTimeZone] == NSOrderedAscending) {
            
            newEmail = [[Email alloc] init];
            
            [_message fetchBodyStructure];
            
            fromField = nil;
            fromEmail = nil;
            fromName = nil;
            from = _message.from;
            fromName = [[_message.from anyObject] decodedName];
            fromEmail = [[_message.from anyObject] email];
            
            toField = nil;
            to = _message.to;
            for(CTCoreAddress *tAddr in to){
                NSString *tStr = [NSString stringWithFormat:@"<%@,%@>",[tAddr decodedName], [tAddr email]];
                if(toField == nil){
                    toField = [NSString stringWithFormat:@"%@",tStr];
                } else {
                    toField = [NSString stringWithFormat:@"%@|%@",toField,tStr];
                }
            }        
        
            ccArray = [_message.cc allObjects];
            ccField = [[ccArray valueForKey:@"description"] componentsJoinedByString:@", "];
        
            bccArray = [_message.bcc allObjects];
            bccField = [[bccArray valueForKey:@"description"] componentsJoinedByString:@", "];
            
            subjectField = _message.subject;
            bodyField = _message.body;
            bodyHTML = _message.htmlBody;
            uidField = _message.uid;
            
            attachmentsArray = _message.attachments;
            attachmentsField = [[attachmentsArray valueForKey:@"description"] componentsJoinedByString:@" "];
        
            [newEmail setUid:uidField];
            [newEmail setTo:toField];
            [newEmail setFrom:fromField];
            [newEmail setFromName:fromName];
            [newEmail setFromEmail:fromEmail];
            [newEmail setCc:ccField];
            [newEmail setBcc:bccField];
            [newEmail setSubject:subjectField];
            [newEmail setBody:bodyField];
            [newEmail setBodyHTML:bodyHTML];
            [newEmail setAttachment:attachmentsField];
            [newEmail setFolder:folderName];
            
            NSDate *msgDate = [[NSDate alloc] init];
            msgDate = _message.sentDateGMT;
            [newEmail setDatetime:[Util getDateString:msgDate]];
        
            if (newEmail) {
                DBEmails *edb = [[DBEmails alloc] init];
                [edb insertEmail:newEmail];
            }
            
        }
        
        statusMsg = [NSString stringWithFormat:@"Pulling %i of %i",i,folderCount];
        progFloat = (i/(float)folderCount);
        [sr changeProgress:progFloat withMsg:statusMsg];
        if(i <= 20){
            [sr doReloadTable];
        }
        
    }
    
    [Util setLastSync];
    [sr doReloadTable];
    
}

@end
