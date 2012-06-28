//
//  AppDelegate.h
//  MailFlow
//
//  Created by Admin on 6/5/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) NSString *databaseName; 
@property (nonatomic,strong) NSString *databasePath;

@end
