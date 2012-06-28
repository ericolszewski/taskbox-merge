//
//  StateButton.h
//  MailFlow
//
//  Created by Admin on 6/6/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "QuickResponsePopup.h"

#import "Email.h"
#import "Task.h"

#import "EmailUtility.h"

#import "StateButtonProtocol.h"
#import "QuickResponsePopupProtocol.h"

@interface StateButton : UIButton <QuickResponsePopupProtocol>
{
    UIAlertView *deletedAlert;
}
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) id <StateButtonProtocol> stateDelegate;

@property (nonatomic, strong) Email *stateEmail;
@property (nonatomic, assign) int stateID;
@property (nonatomic, strong) NSString *stateName;
@property (nonatomic, strong) NSString *statePath;
@property (nonatomic, strong) NSString *stateFrom;

@property (nonatomic) BOOL stateDirection;
@property (nonatomic) BOOL includePrompt;

@property (nonatomic, strong) QuickResponsePopup *popup;

- (id)initWithFrame:(CGRect)frame setForEmail:(Email *)email atIndexPath:(NSIndexPath *)iPath withState:(int)state_id andStateName:(NSString *)state_name andPath:(NSString *)path andDirection:(BOOL)dir doPrompt:(BOOL)promptDo;

@end