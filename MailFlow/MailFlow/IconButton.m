//
//  IconButton.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/18/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import "IconButton.h"

@implementation IconButton

- (id)initWithFrame:(CGRect)frame andImage:(NSString *)imgName
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        UIImage* buttonImage = [UIImage imageNamed:imgName];
        UIImage* filledImage = [self imageFilledWith:[UIColor colorWithWhite:1 alpha:0.85] using:buttonImage];
        [self setImage:filledImage forState:UIControlStateNormal];
    }
    return self;
}

-(UIImage*)imageFilledWith:(UIColor*)color using:(UIImage*)startImage
{
    // Create the proper sized rect
    CGRect imageRect = CGRectMake(0, 0, CGImageGetWidth(startImage.CGImage), CGImageGetHeight(startImage.CGImage));
    
    // Create a new bitmap context
    CGContextRef context = CGBitmapContextCreate(NULL, imageRect.size.width, imageRect.size.height, 8, 0, CGImageGetColorSpace(startImage.CGImage), kCGImageAlphaPremultipliedLast);
    
    // Use the passed in image as a clipping mask
    CGContextClipToMask(context, imageRect, startImage.CGImage);
    // Set the fill color
    CGContextSetFillColorWithColor(context, color.CGColor);
    // Fill with color
    CGContextFillRect(context, imageRect);
    
    // Generate a new image
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage* newImage = [UIImage imageWithCGImage:newCGImage scale:startImage.scale orientation:startImage.imageOrientation];
    
    // Cleanup
    CGContextRelease(context);
    CGImageRelease(newCGImage);
    
    return newImage;
}
@end
