//
//  QuickResponsePopup.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "Util.h"

#import "PopupView.h"
#import "QROptionGroup.h"
#import "Email.h"
#import "CTCoreMessage.h"
#import "CTCoreAddress.h"
#import "CTSMTPConnection.h"
#import "EmailUtility.h"

#import "QuickResponsePopupProtocol.h"

@interface QuickResponsePopup : PopupView <UITextFieldDelegate>
{
    Email *stateEmail;
    int stateID;
    NSString *stateName;
    NSString *statePath;
}

@property (nonatomic, assign) id <QuickResponsePopupProtocol> popupDelegate;
@property (nonatomic, strong) UILabel *popupHeader;
@property (nonatomic, strong) NSMutableArray *options;
@property (nonatomic, strong) QROptionGroup *optGroup;

@property (nonatomic, strong) UITextField *addtlTxt;

@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnMark;
@property (nonatomic, strong) UIButton *btnSend;
@property (nonatomic, strong) IBOutlet UIButton *btnReply;

@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *replyTo;

- (id)initWithFrame:(CGRect)frame forEmail:(Email *)email andState:(int)state_id withTitle:(NSString *)state_name withPath:(NSString *)path doPrompt:(BOOL)dopop;

- (void)respond;

- (IBAction)cancelBtnPress;
- (IBAction)sendBtnPress;
- (IBAction)replyBtnPress;

@end