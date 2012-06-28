//
//  LoadingPopup.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PopupView.h"

@interface LoadingPopup : PopupView

@property(nonatomic, readonly) UIActivityIndicatorView *activityView;

@end