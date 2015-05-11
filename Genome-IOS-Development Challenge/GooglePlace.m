//
//  GooglePlace.m
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/8/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import "GooglePlace.h"

@implementation GooglePlace

-(id) initWithName:(NSString *)name andLocation:(NSString *)location
         andNumber:(NSString *)number andPhotoReference:(NSString *)photoReference
        andPlaceID:(NSString *)placeID andPlaceReference:(NSString *)placeReference
  andPlaceLatitude:(NSString *)placeLatitude andPlaceLongitude:(NSString *)placeLongitude
andFormattedAddress:(NSString *)formattedAddress andFormattedNumber:(NSString *)formattedNumber
        andWebsite:(NSString *)website andReviewLink:(NSString *)reviewLink
   andTotalRatings:(NSString *)totalRatings
{
    self = [super init];
    if (self)
    {
        _name = name;
        _location = location;
        _number = number;
        _photoReference = photoReference;
        _placeID = placeID;
        _placeReference = placeReference;
        _placeLatitude = placeLatitude;
        _placeLongitude = placeLongitude;
        _formattedAddress = formattedAddress;
        _formattedNumber = formattedNumber;
        _website = website;
        _reviewLink = reviewLink;
        _totalRatings = totalRatings;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithName:@"" andLocation:@"" andNumber:@"" andPhotoReference:@"" andPlaceID:@"" andPlaceReference:@"" andPlaceLatitude:@"" andPlaceLongitude:@"" andFormattedAddress:@"" andFormattedNumber:@"" andWebsite:@"" andReviewLink:@"" andTotalRatings:@""];
}

@end
