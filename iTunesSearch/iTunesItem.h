//
//  iTunesItem.h
//  iTunesSearch
//
//  Created by Daniel Steinberg on 10/1/14.
//  Copyright (c) 2014 Dim Sum Thinking. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol iTunesItemDelegate;

@interface iTunesItem : NSObject

@property (weak, nonatomic) id <iTunesItemDelegate> delegate;
@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *rating;
@property (strong, nonatomic, readonly) NSString *descriptionDetail;
@property (strong, nonatomic, readonly) UIImage *artwork;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end

@protocol iTunesItemDelegate <NSObject>
- (void)itemDidGetCreated:(iTunesItem *)item;
@end
