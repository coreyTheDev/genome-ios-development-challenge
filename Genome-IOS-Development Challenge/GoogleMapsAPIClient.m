//
//  GoogleMapsAPIClient.m
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/7/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import "GoogleMapsAPIClient.h"
#import "GoogleMapsConstants.h"
#import <AFNetworking.h>
#import "AppDelegate.h"

@interface GoogleMapsAPIClient ()

@end

@implementation GoogleMapsAPIClient

//Get First 20 Results API
+(void)getDataForGooglePlacesDisplay:(void (^)(NSDictionary *googleMapsLocationData))completionBlock
{
    NSString *baseURL = [NSString stringWithFormat:@"%@",GOOGLEMAPS_PLACES_API_URL];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *formattedString = [NSString stringWithFormat:@"%@,%@", delegate.latitude, delegate.longitude];
    
    NSDictionary *params = @{@"location": formattedString, @"radius": @"100", @"rankby": @"prominence", @"key": GOOGLEMAPS_CLIENT_SECRET};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:baseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *myString = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
        NSLog(@"Error: %@", myString);
    }];
}

//Get Next Page API
+(void)andNextPageToken:(NSString *)nextPageToken getDataForNextPageGooglePlacesDisplay:(void (^)(NSDictionary *googleMapsLocationDataNextPage))completionBlock {
    
    //Pass Latitude and Longitude from App Delegate
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *formattedString = [NSString stringWithFormat:@"%@,%@", delegate.latitude, delegate.longitude];
    
    NSString *baseURL = [NSString stringWithFormat:@"%@",GOOGLEMAPS_PLACES_API_URL];
    NSDictionary *params = @{@"location": formattedString, @"radius": @"100", @"rankby": @"prominence", @"key": GOOGLEMAPS_CLIENT_SECRET, @"pagetoken": nextPageToken};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:baseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *myString = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
        NSLog(@"Error: %@", myString);
    }];
}

//Get Details via Place ID API
+(void)andPlaceIDReference:(NSString *)placeID getDataForGooglePlacesDetailDisplay:(void (^)(NSDictionary *googleMapsDetailData))completionBlock
{
    NSString *baseURL = [NSString stringWithFormat:@"%@",GOOGLEMAPS_PLACES_DETAIL_API_URL];
    
    NSDictionary *params = @{@"placeid": placeID, @"key": GOOGLEMAPS_CLIENT_SECRET};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:baseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *myString = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
        NSLog(@"Error: %@", myString);
    }];
}

@end
