//
//  StateViewController.h
//  MailFlow
//
//  Created by Admin on 6/7/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"

#import "State.h"
#import "DBStates.h"
#import "EmailTableController.h"

@interface StateViewController : UITableViewController <UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *states;
@property (nonatomic, assign) int stateID;
@property (nonatomic, strong) EmailAccount *UserAccount;

@end
