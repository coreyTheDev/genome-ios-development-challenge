//
//  CustomTableViewCell.m
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/8/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "GoogleMapsConstants.h"
#import "PlacesTableViewController.h"
#import "GoogleMapsDataStore.h"

@implementation CustomTableViewCell

@synthesize nameLabel, locationLabal, photoReferenceLabel;

- (void)awakeFromNib {

    [self.imageWebView.scrollView setShowsHorizontalScrollIndicator:NO];
    self.imageWebView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *urlString = [NSString stringWithFormat:@"%@",self.photoReferenceLabel.text];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.imageWebView loadRequest:urlRequest];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
