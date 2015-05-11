//
//  PlacesTableViewController.h
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/7/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleMapsDataStore.h"
#import <CoreLocation/CoreLocation.h>

@interface PlacesTableViewController : UITableViewController <CLLocationManagerDelegate>

@property (nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) GoogleMapsDataStore *dataStore;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UIBarButtonItem *locationIcon;

@end
