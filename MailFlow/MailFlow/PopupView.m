//
//  PopupView.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PopupView.h"

@implementation PopupView

@synthesize window;

- (void) show {
	[self showAnimated:YES];
}

- (void) showAnimated:(BOOL)animated {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.backgroundColor = [UIColor clearColor];
	
	self.center = CGPointMake(CGRectGetMidX(self.window.bounds), CGRectGetMidY(self.window.bounds));
	
	[self.window addSubview:self];
	[self.window makeKeyAndVisible];
	
	if (animated) {
		self.window.transform = CGAffineTransformMakeScale(1.5, 1.5);
		self.window.alpha = 0.0;
		
		__block UIWindow *animationWindow = self.window;
		
		[UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationCurveEaseIn animations:^() {
			animationWindow.transform = CGAffineTransformMakeScale(1.0, 1.0);
			animationWindow.alpha = 1.0;
		} completion:nil];
	}
}

- (void) hide {
	[self hideAnimated:YES];
}

- (void) hideAnimated:(BOOL)animated {
	if (animated) {
		__block UIWindow *animationWindow = self.window;
		
		[UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationCurveEaseOut animations:^() {
			animationWindow.transform = CGAffineTransformMakeScale(0.5, 0.5);
			animationWindow.alpha = 0.0f;
		} completion:nil];
	} else {
		self.window.hidden = YES;
		self.window = nil;
	}
}

@end