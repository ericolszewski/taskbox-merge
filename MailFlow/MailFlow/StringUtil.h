//
//  StringUtil.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/27/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

+ (NSString *)trim:(NSString*)str;
+ (BOOL)checkBlank:(NSString *)str;

+ (NSString *)getUnquotted:(NSString *)txt;
+ (NSString *)getQuotted:(NSString *)txt;

+ (NSString *)stringByStrippingHTML:(NSString *)txt;
+ (NSString *)flattenHtml:(NSString *)html;

@end
