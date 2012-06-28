//
//  State.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/21/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface State : NSObject

@property (nonatomic, assign) int state_id;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *label;

@property (nonatomic, assign) BOOL direction;


@end
