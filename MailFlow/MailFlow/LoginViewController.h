//
//  LoginViewController.h
//  MailFlow
//
//  Created by Admin on 6/5/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"

#import "EmailAccount.h"
#import "KeychainItemWrapper.h"

#import "CTCoreFolder.h"
#import "CTCoreMessage.h"

#import "EmailTableController.h"
#import "EmailUtility.h"

@class EmailTableController;

@interface LoginViewController : UIViewController
{
    EmailAccount *userAccount;
    UIAlertView *loginAlert;
    BOOL *validAccount, LoginSuccessful;
}

@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (strong,nonatomic) id UserAccount, PassTo, PassFrom, PassSubject, PassBody;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

- (IBAction)dismissKeyboards:(id)sender;
- (IBAction)login:(id)sender;

@end