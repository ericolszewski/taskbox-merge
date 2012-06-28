//
//  ProgressIndicator.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/26/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SyncRunner.h"

@interface ProgressIndicator : UIView

@property(nonatomic,strong) IBOutlet UIProgressView *progView;
@property(nonatomic,strong) IBOutlet UILabel *progLabel;
@property(nonatomic,strong) IBOutlet UILabel *progMsg;

- (void)didChangeProg:(NSDictionary *)progDict;
- (void)didChangeProgMsg:(NSString *)msg;

@end
