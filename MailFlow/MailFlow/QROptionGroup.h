//
//  QROptionGroup.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QROptionGroup : UIView {
	NSMutableArray *radioButtons;
}

@property (nonatomic,retain) NSMutableArray *radioButtons;
@property (nonatomic, strong) NSString *QRText;
@property (nonatomic, strong) NSString *selectedTxt;

- (id)initWithFrame:(CGRect)frame andOptions:(NSArray *)options andColumns:(int)columns;

- (IBAction) radioButtonClicked:(UIButton *) sender;

- (void) removeButtonAtIndex:(int)index;
- (void) setSelected:(int) index;
- (void) clearAll;
@end
