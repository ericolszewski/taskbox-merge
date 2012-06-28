//
//  LoadingPopup.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoadingPopup.h"

@implementation LoadingPopup

@synthesize activityView=_activityView;

- (id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
		self.layer.cornerRadius = 5.0;
		
		_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[self addSubview:_activityView];
	}
	return self;
}

- (void) layoutSubviews 
{
	[super layoutSubviews];
	
	CGRect activityFrame = self.activityView.frame;
	activityFrame.origin = CGPointMake(
        floorf((CGRectGetWidth(self.frame) - CGRectGetWidth(activityFrame)) / 2.0),
        floorf((CGRectGetHeight(self.frame) - CGRectGetHeight(activityFrame)) / 2.0)
    );
	self.activityView.frame = activityFrame;
}

- (void) showAnimated:(BOOL)animated 
{
	[self.activityView startAnimating];
	[super showAnimated:animated];
}

@end