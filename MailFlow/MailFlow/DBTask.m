//
//  DBTask.m
//  MailFlow
//
//  Created by Eric on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBTask.h"

@implementation DBTask{
    
}

- (NSMutableArray *)getAllTasks:(int)stateID{
    NSMutableArray *tasks = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM Tasks WHERE State_ID = '%i'", stateID];
    
    while([results next])
    {
        Task *task = [[Task alloc] init];
        
        task.task_id = [results intForColumn:@"Task_ID"];
        task.title = [results stringForColumn:@"Title"];
        task.priority = [results intForColumn:@"Priority"];
        task.dueDate = [results stringForColumn:@"DueDate"];
        task.state_id = [results intForColumn:@"State_ID"];
        task.email_id = [results intForColumn:@"Email_ID"];
        task.modified = [results stringForColumn:@"Modified"];
        
        [tasks addObject:task];
    }
    
    [db close];
    
    return tasks;
}

- (Task *)getTask:(int)email_id
{
    Task *task = [[Task alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    NSString *resultset = [NSString stringWithFormat:@"SELECT * FROM Tasks WHERE Email_ID = '%i'", email_id];
    FMResultSet *results = [db executeQuery:resultset];  
    while([results next])
    {
        task.task_id = [results intForColumn:@"Task_ID"];
        task.title = [results stringForColumn:@"Title"];
        task.priority = [results intForColumn:@"Priority"];
        task.dueDate = [results stringForColumn:@"DueDate"];
        task.state_id = [results intForColumn:@"State_ID"];
        task.email_id = [results intForColumn:@"Email_ID"];
        task.modified = [results stringForColumn:@"Modified"];
    }
    
    [db close];
    
    return task;
}

- (BOOL)insertTask:(Task *)task
{    
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    NSString *insertString = [NSString stringWithFormat:@"INSERT INTO Tasks (Title, Email_ID, State_ID, Assign) VALUES (\"%@\",%i,%i,\"%@\")", task.title, task.email_id, task.state_id, task.assign];
    
    BOOL success = [db executeUpdate:insertString];  
    [db close];

    return success;
}

- (BOOL)setState:(int)state_id forTask:(Task *)task
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    NSString *update = [NSString stringWithFormat:@"UPDATE Tasks SET State_ID = %i WHERE Email_ID = %i", state_id, task.email_id];
    BOOL success = [db executeUpdate:update];   
    
    [db close];
    
    return success;
}

- (BOOL)deleteTask:(Task *)task
{
    return YES;
}

- (BOOL)updateDate:(Email *)email:(NSString *)date
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    NSString *update = [NSString stringWithFormat:@"UPDATE Tasks SET DueDate = '%@' WHERE Email_ID = %i", date, email.email_id];
    BOOL success = [db executeUpdate:update];   
    
    [db close];
    
    return success;
}

- (BOOL)updatePriority:(Email *)email:(int)priority
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    NSString *update = [NSString stringWithFormat:@"UPDATE Tasks SET Priority = '%i' WHERE Email_ID = %i", priority, email.email_id];
    BOOL success = [db executeUpdate:update];   
    
    [db close];
    
    return success;
}

- (BOOL)updateAssign:(Email *)email:(NSString *)assignee
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Util getDatabasePath]];
    [db open];
    
    NSString *update = [NSString stringWithFormat:@"UPDATE Tasks SET Assign = '%@' WHERE Email_ID = %i", assignee, email.email_id];
    BOOL success = [db executeUpdate:update];   
    
    [db close];
    
    return success;
}

@end