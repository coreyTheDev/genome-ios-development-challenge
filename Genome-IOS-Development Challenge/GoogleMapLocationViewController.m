//
//  GoogleMapLocationViewController.m
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/8/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import "GoogleMapLocationViewController.h"
#import "GoogleMapsConstants.h"
#import "AppDelegate.h"

@import CoreLocation;

@interface GoogleMapLocationViewController () <CLLocationManagerDelegate>

@end

@implementation GoogleMapLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupLocationManager];
    [self locationIconTapped];
}

-(void)locationIconTapped
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateLocationLatLong)];
    
    [self initiateWebView];
}

-(void)updateLocationLatLong
{
    [self setupLocationManager];
    [self.locationWebView reload];
}

-(void)setupLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%g", newLocation.coordinate.latitude);
    NSLog(@"%g", newLocation.coordinate.longitude);
    
    self.locationLatitude = [[NSString alloc] initWithFormat:@"%g", newLocation.coordinate.latitude];
    self.locationLongitude = [[NSString alloc] initWithFormat:@"%g", newLocation.coordinate.longitude];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Add latitude and longitude to App Delegate in order to access in API Client
    delegate.latitude = self.locationLatitude;
    delegate.longitude = self.locationLongitude;
    
    [self.locationManager stopUpdatingLocation];
    
    [self initiateWebView];
}

-(void)initiateWebView
{
    [self.locationWebView.scrollView setShowsHorizontalScrollIndicator:NO];
    self.locationWebView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    NSString *urlString = [[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=%@, %@&zoom=15&size=414x265&key=%@&format=png&markers=icon:http://tinyurl.com/2ftvtt6|%@,%@",self.locationLatitude, self.locationLongitude,GOOGLEMAPS_CLIENT_SECRET, self.locationLatitude, self.locationLongitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.locationWebView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
