//
//  iTunesItem.m
//  iTunesSearch
//
//  Created by Daniel Steinberg on 10/1/14.
//  Copyright (c) 2014 Dim Sum Thinking. All rights reserved.
//

#import "iTunesItem.h"

@interface iTunesItem ()
@property (strong, nonatomic, readwrite) NSString *name;
@property (strong, nonatomic, readwrite) UIImage *artwork;
@end


@implementation iTunesItem

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _name = [self trackNameFromDictionary:dictionary];
        _rating = [self ratingFromDictionary:dictionary];
        _descriptionDetail = [self descriptionFromDictionary:dictionary];
        [self fetchArtworkFromDictionary:dictionary];
    }
    return self;
}

- (id)init
{
    return [self initWithDictionary:nil];
}

- (NSString *)trackNameFromDictionary:(NSDictionary *)dictionary
{
    NSString *appName = [dictionary valueForKey:@"trackName"];
    if (!appName) {
        appName = @"Unknown Track";
    }
    return appName;
}

- (NSString *)ratingFromDictionary:(NSDictionary *)dictionary
{
    NSString *rating = [[dictionary valueForKey:@"averageUserRating"] description];
    if (!rating) {
        rating = @"----";
    }
    return rating;
}

- (NSString *)descriptionFromDictionary:(NSDictionary *)dictionary
{
    NSString *appDescription = [dictionary valueForKey:@"description"];
    if (!appDescription) {
        appDescription = @"Description not available.";
    }
    return appDescription;
}

- (void)fetchArtworkFromDictionary:(NSDictionary *)dictionary
{
    NSString *artworkURL = [dictionary valueForKey:@"artworkUrl512"];
    if (!artworkURL) {
        self.artwork = [UIImage imageNamed:@"icon.png"];
        [self.delegate itemDidGetCreated:self];
    } else {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:artworkURL]];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
                                   if (response == nil) {
                                       self.artwork = [UIImage imageNamed:@"Icon.png"];
                                   } else {
                                       self.artwork = [UIImage imageWithData:responseData];
                                   }
                                   [self.delegate itemDidGetCreated:self];
                               }];
    }
}
@end