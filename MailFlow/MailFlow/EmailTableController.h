//
//  EmailTableController.h
//  MailFlow
//
//  Created by Admin on 6/5/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "JMC.h"
#import "SyncRunner.h"

#import "ProgressIndicator.h"

#import "CTCoreFolder.h"
#import "CTCoreAccount.h"
#import "CTCoreMessage.h"

#import "DBEmails.h"
#import "Email.h"
#import "EmailSync.h"
#import "EmailCell.h"
#import "EmailCellProtocol.h"

#import "PullRefreshTableViewController.h"
#import "DetailViewController.h"
#import "StateViewController.h"
#import "SettingsViewController.h"
#import "ComposeViewController.h"

@interface EmailTableController : PullRefreshTableViewController <EmailCellProtocol>
{

}

@property (nonatomic, strong) ProgressIndicator *progInd;

@property (weak, nonatomic) IBOutlet UIButton *stateButton;

@property (nonatomic, strong) NSMutableArray *emails;
@property (nonatomic, strong) NSIndexPath *swipedCell;

@property (nonatomic, strong) EmailAccount *UserAccount;
@property (nonatomic, strong) Email *currentEmail;

@property (nonatomic, assign) int stateID;
@property (nonatomic, strong) NSString *stateLbl;

- (void)populateMessages;
- (void)delegateReloadData;
- (void)delegateCloseCell:(NSIndexPath *)indexPath; 
- (void)delegateCellSwipe:(NSIndexPath *)indexPath;
- (IBAction)stateButton:(id)sender;

@end