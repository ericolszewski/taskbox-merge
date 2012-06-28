//
//  Email.h
//  MailFlow
//
//  Created by Admin on 6/6/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTCoreMessage.h"
#import <sqlite3.h>

@interface Email : NSObject{
}

@property (nonatomic, assign) int email_id;
@property (nonatomic, assign) BOOL read;
@property (nonatomic, assign) BOOL has_task;

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) NSString *cc;
@property (nonatomic, strong) NSString *bcc;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *fromName;
@property (nonatomic, strong) NSString *fromEmail;
@property (nonatomic, strong) NSString *headers;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *bodyHTML;
@property (nonatomic, strong) NSString *folder;
@property (nonatomic, strong) NSString *attachment;
@property (nonatomic, strong) NSString *datetime;
@property (nonatomic, strong) NSString *modified;

- (NSString *)getDateString:(NSDate *)date;
- (NSDate *)getStringDate:(NSString *)string;
- (NSString *)getFormattedDate;

- (NSString *)getState;

- (NSString *)getCleanBody;
- (NSString *)getOrigBody:(NSString *)bodyTxt;

- (NSString *)getAvatarName;

@end
