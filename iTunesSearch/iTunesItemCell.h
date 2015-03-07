//
//  iTunesItemCellTableViewCell.h
//  iTunesSearch
//
//  Created by Daniel Steinberg on 10/1/14.
//  Copyright (c) 2014 Dim Sum Thinking. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iTunesItem;

@interface iTunesItemCell : UITableViewCell
- (void)displayContentForItem:(iTunesItem *)item;
@end
