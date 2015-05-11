//
//  PlaceDetailViewController.h
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/8/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlaceDetailViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *detailWebviewMap;
@property (strong, nonatomic) IBOutlet UILabel *detailNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailPhoneNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailTotalRatingsLabel;
@property (weak, nonatomic) IBOutlet UITextView *websiteTextView;
@property (weak, nonatomic) IBOutlet UITextView *googlePlaceLinkTextView;


@property (strong, nonatomic) NSString *placeLatitude;
@property (strong, nonatomic) NSString *placeLongitude;
@property (strong, nonatomic) NSString *detailNameLabelText;
@property (strong, nonatomic) NSString *detailAddressLabelText;
@property (strong, nonatomic) NSString *detailPhoneNumberLabelText;
@property (strong, nonatomic) NSString *detailWebsiteLabelText;
@property (strong, nonatomic) NSString *detailGoogleReviewLinkLabelText;
@property (strong, nonatomic) NSString *detailTotalRatingsLabelText;

@end
