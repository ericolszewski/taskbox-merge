//
//  ProgressIndicator.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/26/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import "ProgressIndicator.h"

@implementation ProgressIndicator

@synthesize progView;
@synthesize progLabel;
@synthesize progMsg;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        SyncRunner *sr = [SyncRunner getRunner];
        [sr registerProgIndicator:self];
        
        progView = [[UIProgressView alloc] initWithFrame:CGRectMake(12, 0, 208, 12)];
        [progView setProgressViewStyle:UIProgressViewStyleBar];
        progView.progress = 0;
        
        progLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, 208, 12)];
        [progLabel setBackgroundColor:[UIColor clearColor]];
        [progLabel setLineBreakMode:UILineBreakModeClip];
        [progLabel setTextAlignment:UITextAlignmentCenter];
        [progLabel setFont:[UIFont boldSystemFontOfSize:10]];
        [progLabel setAdjustsFontSizeToFitWidth:YES];
        [progLabel setMinimumFontSize:10];
        [progLabel setTextColor:[UIColor whiteColor]];
        [progLabel setText:@"Loading..."];
        
        progMsg = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 208, 24)];
        [progMsg setBackgroundColor:[UIColor clearColor]];
        [progMsg setLineBreakMode:UILineBreakModeClip];
        [progMsg setTextAlignment:UITextAlignmentCenter];
        [progMsg setFont:[UIFont boldSystemFontOfSize:12]];
        [progMsg setAdjustsFontSizeToFitWidth:YES];
        [progMsg setMinimumFontSize:10];
        [progMsg setTextColor:[UIColor whiteColor]];
        [progMsg setAlpha:0.0f];
        
        [self addSubview:progView];
        [self addSubview:progLabel];
        [self addSubview:progMsg];
                     
    }
    return self;
}

- (void)didChangeProg:(NSDictionary *)progDict{
    [progLabel setAlpha:1.0f];
    [progView setAlpha:1.0f];
    [progMsg setAlpha:0];
    NSString *progStr = [progDict objectForKey:@"progMsg"];
    float newProg = [[progDict objectForKey:@"progress"] floatValue];
    [progLabel setText:progStr];
    progView.progress = newProg;
}

- (void)didChangeProgMsg:(NSString *)msg{
    [progLabel setAlpha:0];
    [progView setAlpha:0];
    [progMsg setAlpha:1.0f];
    [progMsg setText:msg];
}

@end
