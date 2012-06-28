//
//  QROptionGroup.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QROptionGroup.h"

@implementation QROptionGroup

@synthesize radioButtons;
@synthesize QRText;
@synthesize selectedTxt;

- (id)initWithFrame:(CGRect)frame andOptions:(NSArray *)options andColumns:(int)columns{
    
	NSMutableArray *arrTemp =[[NSMutableArray alloc] init];
	self.radioButtons = arrTemp;
    
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		int framex =0;
		framex= frame.size.width/columns;
		int framey = 0;
		framey =frame.size.height/([options count]/(columns));
		int rem =[options count]%columns;
		if(rem !=0){
			framey =frame.size.height/(([options count]/columns)+1);
		}
		int k = 0;
		for(int i=0;i<([options count]/columns);i++){
			for(int j=0;j<columns;j++){
				
			    int x = framex*0.25;
				int y = framey*0.25;
				UIButton *btTemp = [[UIButton alloc]initWithFrame:CGRectMake(0, framey*i+y, framex/2+x, framey/2+y)];
				[btTemp addTarget:self action:@selector(radioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
				btTemp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
				[btTemp setImage:[UIImage imageNamed:@"radio_off.png"] forState:UIControlStateNormal];
                [btTemp.titleLabel setBackgroundColor:[UIColor clearColor]];
                [btTemp.titleLabel setFont:[UIFont systemFontOfSize:12]];
                [btTemp.titleLabel setNumberOfLines:2];
                [btTemp.titleLabel setMinimumFontSize:12];
                [btTemp.titleLabel setTextColor:[UIColor whiteColor]];
                [btTemp.titleLabel setTextAlignment:UITextAlignmentLeft];
                [btTemp.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
				[btTemp setTitle:[options objectAtIndex:k] forState:UIControlStateNormal];
				[self.radioButtons addObject:btTemp];
				[self addSubview:btTemp];
				k++;
                
			}
		}
		
        for(int j=0;j<rem;j++){
            
            int x = framex*0.25;
            int y = framey*0.25;
            UIButton *btTemp = [[UIButton alloc]initWithFrame:CGRectMake(framex*j+x, framey*([options count]/columns), framex/2+x, framey/2+y)];
            [btTemp addTarget:self action:@selector(radioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            btTemp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btTemp setImage:[UIImage imageNamed:@"radio_off.png"] forState:UIControlStateNormal];
            [btTemp.titleLabel setBackgroundColor:[UIColor clearColor]];
            [btTemp.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [btTemp.titleLabel setNumberOfLines:2];
            [btTemp.titleLabel setMinimumFontSize:12];
            [btTemp.titleLabel setTextColor:[UIColor whiteColor]];
            [btTemp.titleLabel setTextAlignment:UITextAlignmentLeft];
            [btTemp.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
            [btTemp setTitle:[options objectAtIndex:k] forState:UIControlStateNormal];
            [self.radioButtons addObject:btTemp];
            [self addSubview:btTemp];
            k++;
			
		}	
		
	}
    [self setSelected:0];
    return self;
}

-(IBAction) radioButtonClicked:(UIButton *) sender{
	for(int i=0;i<[self.radioButtons count];i++){
		[[self.radioButtons objectAtIndex:i] setImage:[UIImage imageNamed:@"radio_off.png"] forState:UIControlStateNormal];
        
	}
	[sender setImage:[UIImage imageNamed:@"radio_on.png"] forState:UIControlStateNormal];

    QRText = [sender currentTitle];
}

-(void) removeButtonAtIndex:(int)index{
	[[self.radioButtons objectAtIndex:index] removeFromSuperview];
    
}

-(void) setSelected:(int) index{
	for(int i=0;i<[self.radioButtons count];i++){
		[[self.radioButtons objectAtIndex:i] setImage:[UIImage imageNamed:@"radio_off.png"] forState:UIControlStateNormal];
		
	}
	[[self.radioButtons objectAtIndex:index] setImage:[UIImage imageNamed:@"radio_on.png"] forState:UIControlStateNormal];
}

-(void) clearAll{
	for(int i=0;i<[self.radioButtons count];i++){
		[[self.radioButtons objectAtIndex:i] setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
		
	}
    
}


@end
