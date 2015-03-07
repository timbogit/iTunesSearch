//
//  iTunesSearchTermUtility.m
//  iTunesSearch
//
//  Created by Daniel Steinberg on 10/1/14.
//  Copyright (c) 2014 Dim Sum Thinking. All rights reserved.
//

#import "iTunesSearchTermUtility.h"

@implementation iTunesSearchTermUtility

+ (NSURL *)URLForSearchTerm:(NSString *)searchTerm {
    NSString *escapedSearchTerm = [self escapedQueryStringValueFromString:searchTerm];
    NSString *baseURL = @"http://itunes.apple.com/search";
    NSString *queryString = [NSString stringWithFormat:@"term=%@&limit=25&entity=software", escapedSearchTerm];
    NSString *searchString = [NSString stringWithFormat:@"%@?%@", baseURL, queryString ];
    return  [NSURL URLWithString:searchString];
}
+ (NSString *)escapedQueryStringValueFromString:(NSString *)rawString {
    CFStringEncoding convertedEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
    // Tell Core Foundation which special characters to percent-escape
    // Do NOT percent escape spaces; iTunes expects those to be replaced with +
    CFStringRef escapedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (__bridge CFStringRef)rawString,
                                                                        CFSTR(" "),
                                                                        CFSTR("%'\"?&=+"),
                                                                        convertedEncoding);
    // Replace the spaces with +
    NSString *finishedString = CFBridgingRelease(escapedString);
    finishedString = [finishedString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    return finishedString;
}

@end
