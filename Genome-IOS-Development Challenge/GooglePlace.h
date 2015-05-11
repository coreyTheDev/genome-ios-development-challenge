//
//  GooglePlace.h
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/8/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GooglePlace : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *photoReference;
@property (strong, nonatomic) NSString *placeID;
@property (strong, nonatomic) NSString *placeReference;
@property (strong, nonatomic) NSString *placeLatitude;
@property (strong, nonatomic) NSString *placeLongitude;
@property (strong, nonatomic) NSString *formattedAddress;
@property (strong, nonatomic) NSString *formattedNumber;
@property (strong, nonatomic) NSString *website;
@property (strong, nonatomic) NSString *reviewLink;
@property (strong, nonatomic) NSString *totalRatings;


@end
