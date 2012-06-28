//
//  IconButton.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/18/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconButton : UIButton

- (id)initWithFrame:(CGRect)frame andImage:(NSString *)imgName;
- (UIImage*)imageFilledWith:(UIColor*)color using:(UIImage*)startImage;

@end
