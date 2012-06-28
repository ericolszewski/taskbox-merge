//
//  Task.h
//  MailFlow
//
//  Created by Eric on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Email.h"

@interface Task : NSObject{
    
}
@property (nonatomic, assign) int task_id;
@property (nonatomic, assign) int priority;
@property (nonatomic, assign) int state_id;
@property (nonatomic, assign) int email_id;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *assign;
@property (nonatomic, strong) NSString *dueDate;
@property (nonatomic, strong) NSString *modified;

@end
