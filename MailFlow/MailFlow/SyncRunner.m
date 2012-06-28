//
//  SyncRunner.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/27/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import "SyncRunner.h"

@implementation SyncRunner

static SyncRunner *singleton = nil;

@synthesize syncRunning;
@synthesize syncAccount;
@synthesize msgTable;
@synthesize progIndicator;
@synthesize lastSync;
@synthesize statusMsg;

+ (id)getRunner
{ 
    @synchronized(self) {
		if (singleton == nil) {
			singleton = [[self alloc] init];
		}
	}
	return singleton;
}

-(id)init 
{
	if (self = [super init]) {
		self.lastSync = [NSDate distantPast];
	}
	return self;
}

- (void)run:(EmailAccount *)emailAccount
{
    if(self.syncRunning){
        return;
    }
    
    self.syncAccount = emailAccount;
    
    NSThread *runThread = [[NSThread alloc] initWithTarget:self selector:@selector(runSync) object:nil];
	[runThread start];
}

- (void)runSync
{
	[NSThread setThreadPriority:0.1];
    
	@synchronized(self) {
		if(self.syncRunning) {
			return;
		}
		self.syncRunning = YES;
	}
    
    @try {
		[ActivityUtil activityOn];
		
		UIApplication* application = [UIApplication sharedApplication];
		application.idleTimerDisabled = YES;
		
        EmailSync *sync = [[EmailSync alloc] init];
        [sync syncAllFoldersForAccount:self.syncAccount];
	} @catch (NSException* exp) {
		NSLog(@"Exception in runSync: %@", exp);
	} @finally {
		[ActivityUtil activityOff];
		UIApplication* application = [UIApplication sharedApplication];
		application.idleTimerDisabled = NO;
        
		self.syncRunning = NO;
        self.lastSync = [NSDate date];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"h:mma"];
        self.statusMsg = [NSString stringWithFormat:@"Updated: %@",[formatter stringFromDate:lastSync]];
        [self changeProgMessage:statusMsg];
	}
    
}


#pragma mark Table itmes

- (void)registerTableView:(id)tableView
{
	assert([tableView respondsToSelector:@selector(populateMessages)]);
	self.msgTable = tableView;
}

- (void)doReloadTable
{
    if(self.msgTable){
        [self.msgTable performSelectorOnMainThread:@selector(populateMessages) withObject:nil waitUntilDone:NO];
    }
}


#pragma mark Progress items

- (void)registerProgIndicator:(id)delegate 
{
	assert([delegate respondsToSelector:@selector(didChangeProgMsg:)]);
	assert([delegate respondsToSelector:@selector(didChangeProg:)]);
	self.progIndicator = delegate;
}

- (void)changeProgress:(float)progress withMsg:(NSString *)progmsg
{	
    NSDictionary* dictProg = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:progmsg],@"progMsg",[NSNumber numberWithFloat:progress], @"progress", nil];
	if(self.progIndicator != nil && [self.progIndicator respondsToSelector:@selector(didChangeProg:)]) {
		[self.progIndicator performSelectorOnMainThread:@selector(didChangeProg:) withObject:dictProg waitUntilDone:NO];
	}
}

- (void)changeProgMessage:(NSString *)progmsg
{
    if(self.progIndicator != nil && [self.progIndicator respondsToSelector:@selector(didChangeProgMsg:)]) {
		[self.progIndicator performSelectorOnMainThread:@selector(didChangeProgMsg:) withObject:progmsg waitUntilDone:NO];
	}
}

@end
