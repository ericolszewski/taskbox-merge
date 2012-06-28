//
//  EmailCell.m
//  MailFlow
//
//  Created by Admin on 6/5/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import "EmailCell.h"

@implementation EmailCell

@synthesize rootTable;
@synthesize states;
@synthesize posStateOne, posStateTwo, posStateThree, posStateFour;
@synthesize negStateOne, negStateTwo, negStateThree, negStateFour;
@synthesize posView = _posView;
@synthesize negView = _negView;
@synthesize iconView = _iconView;
@synthesize detailView = _detailView;
@synthesize swipeState = _swipeState;
@synthesize indexPath = _indexPath;
@synthesize cellDelegate;
@synthesize dateString;
@synthesize reply, cal, person, star, tags;

@synthesize currentEmail;
@synthesize datePicker;

@synthesize imgAvatar, lblDate, lblFrom, lblState, lblSubject, txtBody;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.swipeState = nil;
        
        // Email detail view
        _detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
        [_detailView setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bg_DetailCell"]]];
        
        imgAvatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_default"]];
        [imgAvatar setFrame:CGRectMake(12, 12, 48, 48)];
        [_detailView addSubview:imgAvatar];
        
        lblFrom = [[UILabel alloc] initWithFrame:CGRectMake(12, 64, 48, 10)];
        [lblFrom setBackgroundColor:[UIColor clearColor]];
        [lblFrom setLineBreakMode:UILineBreakModeClip];
        [lblFrom setTextAlignment:UITextAlignmentCenter];
        [lblFrom setFont:[UIFont boldSystemFontOfSize:10]];
        [lblFrom setAdjustsFontSizeToFitWidth:YES];
        [lblFrom setMinimumFontSize:6];
        [lblFrom setTextColor:[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:1]];
        [_detailView addSubview:lblFrom];
        
        lblDate = [[UILabel alloc] initWithFrame:CGRectMake(12, 78, 48, 10)];
        [lblDate setBackgroundColor:[UIColor clearColor]];
        [lblDate setLineBreakMode:UILineBreakModeClip];
        [lblDate setTextAlignment:UITextAlignmentCenter];
        [lblDate setFont:[UIFont systemFontOfSize:10]];
        [lblDate setAdjustsFontSizeToFitWidth:YES];
        [lblDate setMinimumFontSize:9];
        [lblDate setTextColor:[UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1]];
        [_detailView addSubview:lblDate];
        
        /*lblState = [[UILabel alloc] initWithFrame:CGRectMake(12, 96, 48, 16)];
         [lblState setLineBreakMode:UILineBreakModeClip];
         [lblState setTextAlignment:UITextAlignmentCenter];
         [lblState setFont:[UIFont boldSystemFontOfSize:10]];
         [lblState setAdjustsFontSizeToFitWidth:YES];
         [lblState setMinimumFontSize:6];
         [lblState setTextColor:[UIColor whiteColor]];
         [lblState setBackgroundColor:[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1]];
         [lblState setText:@"*NEW"];
         [_detailView addSubview:lblState];*/
        
        lblSubject = [[UILabel alloc] initWithFrame:CGRectMake(72, 12, 236, 12)];
        [lblSubject setBackgroundColor:[UIColor clearColor]];
        [lblSubject setFont:[UIFont boldSystemFontOfSize:12]];
        [lblSubject setTextColor:[UIColor colorWithRed:0 green:0.431 blue:0.705 alpha:1]];
        [_detailView addSubview:lblSubject];
        
        txtBody = [[UITextView alloc] initWithFrame:CGRectMake(64, 22, 236, 64)];
        [txtBody setBackgroundColor:[UIColor clearColor]];
        [txtBody setEditable:NO];
        [txtBody setUserInteractionEnabled:NO];
        [txtBody setScrollEnabled:NO];
        [txtBody setFont:[UIFont systemFontOfSize:11]];
        [txtBody setTextColor:[UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1]];
        [_detailView addSubview:txtBody];
    }
    return self;
}

- (void)setForEmail:(Email*)setEmail
{
    if (self)
    {
        [self setCurrentEmail:setEmail];
        
        // Change Avatar
        [imgAvatar setImage:[UIImage imageNamed:[currentEmail getAvatarName]]];
        
        
        // Setup Positive view
        _posView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
        [_posView setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bg_PosCell"]]];
        
        UIColor *posBntColor = [UIColor colorWithRed:0 green:0.2 blue:0 alpha:1];
        
        
        // Setup Negative view
        _negView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
        [_negView setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bg_NegCell"]]];
        
        UIColor *negBntColor = [UIColor colorWithRed:0.25 green:0 blue:0 alpha:1];
        
        
        // Setup State buttons
        DBStates *sdb = [[DBStates alloc] init];
        states = [sdb getAllStates];
        
        if ([states count] > 0){
            posStateOne = [states objectAtIndex:0];
            posStateTwo = [states objectAtIndex:1];
            posStateThree = [states objectAtIndex:2];
            posStateFour = [states objectAtIndex:3];
            
            negStateOne = [states objectAtIndex:4];
            negStateTwo = [states objectAtIndex:5];
            negStateThree = [states objectAtIndex:6];
            negStateFour = [states objectAtIndex:7];
        }
        
        StateButton *posBtnOne = [[StateButton alloc] initWithFrame:CGRectMake(12, 12, 65, 24) setForEmail:currentEmail atIndexPath:self.indexPath withState:posStateOne.state_id andStateName:posStateOne.name andPath:posStateOne.path andDirection:YES doPrompt:YES];
        [posBtnOne setBackgroundColor:posBntColor];
        [posBtnOne setStateDelegate:self];
        [_posView addSubview:posBtnOne];
        
        StateButton *posBtnTwo = [[StateButton alloc] initWithFrame:CGRectMake(89, 12, 65, 24) setForEmail:currentEmail atIndexPath:self.indexPath withState:posStateTwo.state_id andStateName:posStateTwo.name andPath:posStateTwo.path andDirection:YES doPrompt:YES];
        [posBtnTwo setBackgroundColor:posBntColor];
        [posBtnTwo setStateDelegate:self];
        [_posView addSubview:posBtnTwo];
        
        StateButton *posBtnThree = [[StateButton alloc] initWithFrame:CGRectMake(166, 12, 65, 24) setForEmail:currentEmail atIndexPath:self.indexPath withState:posStateThree.state_id andStateName:posStateThree.name andPath:posStateThree.path andDirection:YES doPrompt:YES];
        [posBtnThree setBackgroundColor:posBntColor];
        [posBtnThree setStateDelegate:self];
        [_posView addSubview:posBtnThree];
        
        StateButton *posBtnFour = [[StateButton alloc] initWithFrame:CGRectMake(243, 12, 65, 24) setForEmail:currentEmail atIndexPath:self.indexPath withState:posStateFour.state_id andStateName:posStateFour.name andPath:posStateFour.path andDirection:YES doPrompt:YES];
        [posBtnFour setBackgroundColor:posBntColor]; 
        [posBtnFour setStateDelegate:self];       
        [_posView addSubview:posBtnFour];
        
        StateButton *negBtnOne = [[StateButton alloc] initWithFrame:CGRectMake(12, 12, 65, 24) setForEmail:currentEmail atIndexPath:self.indexPath withState:negStateOne.state_id andStateName:negStateOne.name andPath:negStateOne.path andDirection:NO doPrompt:NO];
        [negBtnOne setBackgroundColor:negBntColor];
        [negBtnOne setStateDelegate:self];
        [_negView addSubview:negBtnOne];
        
        StateButton *negBtnTwo = [[StateButton alloc] initWithFrame:CGRectMake(89, 12, 65, 24) setForEmail:currentEmail atIndexPath:self.indexPath withState:negStateTwo.state_id andStateName:negStateTwo.name andPath:negStateTwo.path andDirection:NO doPrompt:YES];
        [negBtnTwo setBackgroundColor:negBntColor];
        [negBtnTwo setStateDelegate:self];
        [_negView addSubview:negBtnTwo];
        
        StateButton *negBtnThree = [[StateButton alloc] initWithFrame:CGRectMake(166, 12, 65, 24) setForEmail:currentEmail atIndexPath:self.indexPath withState:negStateThree.state_id andStateName:negStateThree.name andPath:negStateThree.path andDirection:NO doPrompt:YES];
        [negBtnThree setBackgroundColor:negBntColor];
        [negBtnThree setStateDelegate:self];
        [_negView addSubview:negBtnThree];
        
        StateButton *negBtnFour = [[StateButton alloc] initWithFrame:CGRectMake(243, 12, 65, 24) setForEmail:currentEmail atIndexPath:self.indexPath withState:negStateFour.state_id andStateName:negStateFour.name andPath:negStateFour.path andDirection:NO doPrompt:NO];
        [negBtnFour setBackgroundColor:negBntColor];
        [negBtnFour setStateDelegate:self];
        [_negView addSubview:negBtnFour];
        
        
        // Add Icons
        _iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.contentView.frame.size.width, 40)];
        [_iconView setBackgroundColor:[UIColor clearColor]];
        
        reply = [[IconButton alloc] initWithFrame:CGRectMake(20,0,32,32) andImage:@"icon_reply"];
        [_iconView addSubview:reply];
        cal = [[IconButton alloc] initWithFrame:CGRectMake(82,0,32,32) andImage:@"icon_cal"];
        [_iconView addSubview:cal];
        [cal addTarget:self action:@selector(showDueDate:)forControlEvents:UIControlEventTouchUpInside];
        person = [[IconButton alloc] initWithFrame:CGRectMake(144,0,32,32) andImage:@"icon_person"];
        [_iconView addSubview:person];
        [person addTarget:self action:@selector(showAssign:)forControlEvents:UIControlEventTouchUpInside];
        star = [[IconButton alloc] initWithFrame:CGRectMake(206,0,32,32) andImage:@"icon_5star"];
        [_iconView addSubview:star];
        [star addTarget:self action:@selector(showPicker:)forControlEvents:UIControlEventTouchUpInside];
        tags = [[IconButton alloc] initWithFrame:CGRectMake(268,0,32,32) andImage:@"icon_tags"];
        [_iconView addSubview:tags];
        
        
        // Add Views to contentView
        [self.contentView addSubview:_negView];
        [self.contentView addSubview:_posView];
        [self.contentView addSubview:_iconView];
        [self.contentView addSubview:_detailView];
        
        
        // Create the gesture recognizers
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRightInCell:)];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeftInCell:)];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        
        [self addGestureRecognizer:swipeRight];
        [self addGestureRecognizer:swipeLeft];
        
        
        // Prevent selection highlighting
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)delegateReloadTable{
    [cellDelegate delegateCloseCell:_indexPath];
    [cellDelegate delegateReloadData];
}

- (IBAction)didSwipeRightInCell:(id)sender 
{
    // Inform delegate of right swipe
    [cellDelegate delegateCellSwipe:_indexPath];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    if(self.swipeState == nil)
    {
        [_negView setFrame:CGRectMake(-self.contentView.frame.size.width, 0, self.contentView.frame.size.width, 94)];
        [UIView animateWithDuration:0.3 animations:^{
            [_detailView setFrame:CGRectMake(self.contentView.frame.size.width, 0, self.contentView.frame.size.width, 94)];
        } completion:^(BOOL finished) {
            // Bounce lower view
            [UIView animateWithDuration:0.2 animations:^{
                [_posView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    [_posView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
                }];
            }];
        }];
        self.swipeState = @"swipedRight"; 
    }
    
    if(self.swipeState == @"swipedLeft")
    {
        [UIView animateWithDuration:0.3 animations:^{
            [_detailView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                [_detailView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
                [_posView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
            }];
        }];
        self.swipeState = nil; 
    }
}

- (IBAction)didSwipeLeftInCell:(id)sender 
{
    // Inform delegate of left swipe
    [cellDelegate delegateCellSwipe:_indexPath];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    if(self.swipeState == nil)
    {
        [_posView setFrame:CGRectMake(-self.contentView.frame.size.width, 0, self.contentView.frame.size.width, 94)];
        [UIView animateWithDuration:0.3 animations:^{
            [_detailView setFrame:CGRectMake(-self.contentView.frame.size.width, 0, self.contentView.frame.size.width, 94)];
        } completion:^(BOOL finished) {
            // Bounce lower view
            [UIView animateWithDuration:0.2 animations:^{
                [_negView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    [_negView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
                }];
            }];
        }];
        self.swipeState = @"swipedLeft"; 
    }
    
    if(self.swipeState == @"swipedRight")
    {
        [UIView animateWithDuration:0.3 animations:^{
            [_detailView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                [_detailView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
                [_negView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 94)];
            }];
        }];
        self.swipeState = nil; 
    }
}
/////////////////////////////////////////DATE//////////////////////////////////////////
- (IBAction)showDueDate:(id)sender{
    
    CGRect toolbarTargetFrame = CGRectMake(0, self.contentView.bounds.size.height-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.contentView.bounds.size.height, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.superview addSubview:darkView];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height, 320, 216)];
    datePicker.tag = 10;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger check = [prefs integerForKey:@"Due"];
    
    if(check == 1)
    {
        NSInteger month = [prefs integerForKey:@"monthKey"];
        NSInteger week = [prefs integerForKey:@"weekKey"];
        NSInteger day = [prefs integerForKey:@"dayKey"];
        NSInteger hour = [prefs integerForKey:@"hourKey"];
        
        NSDate *todaysDate = [NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setMonth:month];
        [dateComponents setWeek:week];
        [dateComponents setDay:day];
        [dateComponents setHour:hour];
        datePicker.date = [gregorian dateByAddingComponents:dateComponents toDate:todaysDate  options:0];
    }
    
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [self.superview addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    [self.superview addSubview:toolBar];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.superview addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.85;
    [UIView commitAnimations];
}

- (void)dismissDatePicker:(id)sender {
    DBTask *dbt = [[DBTask alloc] init];
    DBEmails *dbe = [[DBEmails alloc] init];
    CGRect toolbarTargetFrame = CGRectMake(0, self.contentView.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.contentView.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.superview viewWithTag:9].alpha = 0;
    [self.superview viewWithTag:10].frame = datePickerTargetFrame;
    [self.superview viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
    Task *task = [[Task alloc] init];
    task = [dbt getTask:currentEmail.email_id];
    if (task.task_id == 0) {
        task.email_id = currentEmail.email_id;
        task.title = currentEmail.subject;
        task.assign = currentEmail.to;
        BOOL success = [dbt insertTask:task];
        if (success){
            [dbe hasTask:currentEmail];
        }
    }
    [dbt updateDate:currentEmail:dateString];
}

- (IBAction)changeDate:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ssZZZ"];
    dateString = [formatter stringFromDate:datePicker.date];
}

- (void)removeViews:(id)object {
    [[self.superview viewWithTag:9] removeFromSuperview];
    [[self.superview viewWithTag:10] removeFromSuperview];
    [[self.superview viewWithTag:11] removeFromSuperview];
}
/////////////////////////////////////////DATE//////////////////////////////////////////

/////////////////////////////////////////PICKER//////////////////////////////////////////
- (IBAction)showPicker:(id)sender{
    UIPickerView *myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height, 320, 200)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    [self.superview addSubview:myPickerView];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    row++;
    DBTask *dbt = [[DBTask alloc] init];
    DBEmails *dbe = [[DBEmails alloc] init];
    Task *task = [[Task alloc] init];
    task = [dbt getTask:currentEmail.email_id];
    if (task.task_id == 0) {
        task.email_id = currentEmail.email_id;
        task.title = currentEmail.subject;
        task.assign = currentEmail.to;
        BOOL success = [dbt insertTask:task];
        if (success){
            [dbe hasTask:currentEmail];
        }
    }
    [dbt updatePriority:currentEmail:row];
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 480);
	pickerView.transform = transform;
	[UIView commitAnimations];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = 5;
    return numRows;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = [@"" stringByAppendingFormat:@"%d",(row+1)];
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    return sectionWidth;
}
/////////////////////////////////////////PICKER//////////////////////////////////////////
/////////////////////////////////////////ASSIGN//////////////////////////////////////////
- (IBAction)showAssign:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Assign"
                                                    message:@"Please enter email address of assignee"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Done", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alert textFieldAtIndex:0];
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.placeholder = @"email address";
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex > 0) {
        UITextField *textField = [alert textFieldAtIndex:0];
        NSString *text = textField.text; 
        if(text == nil) { 
            return; 
        } else { 
            DBTask *dbt = [[DBTask alloc] init];
            DBEmails *dbe = [[DBEmails alloc] init];
            Task *task = [[Task alloc] init];
            task = [dbt getTask:currentEmail.email_id];
            if (task.task_id == 0) {
                task.email_id = currentEmail.email_id;
                task.title = currentEmail.subject;
                task.assign = text;
                BOOL success = [dbt insertTask:task];
                if (success){
                    [dbe hasTask:currentEmail];
                }
            }
            [dbt updateAssign:currentEmail:text]; 
        } 
    } 
    else
        return;
}

/////////////////////////////////////////ASSIGN//////////////////////////////////////////
@end
