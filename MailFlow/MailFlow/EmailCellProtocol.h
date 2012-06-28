//
//  EmailCellProtocol.h
//  MailFlow
//
//  Created by Admin on 6/5/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EmailCellProtocol <NSObject>

-(void)delegateReloadData;
-(void)delegateCloseCell:(NSIndexPath *)indexPath;
-(void)delegateCellSwipe:(NSIndexPath *)indexPath;

@end
