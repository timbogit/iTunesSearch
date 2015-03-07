//
//  iTunesSearch.m
//  iTunesSearch
//
//  Created by Daniel Steinberg on 10/1/14.
//  Copyright (c) 2014 Dim Sum Thinking. All rights reserved.
//

#import "iTunesSearchController.h"
#import "iTunesItem.h"
#import "iTunesSearchTermUtility.h"

@interface iTunesSearchController() <iTunesItemDelegate>
@property (strong, nonatomic) NSMutableArray *results;
@end

@implementation iTunesSearchController


- (void)performSearchWithTerm:(NSString *)searchTerm {
    NSURL *searchURL = [iTunesSearchTermUtility URLForSearchTerm:searchTerm];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:searchURL
                                      completionHandler:^(NSData *data,
                                                          NSURLResponse *response,
                                                          NSError *error) {
                                          if (data == nil) {
                                              NSLog(@"Error searching iTunes: %@", error);
                                          } else {
                                              [self processSearchResults:data];
                                          }
                                      }];
    [dataTask resume];
}
- (void)processSearchResults:(NSData *)data {
    NSError *error;
    NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:&error];
    if (resultsDictionary == nil) {
        NSLog(@"ERROR processing JSON data: %@", error);
    } else {
        NSArray *tempResults = [resultsDictionary objectForKey:@"results"];
        for (NSDictionary *result in tempResults) {
            iTunesItem *item = [[iTunesItem alloc] initWithDictionary:result];
            item.delegate = self;
            [self.results addObject:item];
        }
    }
}


#pragma mark - lifecycle

- (id)init {
    self = [super init];
    if (self) {
        _results = [[NSMutableArray alloc] initWithCapacity:25];
    }
    return self;
}

#pragma mark - accessor

- (iTunesItem *)itemAtIndex:(NSUInteger)index {
    return [self.results objectAtIndex:index];
}

#pragma  mark - delegate
- (void)itemDidGetCreated:(iTunesItem *)item {
    self.count = [self.results count];
}
@end
