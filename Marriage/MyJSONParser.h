//
//  MyJSONParser.h
//  SmartLocator
//
//  Created by Ehab Amer on 10/30/11.
//  Copyright (c) 2011 LinkDev. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SBJson.h"
#import "RequestResponseObject.h"

//This is a helper class to simplify loading JSON data from URLs or from URLRequests

@interface MyJSONParser : NSObject <NSURLConnectionDelegate>
{
   
}

+(NSString *)stringWithUrl:(NSURL *)url;
+(NSString *)stringWithRequest:(NSMutableURLRequest *)rqust;
+(NSString *)stringWithUrl:(NSURL *)url andParameterString:(NSString *)pString;

+(id)objectWithUrl:(NSURL *)url;
+(id) objectWithUrlString:(NSString *)urlString;
+(id)objectWithUrl:(NSURL *)url andParameterString:(NSString *)pString;
+(id)objectWithString:(NSString *)str;
+(id)objectWithPostString:(NSString *)str;
+(id)objectWithRequest:(NSMutableURLRequest *)rqust;

+ (void) objectWithUrlString:(NSString *)urlString responseDelegate:(id)delegate responseSelector:(SEL)selector;
+ (void) stringWithUrlString:(NSString *)urlString responseDelegate:(id)delegate responseSelector:(SEL)selector;
//+ (void) imageWithUrlString:(NSString *)urlString responseDelegate:(id)delegate responseSelector:(SEL)selector withBody:(NSData*)body;
//+ (RequestResponseObject *) newobjectWithUrlString:(NSString *)urlString responseDelegate:(id)delegate responseSelector:(SEL)selector;
+(NSDate*)dateFromString:(NSString *)str;
@end
