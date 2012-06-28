//
//  EmailCell.h
//  MailFlow
//
//  Created by Admin on 6/5/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "StateButton.h"

#import "Email.h"
#import "EmailCellProtocol.h"
#import "StateButtonProtocol.h"

#import "State.h"
#import "DBStates.h"

#import "IconButton.h"

@interface EmailCell : UITableViewCell <StateButtonProtocol, UIPickerViewDelegate>

@property (nonatomic, strong) id rootTable;

@property (nonatomic, strong) NSMutableArray *states;
@property (nonatomic, weak) State *posStateOne;
@property (nonatomic, weak) State *posStateTwo;
@property (nonatomic, weak) State *posStateThree;
@property (nonatomic, weak) State *posStateFour;
@property (nonatomic, weak) State *negStateOne;
@property (nonatomic, weak) State *negStateTwo;
@property (nonatomic, weak) State *negStateThree;
@property (nonatomic, weak) State *negStateFour;

@property (nonatomic, strong) UIView *detailView;
@property (nonatomic, strong) UIView *posView;
@property (nonatomic, strong) UIView *negView;
@property (nonatomic, strong) UIView *iconView;

@property (nonatomic, retain) NSString *swipeState;
@property (nonatomic, retain) NSString *dateString;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, assign) id <EmailCellProtocol> cellDelegate;

@property (nonatomic, strong) Email *currentEmail;
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) IBOutlet UIImageView *imgAvatar;
@property (nonatomic, strong) IBOutlet UILabel *lblFrom;
@property (nonatomic, strong) IBOutlet UILabel *lblDate;
@property (nonatomic, strong) IBOutlet UILabel *lblState;
@property (nonatomic, strong) IBOutlet UILabel *lblSubject;
@property (nonatomic, strong) IBOutlet UITextView *txtBody;

@property (nonatomic, strong) IBOutlet UIButton *reply;
@property (nonatomic, strong) IBOutlet UIButton *cal;
@property (nonatomic, strong) IBOutlet UIButton *person;
@property (nonatomic, strong) IBOutlet UIButton *star;
@property (nonatomic, strong) IBOutlet UIButton *tags;


- (void)setForEmail:(Email*)setEmail;
- (void)delegateReloadTable;
- (void)dismissDatePicker:(id)sender;

- (IBAction)didSwipeRightInCell:(id)sender;
- (IBAction)didSwipeLeftInCell:(id)sender;
- (IBAction)showDueDate:(id)sender;
- (IBAction)showPicker:(id)sender;
- (IBAction)changeDate:(id)sender;
- (IBAction)showAssign:(id)sender;

@end
