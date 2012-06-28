//
//  ComposeViewController.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "Email.h"
#import "EmailAccount.h"
#import "EmailTableController.h"
#import "EmailUtility.h"

@interface ComposeViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtTo;
@property (weak, nonatomic) IBOutlet UITextField *txtSubject;

@property (weak, nonatomic) IBOutlet UIButton *addContact;
@property (weak, nonatomic) IBOutlet UIButton *btnCal;
@property (weak, nonatomic) IBOutlet UIButton *btnAssign;
@property (weak, nonatomic) IBOutlet UIButton *btnPriority;
@property (weak, nonatomic) IBOutlet UIButton *btnTag;

@property (weak, nonatomic) IBOutlet UITextView *txtBody;

@property (nonatomic, strong) EmailAccount *UserAccount;


- (IBAction)dismissKeyboards:(id)sender;
- (IBAction)sendMsg:(id)sender;
- (IBAction)cancelCompose:(id)sender;

@end
