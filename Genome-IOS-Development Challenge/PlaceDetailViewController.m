//
//  PlaceDetailViewController.m
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/8/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "GoogleMapsConstants.h"

@interface PlaceDetailViewController ()

@end

@implementation PlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initiateLabels];
    
    [self initiateWebView];
    
    [self dismissKeyboardGesture];
}

-(void)initiateLabels
{
    self.detailNameLabel.text = self.detailNameLabelText;
    self.detailNameLabel.font = [UIFont fontWithName:@"Arial" size:14];
    
    self.detailAddressLabel.text = self.detailAddressLabelText;
    self.detailAddressLabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    self.detailPhoneNumberLabel.text = self.detailPhoneNumberLabelText;
    self.detailPhoneNumberLabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    self.websiteTextView.text = self.detailWebsiteLabelText;
    self.websiteTextView.font = [UIFont fontWithName:@"Arial" size:12];
    self.websiteTextView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    NSString *revisedWebsiteString = [self.detailWebsiteLabelText stringByReplacingOccurrencesOfString:@"Website: " withString:@""];
    NSMutableAttributedString *websiteLinkString = [[NSMutableAttributedString alloc] initWithString:self.detailWebsiteLabelText];
    [websiteLinkString addAttribute: NSLinkAttributeName value:revisedWebsiteString range: NSMakeRange(9, websiteLinkString.length - 9)];
    self.websiteTextView.attributedText = websiteLinkString;
    
    self.googlePlaceLinkTextView.text = self.detailGoogleReviewLinkLabelText;
    self.googlePlaceLinkTextView.font = [UIFont fontWithName:@"Arial" size:12];
    self.googlePlaceLinkTextView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    NSString *revisedGooglePlacesLinkString = [self.detailGoogleReviewLinkLabelText stringByReplacingOccurrencesOfString:@"Google Places Link: " withString:@""];
    NSMutableAttributedString *googlePlaceLinkString = [[NSMutableAttributedString alloc] initWithString:self.detailGoogleReviewLinkLabelText];
    [googlePlaceLinkString addAttribute: NSLinkAttributeName value:revisedGooglePlacesLinkString range: NSMakeRange(20, googlePlaceLinkString.length - 20)];
    self.googlePlaceLinkTextView.attributedText = googlePlaceLinkString;
    
    self.detailTotalRatingsLabel.text = self.detailTotalRatingsLabelText;
    self.detailTotalRatingsLabel.font = [UIFont fontWithName:@"Arial" size:12];
}

-(void)initiateWebView
{
    [self.detailWebviewMap.scrollView setShowsHorizontalScrollIndicator:NO];
    self.detailWebviewMap.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    NSString *urlString = [[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=%@, %@&zoom=15&size=414x265&key=%@&format=png&markers=icon:http://tinyurl.com/2ftvtt6|%@,%@",self.placeLatitude, self.placeLongitude, GOOGLEMAPS_CLIENT_SECRET, self.placeLatitude, self.placeLongitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.detailWebviewMap loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboardGesture {
    
UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                               initWithTarget:self
                               action:@selector(dismissKeyboard)];

[self.view addGestureRecognizer:tap];

}

-(void)dismissKeyboard {
    [self.websiteTextView resignFirstResponder];
}

@end
