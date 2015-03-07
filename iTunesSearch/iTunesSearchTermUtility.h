//
//  iTunesSearchTermUtility.h
//  iTunesSearch
//
//  Created by Daniel Steinberg on 10/1/14.
//  Copyright (c) 2014 Dim Sum Thinking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iTunesSearchTermUtility : NSObject
+ (NSURL *)URLForSearchTerm:(NSString *)searchTerm;
@end
