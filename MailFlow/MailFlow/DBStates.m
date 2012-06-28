//
//  DBEmails.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/19/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import "DBStates.h"

@implementation DBStates

- (NSMutableArray *)getAllStates
{
    NSMutableArray *states = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM States ORDER BY Direction DESC, State_ID ASC"]; 
    
    while([results next])
    {
        State *state = [[State alloc] init];
        
        state.state_id = [results intForColumn:@"State_ID"];
        state.name = [results stringForColumn:@"Name"];
        state.path = [results stringForColumn:@"Path"];
        state.label = [results stringForColumn:@"Label"]; 
        state.direction = [results boolForColumn:@"Direction"];
        [states addObject:state];
    }
    
    [db close];
    
    return states;
}

- (NSMutableArray *)getAllResponses:(int)identifier
{
    NSMutableArray *responses = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];

    NSString *responseString = [NSString stringWithFormat:@"SELECT * FROM State_Responses WHERE State_ID = '%i'", identifier];
    FMResultSet *results = [db executeQuery:responseString];  
    
    while([results next])
    {
        [responses addObject:[results stringForColumn:@"Response"]];
    }
    
    [db close];
    
    return responses;
}

- (NSMutableArray *)getAllTemplates:(int)identifier
{
    NSMutableArray *templates = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM State_Responses WHERE State_ID = ?", identifier];
    
    while([results next])
    {
        [templates addObject:[results stringForColumn:@"Template"]];
    }
    
    [db close];
    
    return templates;
}

- (NSString *)getPath:(int)identifier
{
    NSString *path;
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM States WHERE State_ID = '%i'", identifier];

    while([results next])
    {
        path = [results stringForColumn:@"Path"];
    }
    
    [db close];
    
    return path;
}

@end