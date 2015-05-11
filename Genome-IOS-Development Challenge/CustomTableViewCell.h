//
//  CustomTableViewCell.h
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/8/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleMapsDataStore.h"

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabal;
@property (strong, nonatomic) IBOutlet UILabel *photoReferenceLabel;

@property (strong, nonatomic) IBOutlet UIButton *showImageTapped;
@property (strong, nonatomic) IBOutlet UIWebView *imageWebView;

@property (strong, nonatomic) GoogleMapsDataStore *dataStore;

@property (strong, nonatomic) NSString *photoReference;

@end
