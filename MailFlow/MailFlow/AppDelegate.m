//
//  AppDelegate.m
//  MailFlow
//
//  Created by Admin on 6/5/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "JMC.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize databaseName,databasePath;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.databaseName = @"mailflow.sqlite";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];
    
    [self createAndCheckDatabase];
    
    [[JMC sharedInstance] configureJiraConnect:@"https://mailflow.atlassian.net/"
        projectKey:@"MIPN"
        apiKey:@"13cbc7fd-e85f-4c86-b0bc-4a58ce85a6d0"];
    
    [JMC sharedInstance].options.consoleLogEnabled = YES;
    [JMC sharedInstance].options.crashReportingEnabled = YES;
    [JMC sharedInstance].options.locationEnabled = YES;
    [JMC sharedInstance].options.notificationsEnabled = YES;
    
    return YES;
}

-(void) createAndCheckDatabase
{
    BOOL success; 
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    
    if(success) return; 
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
