//
//  DetailViewController.h
//  MailFlow
//
//  Created by Admin on 6/6/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "Email.h"
#import "EmailUtility.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Email *currentEmail;

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;

@property (weak, nonatomic) IBOutlet UILabel *lblFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblSubject;

@property (weak, nonatomic) IBOutlet UIButton *btnCal;
@property (weak, nonatomic) IBOutlet UIButton *btnAssign;
@property (weak, nonatomic) IBOutlet UIButton *btnPriority;
@property (weak, nonatomic) IBOutlet UIButton *btnTag;

@property (weak, nonatomic) IBOutlet UITextView *txtBody;

@end
