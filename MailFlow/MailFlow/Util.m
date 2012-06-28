//
//  Util.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/19/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import "Util.h"

@implementation Util

- (void)StoreLogin:(NSString *)email Password:(NSString *)password{
    RememberMe = 0;
    prefs = [NSUserDefaults standardUserDefaults];
    RememberMe = [prefs integerForKey:@"RememberKey"];
    if(RememberMe){
        KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"LoginData" accessGroup:nil];
        
        [keychain setObject:email forKey:(__bridge id)kSecAttrAccount];
        [keychain setObject:password forKey:(__bridge id)kSecValueData];  
    }
    [prefs synchronize];
}

// Public getters

+ (NSString *)getAppName
{
    return @"MailFlow";
}

+ (NSString *)getDatabasePath
{
    NSString *databasePath = [(AppDelegate *)[[UIApplication sharedApplication] delegate] databasePath];
    return databasePath; 
}

+ (NSString *)getSystemVersion {
	NSString* systemVersion = [UIDevice currentDevice].systemVersion;
	return systemVersion;
}

+ (NSString *)getPhoneModel {
	NSString* model = [UIDevice currentDevice].model;
	return model;
}

// Sync methods

+ (NSDate *)getLastSync
{
    NSUserDefaults *stdDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastSync = [[NSDate alloc] init];
    NSDate *oldDate = [[NSDate alloc] initWithTimeIntervalSince1970:(NSTimeIntervalSince1970 - NSTimeIntervalSince1970)];
    
    lastSync = [stdDefaults objectForKey:@"LastSyncKey"];
    if(lastSync == nil){
        lastSync = oldDate;
    }
    
    return lastSync;
}

+ (void)setLastSync
{
    NSUserDefaults *stdDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastSync = [[NSDate alloc] init];
    [stdDefaults setObject:lastSync forKey:@"LastSyncKey"];
}

+ (void)SyncPeriod
{
    NSUserDefaults *stdDefaults = [NSUserDefaults standardUserDefaults];
    int SyncPeriodically = [stdDefaults integerForKey:@"SyncKey"];
    
    if(SyncPeriodically){
        
    }
}

+ (BOOL)checkHasSynched
{
    NSUserDefaults *stdDefaults = [NSUserDefaults standardUserDefaults];

    BOOL hasSynched = [stdDefaults boolForKey:@"HasSynched"];
    [stdDefaults setBool:YES forKey:@"HasSynched"];

    return hasSynched;
}

// States methods

+ (NSArray *)getStates
{
    NSUserDefaults *stdDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *states = [[NSArray alloc] init];
    states = [stdDefaults objectForKey:@"AllStatesKey"];
    if (states == nil){
        [self setStates];
        states = [stdDefaults objectForKey:@"AllStatesKey"];
    }
    return states;
}

+ (void)setStates
{
    NSUserDefaults *stdDefaults = [NSUserDefaults standardUserDefaults];
    DBStates *sdb = [[DBStates alloc] init];
    NSArray *states = [[NSArray alloc] initWithArray:[sdb getAllStates]];
    [stdDefaults setObject:states forKey:@"AllStatesKey"];
}


// Utility methods

+ (void)showAlert:(NSString *)title message:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}

+ (NSString *)getDateString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ssZZZ"];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

+ (NSDate *)getStringDate:(NSString *)string
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

@end
