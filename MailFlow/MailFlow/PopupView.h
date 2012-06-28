//
//  PopupView.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupView : UIView

@property(nonatomic, strong) UIWindow *window;

- (void) show;
- (void) showAnimated:(BOOL)animated;

- (void) hide;
- (void) hideAnimated:(BOOL)animated;

@end