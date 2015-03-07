//
//  iTunesItemCellTableViewCell.m
//  iTunesSearch
//
//  Created by Daniel Steinberg on 10/1/14.
//  Copyright (c) 2014 Dim Sum Thinking. All rights reserved.
//

#import "iTunesItemCell.h"
#import "iTunesItem.h"

@interface iTunesItemCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *artworkView;

@end

@implementation iTunesItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Override the default black background color
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel = nameLabel;
        nameLabel.font = [UIFont fontWithDescriptor: [UIFontDescriptor   preferredFontDescriptorWithTextStyle:UIFontTextStyleHeadline]                                                 size:16.f];
        [self.contentView addSubview:_nameLabel];
     
        UILabel *ratingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        ratingLabel.font = [UIFont fontWithDescriptor: [UIFontDescriptor   preferredFontDescriptorWithTextStyle:UIFontTextStyleSubheadline]                                                 size:13.f];
        _ratingLabel = ratingLabel;
        [self.contentView addSubview:_ratingLabel];
        
        UIImageView *artworkView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _artworkView = artworkView;
        [self.contentView addSubview:_artworkView];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self applyConstraints];
    }
    return self;
}

- (void)applyConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel, _ratingLabel, _artworkView);
    // views = @{@"_ratingLabel": _ratinglabel, ...}
    
    // Boilderplate necessary for backwards compatibility with autoresizing masks
    for (UIView *view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }

    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"|-margin-[_artworkView(100)]-spacer-[_ratingLabel]-20-|"
                                             options:0
                                             metrics:@{@"margin": @8, @"spacer":@3}
                                               views:views]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"|-margin-[_artworkView(100)]-spacer-[_nameLabel]-20-|"
                                             options:0
                                             metrics:@{@"margin": @8, @"spacer":@3}
                                               views:views]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_nameLabel]-spacer-[_ratingLabel(==_nameLabel)]-margin-|"
                                             options:0
                                             metrics:@{@"margin": @3, @"spacer":@3}
                                               views:views]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_artworkView(100)]-margin-|"
                                             options:0
                                             metrics:@{@"margin": @3}
                                               views:views]];
}

- (void)displayContentForItem:(iTunesItem *)item {
    self.nameLabel.text = item.name;
    self.ratingLabel.text = item.rating;
    self.artworkView.image = item.artwork;
}

@end
