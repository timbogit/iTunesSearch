//
//  iTunesSearch.h
//  iTunesSearch
//
//  Created by Daniel Steinberg on 10/1/14.
//  Copyright (c) 2014 Dim Sum Thinking. All rights reserved.
//

#import <Foundation/Foundation.h>
@class iTunesItem;

@interface iTunesSearchController : NSObject
@property (assign, nonatomic) NSUInteger count;

- (iTunesItem *)itemAtIndex:(NSUInteger)index;
- (void)performSearchWithTerm:(NSString *)searchTerm;
@end
