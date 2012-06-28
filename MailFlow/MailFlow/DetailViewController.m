//
//  DetailViewController.m
//  MailFlow
//
//  Created by Admin on 6/6/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize currentEmail;
@synthesize imgAvatar;
@synthesize lblFrom;
@synthesize lblDate;
@synthesize lblSubject;
@synthesize btnCal;
@synthesize btnAssign;
@synthesize btnPriority;
@synthesize btnTag;
@synthesize txtBody;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.lblSubject.text = currentEmail.subject;
    [imgAvatar setImage:[UIImage imageNamed:[currentEmail getAvatarName]]];
    self.lblFrom.text = currentEmail.fromName;
    self.lblDate.text = [currentEmail getFormattedDate];
    self.txtBody.text = [currentEmail getOrigBody:currentEmail.bodyHTML];
    
    EmailUtility *eutil = [[EmailUtility alloc] init];
    if (!currentEmail.read) { [eutil markRead:currentEmail]; }
}

- (void)viewDidUnload
{
    [self setImgAvatar:nil];
    [self setLblFrom:nil];
    [self setLblDate:nil];
    [self setLblSubject:nil];
    [self setBtnCal:nil];
    [self setBtnAssign:nil];
    [self setBtnPriority:nil];
    [self setBtnTag:nil];
    [self setTxtBody:nil];
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
