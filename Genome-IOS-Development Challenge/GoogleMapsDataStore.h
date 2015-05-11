//
//  GoogleMapsDataStore.h
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/7/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoogleMapsDataStore : NSObject

//first api
@property (strong, nonatomic) NSMutableArray *googlePlacesNames;
@property (strong, nonatomic) NSMutableArray *googlePlacesPhotoReference;
@property (strong, nonatomic) NSMutableArray *googlePlacesPlaceID;
@property (strong, nonatomic) NSMutableArray *googlePlacesPlaceReference;
@property (strong, nonatomic) NSMutableArray *googlePlacesPlaceLatitude;
@property (strong, nonatomic) NSMutableArray *googlePlacesPlaceLongitude;
@property (strong, nonatomic) NSString *nextPageToken;

//second api
@property (strong, nonatomic) NSMutableDictionary *googlePlacesFormattedAddress;
@property (strong, nonatomic) NSMutableDictionary *googlePlacesFormattedNumber;
@property (strong, nonatomic) NSMutableDictionary *googlePlacesWebsite;
@property (strong, nonatomic) NSMutableDictionary *googlePlacesReviewLink;
@property (strong, nonatomic) NSMutableDictionary *googlePlacesTotalRatings;

@property (strong, nonatomic) NSMutableArray *googlePhotoURLs;

+ (instancetype)sharedGooglePlacesDataStore;
-(instancetype)init;

-(void)getDataForGooglePlacesDisplay:(void (^)(BOOL success))completionBlock;
-(void)getDataForGooglePlacesNextPageDisplay:(void (^)(BOOL success))completionBlock;
-(void)getPlacesDetailInformation:(void (^)(BOOL success))completionBlock;

@end
