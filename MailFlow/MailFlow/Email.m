//
//  Email.m
//  MailFlow
//
//  Created by Admin on 6/6/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import "Email.h"

@implementation Email

@synthesize email_id, to, cc, bcc, from, fromName, fromEmail, headers, datetime, subject, body, bodyHTML, folder, attachment, uid, modified, read, has_task;

- (id)init
{
    NSLog(@"Code warrior");
    return self;
}

- (NSString *)getDateString:(NSDate *)date
{
    NSLog(@"Test again");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString *dateString = [formatter stringFromDate:date];

    return dateString;
}

- (NSDate *)getStringDate:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM/dd/yyyy"];
    [formatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ssZZZ"];
    
    NSDate *dateTemp = [formatter2 dateFromString:string];
    NSString *stringDate = [formatter stringFromDate:dateTemp];
    dateTemp = [formatter dateFromString:stringDate];
    
    return dateTemp;
}

- (NSString *)getFormattedDate
{
    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    NSDateFormatter *outFormat = [[NSDateFormatter alloc] init];
    
    [inFormat setDateFormat:@"yyyy-MM-dd HH:mm:ssZZZ"];
    [outFormat setDateFormat:@"MM/dd/yyyy"];
    
    NSDate *dateDate = [inFormat dateFromString:self.datetime];
    NSString *stringDate = [outFormat stringFromDate:dateDate];
    dateDate = [outFormat dateFromString:stringDate];
    
    NSString *dateString = [outFormat stringFromDate:dateDate];
    return dateString;
}

- (NSString *)getState
{
    NSString *state = [[NSString alloc] init];
    
    // TODO: ACTUALLY RETURN STATE
    
    return state;
}

- (NSString *)getCleanBody
{
    NSString *cleanBody = [self.body stringByReplacingOccurrencesOfString:@"'" withString:@"APOS"];
    cleanBody = [cleanBody stringByReplacingOccurrencesOfString:@"\"" withString:@"QUOT"];
    return cleanBody;
}

- (NSString *)getOrigBody:(NSString *)bodyTxt
{
    NSString *origBody = [self.body stringByReplacingOccurrencesOfString:@"APOS" withString:@"'"];
    origBody = [origBody stringByReplacingOccurrencesOfString:@"QUOT" withString:@"\""];
    return origBody;
}

- (NSString *)getAvatarName{
    
    // Temporary avatar logic
    NSString *avatarName = @"avatar_default";
    
    if([self.fromName isEqualToString:@"Adam Cianfichi"]){
        avatarName = @"avatar_adam";
    } else if ([self.fromName isEqualToString:@"Andrew Eye"]) {
        avatarName = @"avatar_andrew";
    } else if ([self.fromName isEqualToString:@"Expensify"]) {
        avatarName = @"avatar_expensify";
    } else if ([self.fromName isEqualToString:@"Facebook"]) {
        avatarName = @"avatar_facebook";
    } else if ([self.fromName isEqualToString:@"Google Calendar"]) {
        avatarName = @"avatar_gcal";
    } else if ([self.fromName isEqualToString:@"Groupon"]) {
        avatarName = @"avatar_groupon";
    } else if ([self.fromName isEqualToString:@"Jessica Stough"]) {
        avatarName = @"avatar_jessica";
    } else if ([self.fromName isEqualToString:@"Newegg"]) {
        avatarName = @"avatar_newegg";
    } else if ([self.fromName isEqualToString:@"TechCrunch"]) {
        avatarName = @"avatar_techcrunch";
    }
    
    return  avatarName;
}

@end
