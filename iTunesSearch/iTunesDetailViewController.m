//
//  iTunesDetailViewController.m
//  iTunesSearch
//
//  Created by Daniel Steinberg on 10/2/14.
//  Copyright (c) 2014 Dim Sum Thinking. All rights reserved.
//

#import "iTunesDetailViewController.h"
#import "iTunesItem.h"

@interface iTunesDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *artworkView;
@property (weak, nonatomic) IBOutlet UITextView *detailDescriptionView;
@end

@implementation iTunesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.item.name;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithWhite:0.85f alpha:.75f];
    
    UITextView *detailDescriptionView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.detailDescriptionView = detailDescriptionView;
    self.detailDescriptionView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:.75f];
    [self.view addSubview:self.detailDescriptionView];
    
    UIImageView *artworkView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.artworkView = artworkView;
    [self.view addSubview:self.artworkView];
    
    
    [self applyConstraints];
    
    self.artworkView.image = self.item.artwork;
    self.detailDescriptionView.text = self.item.descriptionDetail;
}

- (void)applyConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_artworkView, _detailDescriptionView);
    // views = @{@"_artworkView": _artworkView, ...}
    
    // Boilderplate necessary for backwards compatibility with autoresizing masks
    for (UIView *view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:_artworkView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.f
                                   constant:0.f] ];
    
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:_artworkView
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:0.f
                                   constant:150.f] ];
    
    
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"|-margin-[_detailDescriptionView]-margin-|"
                                             options:0
                                             metrics:@{@"margin": @8}
                                               views:views]];
    
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_artworkView(150)]-spacer-[_detailDescriptionView]-margin-|"
                                             options:0
                                             metrics:@{@"margin": @15, @"spacer":@10}
                                               views:views]];
}

@end
