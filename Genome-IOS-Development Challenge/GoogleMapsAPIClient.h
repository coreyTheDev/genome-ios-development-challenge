//
//  GoogleMapsAPIClient.h
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/7/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleMapsDataStore.h"

@interface GoogleMapsAPIClient : NSObject

@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *latitude;

+(void)getDataForGooglePlacesDisplay:(void (^)(NSDictionary *googleMapsLocationData))completionBlock;

+(void)andNextPageToken:(NSString *)nextPageToken getDataForNextPageGooglePlacesDisplay:(void (^)(NSDictionary *googleMapsLocationDataNextPage))completionBlock;

+(void)andPlaceIDReference:(NSString *)placeID getDataForGooglePlacesDetailDisplay:(void (^)(NSDictionary *googleMapsDetailData))completionBlock;

@end
