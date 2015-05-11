//
//  GoogleMapsDataStore.m
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/7/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import "GoogleMapsDataStore.h"
#import "GoogleMapsAPIClient.h"
#import "GoogleMapsConstants.h"

@implementation GoogleMapsDataStore

+(instancetype)sharedGooglePlacesDataStore
{
    static GoogleMapsDataStore *_sharedGooglePlacesDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedGooglePlacesDataStore = [[GoogleMapsDataStore alloc] init];
    });
    return _sharedGooglePlacesDataStore;
}

-(instancetype)init {
    self = [super init];
    if (self)
    {
        //First API
        self.googlePlacesNames = [NSMutableArray new];
        self.googlePlacesPhotoReference = [NSMutableArray new];
        self.googlePlacesPlaceID = [NSMutableArray new];
        self.googlePlacesPlaceLatitude = [NSMutableArray new];
        self.googlePlacesPlaceLongitude = [NSMutableArray new];
        self.googlePlacesPlaceReference = [NSMutableArray new];
        
        //Detail API
        self.googlePlacesFormattedAddress = [NSMutableDictionary new];
        self.googlePlacesFormattedNumber = [NSMutableDictionary new];
        self.googlePlacesReviewLink = [NSMutableDictionary new];
        self.googlePlacesTotalRatings = [NSMutableDictionary new];
        self.googlePlacesWebsite = [NSMutableDictionary new];
        
        self.googlePhotoURLs = [NSMutableArray new];
    }
    return self;
}

-(void)getDataForGooglePlacesDisplay:(void (^)(BOOL success))completionBlock {
    
    [GoogleMapsAPIClient getDataForGooglePlacesDisplay:^(NSDictionary *googleMapsLocationData) {
        for (NSDictionary *placesDictionary in googleMapsLocationData[@"results"]) {
            {
                
                if (googleMapsLocationData[@"next_page_token"] != nil) {
                    
                self.nextPageToken = [NSString stringWithString: googleMapsLocationData[@"next_page_token"]];
                    
                }
                
                if (placesDictionary[@"name"] == nil) {
                    [self.googlePlacesNames addObject:@"N/A"];
                }
                else {
                    [self.googlePlacesNames addObject:placesDictionary[@"name"]];
                }
                
                if (placesDictionary[@"photos"][0][@"photo_reference"] == nil) {
                    [self.googlePlacesPhotoReference addObject:@"N/A"];
                }
                else {
                    [self.googlePlacesPhotoReference addObject:placesDictionary[@"photos"][0][@"photo_reference"]];
                }
                
                if (placesDictionary[@"place_id"] == nil) {
                    [self.googlePlacesPlaceID addObject:@"N/A"];
                }
                else {
                    [self.googlePlacesPlaceID addObject:placesDictionary[@"place_id"]];
                }
                
                if (placesDictionary[@"reference"] == nil) {
                    [self.googlePlacesPlaceReference addObject:@"N/A"];
                }
                else {
                    [self.googlePlacesPlaceReference addObject:placesDictionary[@"reference"]];
                }
                
                if (placesDictionary[@"geometry"][@"location"][@"lat"] == nil) {
                    [self.googlePlacesPlaceLatitude addObject:@"N/A"];
                }
                else {
                    [self.googlePlacesPlaceLatitude addObject:placesDictionary[@"geometry"][@"location"][@"lat"]];
                }
                
                if (placesDictionary[@"geometry"][@"location"][@"lng"] == nil) {
                    [self.googlePlacesPlaceLongitude addObject:@"N/A"];
                }
                else {
                    [self.googlePlacesPlaceLongitude addObject:placesDictionary[@"geometry"][@"location"][@"lng"]];
                }
            }
        }
        //Get Next Page Data if it exists
        if (self.nextPageToken != nil){
            [self getDataForGooglePlacesNextPageDisplay:^(BOOL success) {
                
                [self getPhotoURLs];
                completionBlock(YES);
                
            }];
        }
        else{
            
            [self getPhotoURLs];
            completionBlock(YES);
        }
        //Get Detail Data
        [self getPlacesDetailInformation:^(BOOL success) {
            //Get Photos from GoogleMaps Photos API
            if ([self.googlePlacesPhotoReference count] == [self.googlePlacesPlaceID count]) {
            }
        }];
    }];
}

-(void)getDataForGooglePlacesNextPageDisplay:(void (^)(BOOL success))completionBlock {
    
    [GoogleMapsAPIClient andNextPageToken:self.nextPageToken getDataForNextPageGooglePlacesDisplay:^(NSDictionary *googleMapsLocationDataNextPage) {
        for (NSDictionary *placesDictionary in googleMapsLocationDataNextPage[@"results"]) {
            
            if ([self.googlePlacesNames count] < 25){
                
                if (placesDictionary[@"name"] == nil) {
                    [self.googlePlacesNames addObject:@"N/A"];
                }
                else {
                    [self.googlePlacesNames addObject:placesDictionary[@"name"]];
                    
                    
                }
                
                if (placesDictionary[@"photos"][0][@"photo_reference"] == nil) {
                    [self.googlePlacesPhotoReference addObject:@"N/A"];
                }
                else {
                    [self.googlePlacesPhotoReference addObject:placesDictionary[@"photos"][0][@"photo_reference"]];
                }
                
                if (placesDictionary[@"place_id"] == nil) {
                    [self.googlePlacesPlaceID addObject:@"N/A"];
                }
                else {
                    [self.googlePlacesPlaceID addObject:placesDictionary[@"place_id"]];
                }
                
                if (placesDictionary[@"reference"] == nil) {
                    [self.googlePlacesPlaceReference addObject:@"N/A"];
                }
                else {
                    [self.googlePlacesPlaceReference addObject:placesDictionary[@"reference"]];
                }
                
                if (placesDictionary[@"geometry"][@"location"][@"lat"] == nil) {
                    [self.googlePlacesPlaceLatitude addObject:@"N/A"];
                }
                else {
                    [self.googlePlacesPlaceLatitude addObject:placesDictionary[@"geometry"][@"location"][@"lat"]];
                }
                
                if (placesDictionary[@"geometry"][@"location"][@"lng"] == nil) {
                    [self.googlePlacesPlaceLongitude addObject:@"N/A"];
                }
                else {
                    [self.googlePlacesPlaceLongitude addObject:placesDictionary[@"geometry"][@"location"][@"lng"]];
                    
                    if ([self.googlePlacesPlaceLongitude count] <25) {
                        
                    }
                }
            }
        }
        completionBlock(YES);
    }];
}

-(void)getPlacesDetailInformation:(void (^)(BOOL success))completionBlock {

    for (NSString *placeID in self.googlePlacesPlaceID) {
        
        [GoogleMapsAPIClient andPlaceIDReference:placeID getDataForGooglePlacesDetailDisplay:^(NSDictionary *googleMapsDetailData) {
            
            if (googleMapsDetailData[@"result"][@"formatted_address"] == nil) {
                [self.googlePlacesFormattedAddress setValue:@"N/A" forKey:placeID];
            }
            else {
                [self.googlePlacesFormattedAddress setValue:googleMapsDetailData[@"result"][@"formatted_address"] forKey:placeID];
            }
            
            if (googleMapsDetailData[@"result"][@"formatted_phone_number"] == nil) {
                [self.googlePlacesFormattedNumber setValue:@"N/A" forKey:placeID];
            }
            else {
                [self.googlePlacesFormattedNumber setValue:googleMapsDetailData[@"result"][@"formatted_phone_number"] forKey:placeID];
            }
            
            if (googleMapsDetailData[@"result"][@"website"] == nil) {
                [self.googlePlacesWebsite setValue:@"N/A" forKey:placeID];
            }
            else {
                [self.googlePlacesWebsite setValue:googleMapsDetailData[@"result"][@"website"] forKey:placeID];
            }
            
            if (googleMapsDetailData[@"result"][@"url"] == nil) {
                [self.googlePlacesReviewLink setValue:@"N/A" forKey:placeID];
            }
            else {
                [self.googlePlacesReviewLink setValue:googleMapsDetailData[@"result"][@"url"] forKey:placeID];
            }
            
            if (googleMapsDetailData[@"result"][@"user_ratings_total"] == nil) {
                [self.googlePlacesTotalRatings setValue:@"N/A" forKey:placeID];
            }
            else {
                [self.googlePlacesTotalRatings setValue:googleMapsDetailData[@"result"][@"user_ratings_total"] forKey:placeID];
                
            }
            if ([self.googlePlacesTotalRatings count] == [self.googlePlacesPlaceID count]) {
            completionBlock(YES);
            }
        }];
    }
}

-(void)getPhotoURLs {
    
    for (NSString *photoReference in self.googlePlacesPhotoReference){
        if ([photoReference isEqualToString:@"N/A"]) {
            [self.googlePhotoURLs addObject:@"http://www.wa.lk/best-of-sri-lanka/best-of-lanka-places-image/icon_no-image.gif"];
        }
        else {
            NSString *urlString = [NSString stringWithFormat:@"%@maxwidth=400&photoreference=%@&key=%@",GOOGLEMAPS_PLACES_PHOTOS_API_URL,photoReference,GOOGLEMAPS_CLIENT_SECRET];
            NSURL *url = [NSURL URLWithString:urlString];
            [self.googlePhotoURLs addObject:url];
        }
    }
}

@end
