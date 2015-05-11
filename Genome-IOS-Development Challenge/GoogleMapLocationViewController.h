//
//  GoogleMapLocationViewController.h
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/8/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GoogleMapLocationViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *locationWebView;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UIBarButtonItem *locationIcon;

@property (strong, nonatomic) NSString *locationLatitude;
@property (strong, nonatomic) NSString *locationLongitude;

@end
