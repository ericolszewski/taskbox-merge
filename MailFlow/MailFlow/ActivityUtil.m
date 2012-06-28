//
//  ActivityUtil.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/27/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import "ActivityUtil.h"

@implementation ActivityUtil

static int counter = 0;

+ (void)activityOn {
	counter++;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+ (void)activityOff {
	counter--;
	if (counter <= 0) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		counter = 0;
	}
}

@end
