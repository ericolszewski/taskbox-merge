//
//  DBTask.h
//  MailFlow
//
//  Created by Eric on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Util.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

#import "Task.h"
#import "DBEmails.h"

@interface DBTask : NSObject
{

}

- (NSMutableArray *)getAllTasks:(int)stateID;
- (Task *)getTask:(int)email_id;

- (BOOL)insertTask:(Task *)task;
- (BOOL)setState:(int)state_id forTask:(Task *)task;
- (BOOL)deleteTask:(Task *)task;
- (BOOL)updateDate:(Email *)email:(NSString *)date;
- (BOOL)updatePriority:(Email *)email:(int)priority;
- (BOOL)updateAssign:(Email *)email:(NSString *)assignee;
@end
