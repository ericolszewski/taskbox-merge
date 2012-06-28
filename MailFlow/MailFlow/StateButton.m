//
//  StateButton.m
//  MailFlow
//
//  Created by Admin on 6/6/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import "StateButton.h"

@implementation StateButton

@synthesize indexPath;
@synthesize stateEmail;
@synthesize stateDelegate;
@synthesize stateID, stateName, statePath, stateFrom, stateDirection, includePrompt, popup;

- (id)initWithFrame:(CGRect)frame setForEmail:(Email *)email atIndexPath:(NSIndexPath *)iPath withState:(int)state_id andStateName:(NSString *)state_name andPath:(NSString *)path andDirection:(BOOL)dir doPrompt:(BOOL)promptDo
{
    if(self){
        self = [super initWithFrame:frame];
        if (self) {
        
            [self setStateEmail:email];
            stateID = state_id;
            stateName = state_name;
            statePath = path;
            stateDirection = dir;
            stateFrom = stateEmail.fromEmail;
            indexPath = iPath;
            includePrompt = promptDo;

            [self setTitle:stateName forState:UIControlStateNormal];
        
            //Basic button setup
            [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 6.0, 0, 6.0)];
            [self.titleLabel setTextAlignment:UITextAlignmentCenter];
            [self.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
            [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
            [self.titleLabel setMinimumFontSize:6];
            [self.titleLabel setTextColor:[UIColor colorWithWhite:0.9 alpha:1]];
            [self.layer setBorderWidth:1.0f];
            [self.layer setCornerRadius:3.0f];
            if(stateDirection == YES)
            {
                [self.layer setBorderColor:[UIColor colorWithRed:0 green:0.25 blue:0 alpha:1].CGColor];
            } else 
            {
                [self.layer setBorderColor:[UIColor colorWithRed:0.33 green:0 blue:0 alpha:1].CGColor];
            }
        
            [self addTarget:self action:@selector(stateBtnPress) forControlEvents:UIControlEventTouchUpInside];
        } 
    }
    return self;
}

- (void)delegateReloadButton{
    [stateDelegate delegateReloadTable];
}

-(IBAction)stateBtnPress
{
    EmailUtility *eutil = [[EmailUtility alloc] init];
    
    if ([stateName isEqualToString:@"Delete"]){
        [eutil markDeleted:stateEmail];
        [stateDelegate delegateReloadTable];
    }
    if ([stateName isEqualToString:@"Not Task"]){
        [eutil updateEmail:stateEmail forState:stateID atPath:statePath];
        [stateDelegate delegateReloadTable];
    }
    
    if(includePrompt == YES){
        
        popup = [[QuickResponsePopup alloc] initWithFrame:CGRectMake(0, 0, self.superview.frame.size.width*.9, 300)
            forEmail:stateEmail 
            andState:stateID
            withTitle:stateName
            withPath:statePath
            doPrompt:YES];
        [popup setPopupDelegate:self];
        
        [popup show];
    }
}


@end