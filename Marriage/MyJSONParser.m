//
//  MyJSONParser.m
//  SmartLocator
//
//  Created by Ehab Amer on 10/30/11.
//  Copyright (c) 2011 LinkDev. All rights reserved.
//

#import "MyJSONParser.h"

@implementation MyJSONParser

static id requestDelegate = nil;
static NSString * urlStrng = nil;
//static SEL requestSelector = nil;


+(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    string = [string stringByReplacingOccurrencesOfString:@"&raquo;" withString:@">>"];
    string = [string stringByReplacingOccurrencesOfString:@"&laquo;" withString:@"<<"];
    string = [string stringByReplacingOccurrencesOfString:@"&#8211;" withString:@"-"];
    return string;
}
+ (NSString *)stringWithUrl:(NSURL *)url
{
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                            timeoutInterval:30];
    // Fetch the JSON response
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
    
	// Make synchronous request
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    
 	// Construct a String around the Data from the response
	return [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
}

+(NSString *)stringWithUrl:(NSURL *)url andParameterString:(NSString *)pString
{
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                            timeoutInterval:30];
    
    //[urlRequest setValue:pString forHTTPHeaderField:@"POST"];
    [urlRequest setHTTPBody:[pString dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest setHTTPMethod:@"POST"];
    // Fetch the JSON response
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
    
	// Make synchronous request
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    
 	// Construct a String around the Data from the response
    NSString *reply = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
	return reply;
}

+(NSString *)stringWithRequest:(NSMutableURLRequest *)rqust
{
    // Fetch the JSON response
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
    rqust.timeoutInterval = 30;
    
	// Make synchronous request
	urlData = [NSURLConnection sendSynchronousRequest:rqust
                                    returningResponse:&response
                                                error:&error];
    
 	// Construct a String around the Data from the response
	return [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
}

+(id)objectWithRequest:(NSMutableURLRequest *)rqust
{
//    SBJsonParser *jsonParser = [SBJsonParser new];
	NSString *jsonString = [self stringWithRequest:rqust];
    rqust.timeoutInterval = 30;
    
	// Parse the JSON into an Object
//	return [jsonParser objectWithString:jsonString error:NULL];
    
    NSData *dta = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *parseError = nil;
    id json = [NSJSONSerialization JSONObjectWithData:dta options:0 error:&parseError];
    
    if (json) {
        return json;
    }else
    {
        return nil;
    }
}

+ (id) objectWithUrl:(NSURL *)url
{
//	SBJsonParser *jsonParser = [SBJsonParser new];
	NSString *jsonString = [self stringWithUrl:url];
    
    //jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    
//    jsonString = [jsonString stringByReplacingOccurrencesOfString:@":null" withString:@"\"\""];
    
	// Parse the JSON into an Object
//	return [jsonParser objectWithString:jsonString error:NULL];
    
    NSData *dta = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *parseError = nil;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:dta options:0 error:&parseError];
    
    if (json) {
        return json;
    }else
    {
        return nil;
    }
}

+ (id) objectWithUrlString:(NSString *)urlString
{
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
	NSString *jsonString = [self stringWithUrl:url];
    
    NSData *dta = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *parseError = nil;
    id json = [NSJSONSerialization JSONObjectWithData:dta options:0 error:&parseError];
    
    if (json)
    {
        return json;
    }else
    {
        return nil;
    }
}

+(id)objectWithPostString:(NSString *)urlString
{
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
	NSString *jsonString = [self stringWithUrl:url];
    
    NSData *dta = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *parseError = nil;
    id json = [NSJSONSerialization JSONObjectWithData:dta options:0 error:&parseError];
    
    if (json)
    {
        return json;
    }else
    {
        return nil;
    }

}


+(id)objectWithUrl:(NSURL *)url andParameterString:(NSString *)pString
{
//    SBJsonParser *jsonParser = [SBJsonParser new];
	NSString *jsonString = [self stringWithUrl:url andParameterString:pString];
    
//    jsonString = [jsonString stringByReplacingOccurrencesOfString:@":null" withString:@"\"\""];
    
	// Parse the JSON into an Object
//	return [jsonParser objectWithString:jsonString error:NULL];
    
    NSData *dta = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *parseError = nil;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:dta options:0 error:&parseError];
    
    if (json) {
        return json;
    }else
    {
        return nil;
    }
}

+(id)objectWithString:(NSString *)str
{
//    SBJsonParser *jsonParser = [SBJsonParser new];
//    
//	return [jsonParser objectWithString:str error:NULL];
    
    NSData *dta = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *parseError = nil;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:dta options:0 error:&parseError];
    
    if (json) {
        return json;
    }else
    {
        return nil;
    }
}


+ (void) objectWithUrlString:(NSString *)urlString responseDelegate:(id)delegate responseSelector:(SEL)selector
{
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url
                                                              cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                          timeoutInterval:160];
//    NSArray                 *cookies;
//    NSDictionary            *cookieHeaders;
//    cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
//    
//    cookieHeaders = [ NSHTTPCookie requestHeaderFieldsWithCookies: cookies ];
//    [ urlRequest setValue: [ cookieHeaders objectForKey: @"Cookie" ] forHTTPHeaderField: @"Cookie" ];
//    [urlRequest setHTTPShouldHandleCookies:YES];
//    if ([urlString containsString:@"api01.khalifafund.ae/LMS_API/API.svc/"])
//    {
//        [urlRequest setHTTPMethod:@"GET"];
//    }
//    else
//    {
//        [urlRequest setHTTPMethod:@"POST"];
//    }
    // Fetch the JSON response
    
    // Make synchronous request
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        //    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *parseError = nil;
        
        RequestResponseObject * responce = [[RequestResponseObject alloc]init];
        if (error) {
            [responce setError:error];
        }
        
        if (parseError) {
            NSLog(@"Connection Error: %@",[parseError localizedDescription]);
            NSLog(@"%@",urlString);
        }
        
        if (data == nil) {
            [delegate performSelectorOnMainThread:selector withObject:nil waitUntilDone:NO];
            return ;
        }
        
        // when json is incorrect format
        NSString *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
        
        if ([dic isKindOfClass:[NSNull class]] || dic == nil)
        {
            [delegate performSelectorOnMainThread:selector withObject:nil waitUntilDone:NO];
            return ;
        }
        
        //NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //dataString = [self htmlEntityDecode:dataString];
//        data = [dic dataUsingEncoding:NSUTF8StringEncoding];
        
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
        [responce setValue:json];
        
        
        if (json)
        {
            //[delegate performSelector:selector withObject:json];
            [delegate performSelectorOnMainThread:selector withObject:json waitUntilDone:YES];
        }else
        {
            NSLog(@"Parser Error: %@",[parseError localizedDescription]);
            NSLog(@"%@",urlString);
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Data with error: %@",str);
            [responce setValue:str];
            //            [delegate performSelector:selector withObject:nil];
            [delegate performSelectorOnMainThread:selector withObject:responce waitUntilDone:NO];
        }
    }];
}



+ (void) stringWithUrlString:(NSString *)urlString responseDelegate:(id)delegate responseSelector:(SEL)selector
{
    //urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    
    //
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                            timeoutInterval:30];
    // Fetch the JSON response
    
    
	// Make synchronous request
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        RequestResponseObject * responce = [[RequestResponseObject alloc]init];
        if (error) {
            [responce setError:error];
        }
        
        
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        [delegate performSelector:selector withObject:dataString];
        if (data) {
            [responce setValue:dataString];
        }
        [delegate performSelectorOnMainThread:selector withObject:responce waitUntilDone:NO];
//        NSError *parseError = nil;
//        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
//        
//        if (json) {
//            [delegate performSelector:selector withObject:json];
//        }else
//        {
//            [delegate performSelector:selector withObject:nil];
//        }
    }];
    
}

//-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    //if (buttonIndex != [alertView cancelButtonIndex])
//    //{
//    NSLog(@"Here");
//        switch (alertView.tag) {
//            case 1:
//                [MyJSONParser objectWithUrlString:urlStrng responseDelegate:requestDelegate responseSelector:requestSelector];
//                break;
//            case 2:
//                [MyJSONParser stringWithUrlString:urlStrng responseDelegate:requestDelegate responseSelector:requestSelector];
//                break;
//                
//            default:
//                break;
//        }
//
//    //}
//    
//}

//-(void) alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    //if (buttonIndex != [alertView cancelButtonIndex])
//    //{
//        NSLog(@"Here");
//        switch (alertView.tag) {
//            case 1:
//                [MyJSONParser objectWithUrlString:urlStrng responseDelegate:requestDelegate responseSelector:requestSelector];
//                break;
//            case 2:
//                [MyJSONParser stringWithUrlString:urlStrng responseDelegate:requestDelegate responseSelector:requestSelector];
//                break;
//                
//            default:
//                break;
//        }
//    
//   // }
//}


+(NSDate*)dateFromString:(NSString *)str
{
    NSString *string=@"03/08/2016 7:30:00 AM";
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"M/dd/yyyy HH:mm:ss a"];
    NSDate *date = [formatter dateFromString:string];
    return date;
    
    
}
@end
