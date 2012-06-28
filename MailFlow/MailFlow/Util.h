//
//  Util.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/19/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"
#import "AppDelegate.h"

#import "Email.h"
#import "State.h"
#import "DBStates.h"

@interface Util : NSObject{
    NSInteger RememberMe;
    NSUserDefaults *prefs;
}

-(void) StoreLogin:(NSString *)email Password:(NSString *)password;

+ (NSString *)getAppName;
+ (NSString *)getDatabasePath;
+ (NSString *)getSystemVersion;
+ (NSString *)getPhoneModel;

+ (NSDate *)getLastSync;
+ (void)setLastSync;
+ (void)SyncPeriod;
+ (BOOL)checkHasSynched;

+ (NSArray *)getStates;
+ (void)setStates;

+ (void)showAlert:(NSString *)title message:(NSString *)msg;
+ (NSString *)getDateString:(NSDate *)date;
+ (NSDate *)getStringDate:(NSString *)string;

@end
