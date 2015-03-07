//
//  iTunesDetailViewController.h
//  iTunesSearch
//
//  Created by Daniel Steinberg on 10/2/14.
//  Copyright (c) 2014 Dim Sum Thinking. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iTunesItem;

@interface iTunesDetailViewController : UIViewController
@property (strong, nonatomic) iTunesItem *item;
@end
