//
//  StringUtil.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/27/12.
//  Copyright (c) 2012 Bodkin Software, Inc. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil

+ (NSString *)trim:(NSString*)str 
{
	NSCharacterSet *seperator = [NSCharacterSet characterSetWithCharactersInString:@" \t\r\n\f"];
	NSString *newStr = [str stringByTrimmingCharactersInSet:seperator];
	return newStr;
}

+ (BOOL)checkBlank:(NSString *)str 
{
	NSScanner *scan = [[NSScanner alloc] initWithString:str];
	
	NSString *text = nil;
	[scan scanUpToCharactersFromSet:[NSCharacterSet alphanumericCharacterSet] intoString:&text];
	
	if([scan isAtEnd]) {
		return YES;
	}
	
	return NO;
}

+ (NSString *)getUnquotted:(NSString *)txt
{
    NSString *cleanBody = [txt stringByReplacingOccurrencesOfString:@"'" withString:@"APOS"];
    cleanBody = [cleanBody stringByReplacingOccurrencesOfString:@"\"" withString:@"QUOT"];
    return cleanBody;
}

+ (NSString *)getQuotted:(NSString *)txt
{
    NSString *origBody = [txt stringByReplacingOccurrencesOfString:@"APOS" withString:@"'"];
    origBody = [origBody stringByReplacingOccurrencesOfString:@"QUOT" withString:@"\""];
    return origBody;
}

+ (NSString *)stringByStrippingHTML:(NSString *)txt {
    NSMutableArray *strings = [[NSMutableArray alloc] init];
    
    NSString *document  = [NSString stringWithFormat:@"<x>%@</x>", txt];
    NSData *data  = [document dataUsingEncoding:txt.fastestEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser parse];
    
    NSString* result = [strings componentsJoinedByString:@""];
    
    return result;
}

+ (NSString *)flattenHtml:(NSString *)html {
	// note that this is open source, originally from:
	// http://www.rudis.net/content/2009/01/21/flatten-html-content-ie-strip-tags-cocoaobjective-c
	// this is pretty rudimentary and needs to be improved a lot!
    
	html = [html stringByReplacingOccurrencesOfString:@"\r" withString:@""];
	html = [html stringByReplacingOccurrencesOfString:@"<br>" withString:@" \n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];
	html = [html stringByReplacingOccurrencesOfString:@"<br/>" withString:@" \n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];	html = [html stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
	html = [html stringByReplacingOccurrencesOfString:@"<br />" withString:@" \n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];
	html = [html stringByReplacingOccurrencesOfString:@"</p>" withString:@"</p>\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];
	html = [html stringByReplacingOccurrencesOfString:@"</P>" withString:@"</p>\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];
	html = [html stringByReplacingOccurrencesOfString:@"</div>" withString:@"</div>\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];
	html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];
	
	NSScanner* styleScanner = [NSScanner scannerWithString:html];
	styleScanner.caseSensitive = NO;
	NSString *text = @"";
    while ([styleScanner isAtEnd] == NO) {
        // find start of tag
        [styleScanner scanUpToString:@"<style" intoString:NULL] ;
		
        // find end of tag
        [styleScanner scanUpToString:@"</style>" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@</style>", text] withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];
    }
	while ([styleScanner isAtEnd] == NO) {
        // find start of tag
        [styleScanner scanUpToString:@"<title" intoString:NULL] ;
		
        // find end of tag
        [styleScanner scanUpToString:@"</title>" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
				[ NSString stringWithFormat:@"%@</title>", text] withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];
    }
	
    NSString *htmlOut = [StringUtil stringByStrippingHTML:html];
	
    if([htmlOut length] > 0 && ![StringUtil checkBlank:htmlOut]) {
		return [StringUtil trim:htmlOut];
	}
	
	htmlOut = html;
	
	// remove anything inside <...>
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
		
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        htmlOut = [htmlOut stringByReplacingOccurrencesOfString:
                   [ NSString stringWithFormat:@"%@>", text] withString:@" "];
    }
	
	htmlOut = [htmlOut stringByReplacingOccurrencesOfString:@"\r" withString:@""];
	htmlOut = [htmlOut stringByReplacingOccurrencesOfString:@"\n \n" withString:@"\n\n"];
	htmlOut = [htmlOut stringByReplacingOccurrencesOfString:@"\n  \n" withString:@"\n\n"];
	htmlOut = [htmlOut stringByReplacingOccurrencesOfString:@"\n\n\n\n\n" withString:@"\n\n"];
	htmlOut = [htmlOut stringByReplacingOccurrencesOfString:@"\n\n\n\n" withString:@"\n\n"];
	htmlOut = [htmlOut stringByReplacingOccurrencesOfString:@"\n\n\n" withString:@"\n\n"];
	
	htmlOut = [htmlOut stringByReplacingOccurrencesOfString:@"&auml;" withString:@"ä"];
	htmlOut = [htmlOut stringByReplacingOccurrencesOfString:@"&ouml;" withString:@"ö"];
	htmlOut = [htmlOut stringByReplacingOccurrencesOfString:@"&uuml;" withString:@"ü"];
	htmlOut = [htmlOut stringByReplacingOccurrencesOfString:@"&Auml;" withString:@"Ä"];
	htmlOut = [htmlOut stringByReplacingOccurrencesOfString:@"&Ouml;" withString:@"Ö"];
	htmlOut = [htmlOut stringByReplacingOccurrencesOfString:@"&Uuml;" withString:@"Ü"];
    
	if([htmlOut length] > 0 && ![StringUtil checkBlank:htmlOut]) {
		return [StringUtil trim:htmlOut];
	}
    
	return [StringUtil trim:html];
}


@end
