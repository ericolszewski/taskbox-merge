//
//  QuickResponsePopup.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuickResponsePopup.h"

@implementation QuickResponsePopup

@synthesize popupDelegate;
@synthesize popupHeader;
@synthesize options, optGroup;
@synthesize addtlTxt;
@synthesize btnCancel, btnMark, btnSend;
@synthesize btnReply;
@synthesize index;
@synthesize replyTo;

- (id)initWithFrame:(CGRect)frame forEmail:(Email *)email andState:(int)state_id withTitle:(NSString *)state_name withPath:(NSString *)path doPrompt:(BOOL)dopop
{
    
	self = [super initWithFrame:frame];
	if (self) 
    {
        stateEmail = email;
        stateID = state_id;
        stateName = state_name;
        statePath = path;
        
		self.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        self.layer.borderColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor;
        self.layer.borderWidth = 1.0f;
		self.layer.cornerRadius = 10.0f;
        
        if(dopop ==YES){
            
            popupHeader = [[UILabel alloc] init];
            [popupHeader setBackgroundColor:[UIColor clearColor]];
            [popupHeader setFont:[UIFont boldSystemFontOfSize:12]];
            [popupHeader setMinimumFontSize:10];
            [popupHeader setLineBreakMode:UILineBreakModeTailTruncation];
            [popupHeader setTextColor:[UIColor whiteColor]];
            [popupHeader setTextAlignment:UITextAlignmentLeft];
            [popupHeader setText:stateEmail.fromEmail];
            
            btnReply = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
            [btnReply setBackgroundColor:[UIColor clearColor]];
            [btnReply setImage:[UIImage imageNamed:@"icon_replyone"] forState:UIControlStateNormal];
            [btnReply addTarget:self action:@selector(replyBtnPress) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnReply];
            
            [self addSubview:popupHeader];
            
            DBStates *dbs = [[DBStates alloc] init];
            options = [dbs getAllResponses:stateID];
            
            optGroup = [[QROptionGroup alloc]initWithFrame:CGRectMake(16, 36, (self.frame.size.width + 32), 154) andOptions:options andColumns:1];
            [self addSubview:optGroup];
            
            addtlTxt = [[UITextField alloc] initWithFrame:CGRectMake(0,12,180,30)];
            addtlTxt.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1].CGColor;
            [addtlTxt setBackgroundColor:[UIColor whiteColor]];
            [addtlTxt setFont:[UIFont systemFontOfSize:12]];
            [addtlTxt setBorderStyle:UITextBorderStyleRoundedRect];
            [addtlTxt setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
            [addtlTxt setPlaceholder:@"Additional comments here..."];
            [addtlTxt setReturnKeyType:UIReturnKeyDone];
            [addtlTxt setDelegate:self];
            [self addSubview:addtlTxt];
            
            btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 32)];
            [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
            [btnCancel setBackgroundColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1]];
            [btnCancel.layer setBorderColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor];
            [btnCancel.layer setBorderWidth:1.0f];
            [btnCancel.layer setCornerRadius:6.0f];
            [btnCancel.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
            [btnCancel.titleLabel setTextColor:[UIColor whiteColor]];
            [btnCancel addTarget:self action:@selector(cancelBtnPress) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnCancel];
            
            btnMark = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 32)];
            [btnMark setTitle:@"Mark" forState:UIControlStateNormal];
            [btnMark setBackgroundColor:[UIColor colorWithRed:0 green:0.5 blue:0.8 alpha:1]];
            [btnMark.layer setBorderColor:[UIColor colorWithRed:0 green:0.6 blue:0.9 alpha:1].CGColor];
            [btnMark.layer setBorderWidth:1.0f];
            [btnMark.layer setCornerRadius:6.0f];
            [btnMark.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
            [btnMark.titleLabel setTextColor:[UIColor whiteColor]];
            [btnMark addTarget:self action:@selector(markBtnPress) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnMark];
            
            btnSend = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 32)];
            [btnSend setTitle:@"Send" forState:UIControlStateNormal];
            [btnSend setBackgroundColor:[UIColor colorWithRed:0 green:0.5 blue:0.8 alpha:1]];
            [btnSend.layer setBorderColor:[UIColor colorWithRed:0 green:0.6 blue:0.9 alpha:1].CGColor];
            [btnSend.layer setBorderWidth:1.0f];
            [btnSend.layer setCornerRadius:6.0f];
            [btnSend.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
            [btnSend.titleLabel setTextColor:[UIColor whiteColor]];
            [btnSend addTarget:self action:@selector(sendBtnPress) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnSend];
            
            [self performSelector:@selector(hidePopup:) withObject:nil afterDelay:30.0];
        }
	}
	return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.btnReply.frame = CGRectMake(12, 16, 24, 24);
	self.popupHeader.frame = CGRectMake(48, 16, (self.frame.size.width - 76), 20);
    self.optGroup.frame = CGRectMake(16, 36, (self.frame.size.width + 32), 154);
    self.addtlTxt.frame = CGRectMake(16, 200, (self.frame.size.width - 32), 30);
    //self.btnCancel.frame = CGRectMake(16, 248, 120, 32);
    //self.btnSend.frame = CGRectMake(150, 248, 120, 32);
    self.btnCancel.frame = CGRectMake(16, 248, 80, 32);
    self.btnMark.frame = CGRectMake(104, 248, 80, 32);
    self.btnSend.frame = CGRectMake(192, 248, 80, 32);

}

- (void)hidePopup:(id)sender {
    [addtlTxt resignFirstResponder];
	[self hide];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    if(textField == addtlTxt){
        [addtlTxt resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void)animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.frame = CGRectOffset(self.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)showAnimated:(BOOL)animated 
{
	[super showAnimated:animated];
}

- (void)respond
{
    EmailUtility *eutil = [[EmailUtility alloc] init];
    NSSet *nset = [eutil getAllreplies:stateEmail];
    NSString *Reply = @"Re: ", *ReplySubject = [Reply stringByAppendingFormat:stateEmail.subject];
    NSString *TemplatedResponse = optGroup.QRText;
    NSString *QuickResponsebody = [TemplatedResponse stringByAppendingFormat:@"\n\n"];
    if ([[addtlTxt text] length] != 0) {
        TemplatedResponse = [QuickResponsebody stringByAppendingFormat:addtlTxt.text];
        QuickResponsebody = [TemplatedResponse stringByAppendingFormat:@"\n\n\n"];
    }
    TemplatedResponse = [QuickResponsebody stringByAppendingFormat:stateEmail.body];
     if ([stateEmail.fromName length] == 0) 
     {
         stateEmail.fromName = @"Receiver";
     }
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
     NSString *emailkey = [prefs stringForKey:@"emailKey"];
     NSString *passwordkey = [prefs stringForKey:@"passKey"];

     CTCoreMessage *msg = [[CTCoreMessage alloc] init];
     [msg setTo:nset];
     [msg setSubject:ReplySubject];
     [msg setBody:TemplatedResponse];
     [CTSMTPConnection sendMessage:msg server:@"smtp.gmail.com" username:emailkey password:passwordkey port:587 useTLS:YES useAuth:YES];
     
     NSArray *chunks = [stateEmail.fromEmail componentsSeparatedByString: @"@"];
     NSString *domain = [chunks objectAtIndex: 1];
     
     if ([domain isEqualToString:@"gmail.com"]) {
         [CTSMTPConnection sendMessage:msg server:@"smtp.gmail.com" username:emailkey password:passwordkey port:587 useTLS:YES useAuth:YES];
     }    
     else if ([domain isEqualToString:@"yahoo.com"]) {
         [CTSMTPConnection sendMessage:msg server:@"smtp.mail.yahoo.com" username:emailkey password:passwordkey port:465 useTLS:YES useAuth:YES];
     }
     else if ([domain isEqualToString:@"aol.com"]) {
         [CTSMTPConnection sendMessage:msg server:@"smtp.aol.com" username:emailkey password:passwordkey port:587 useTLS:YES useAuth:YES];
     }
}

- (IBAction)replyBtnPress
{
    btnReply.selected = !btnReply.selected;
    if (btnReply.selected){
        [btnReply setImage:[UIImage imageNamed:@"icon_replyall"] forState:UIControlStateNormal];
        EmailUtility *eutil = [[EmailUtility alloc] init];
        NSString *allreply = [eutil getReplyString:stateEmail];
        [popupHeader setText:allreply];
    } else {
        [btnReply setImage:[UIImage imageNamed:@"icon_replyone"] forState:UIControlStateNormal];
        [popupHeader setText:stateEmail.fromEmail];
    }
}

- (IBAction)cancelBtnPress
{
    [self hidePopup:self];
}

- (IBAction)markBtnPress
{
    EmailUtility *eutil = [[EmailUtility alloc] init];
    [eutil updateEmail:stateEmail forState:stateID atPath:statePath];
    
    [popupDelegate delegateReloadButton];
    [self hidePopup:self];
}

- (IBAction)sendBtnPress
{
    EmailUtility *eutil = [[EmailUtility alloc] init];
    [eutil updateEmail:stateEmail forState:stateID atPath:statePath];
    
    [self respond];
    
    [popupDelegate delegateReloadButton];
    [self hidePopup:self];
}

@end