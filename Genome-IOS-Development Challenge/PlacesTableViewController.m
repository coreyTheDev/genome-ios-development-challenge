//
//  PlacesTableViewController.m
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/7/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "GoogleMapsAPIClient.h"
#import "GooglePlace.h"
#import "CustomTableViewCell.h"
#import "PlaceDetailViewController.h"

@import CoreLocation;

@interface PlacesTableViewController () <CLLocationManagerDelegate>

@end

@implementation PlacesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSelectedIndex];
    
    [self callDataStore];

    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.dataStore.googlePlacesNames count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"expandingCell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        [cell.showImageTapped addTarget:self action:@selector(showMoreTapped :) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.selectedIndex == indexPath.row)
    {
        cell.contentView.superview.backgroundColor = [UIColor colorWithRed:242/255.0f green:250/255.0f blue:255/255.0f alpha:1.0f];
        cell.nameLabel.font = [UIFont fontWithName:@"Arial" size:12];
        cell.locationLabal.font = [UIFont fontWithName:@"Arial" size:10];
        [cell.showImageTapped setTitle:@"Close Image" forState:UIControlStateNormal];
    }
    else
    {
        cell.contentView.superview.backgroundColor = [UIColor whiteColor];
        cell.nameLabel.font = [UIFont fontWithName:@"Arial" size:12];
        cell.locationLabal.font = [UIFont fontWithName:@"Arial" size:10];
        [cell.showImageTapped setTitle:@"Show Image" forState:UIControlStateNormal];
    }
    
    NSString *googlePlaceName = self.dataStore.googlePlacesNames[indexPath.row];
    NSString *placeID = self.dataStore.googlePlacesPlaceID[indexPath.row];
    NSString *googlePlaceLocation = [self.dataStore.googlePlacesFormattedAddress objectForKey:placeID];
    NSString *googlePhotoReference = self.dataStore.googlePhotoURLs[indexPath.row];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"Place: %@", googlePlaceName];
    cell.locationLabal.text = [NSString stringWithFormat:@"Address: %@", googlePlaceLocation];
    cell.photoReferenceLabel.text = [NSString stringWithFormat:@"%@", googlePhotoReference];
    cell.photoReferenceLabel.hidden = YES;
    
    cell.showImageTapped.tag = indexPath.row;
    
    cell.clipsToBounds = YES;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex ==indexPath.row)
    {
        return 325;
    }
    else
    {
        return 80;
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)showMoreTapped:(id)sender
{
    UIButton *senderButton = (UIButton *)sender;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:senderButton.tag inSection:0];
    if (self.selectedIndex == indexPath.row)
    {
        self.selectedIndex = -1;
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    
    if (self.selectedIndex != -1)
    {
        NSIndexPath *previousPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
        self.selectedIndex = indexPath.row;
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:previousPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    //User taps new row with none expanded
    self.selectedIndex = indexPath.row;
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetails" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetails"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString *placeName = self.dataStore.googlePlacesNames[indexPath.row];
        NSString *placeID = self.dataStore.googlePlacesPlaceID[indexPath.row];
        NSString *placeLatitude = self.dataStore.googlePlacesPlaceLatitude[indexPath.row];
        NSString *placeLongitude = self.dataStore.googlePlacesPlaceLongitude[indexPath.row];
        NSString *placeReference = self.dataStore.googlePlacesPlaceReference[indexPath.row];
        
        NSString *placeFormattedAddress = [self.dataStore.googlePlacesFormattedAddress objectForKey:placeID];
        NSString *placeFormattedNumber = [self.dataStore.googlePlacesFormattedNumber objectForKey:placeID];
        NSString *placeReviewLink = [self.dataStore.googlePlacesReviewLink objectForKey:placeID];
        NSString *placeTotalRatings = [self.dataStore.googlePlacesTotalRatings objectForKey:placeID];
        NSString *placeWebsite = [self.dataStore.googlePlacesWebsite objectForKey:placeID];
        
        PlaceDetailViewController *destViewController = segue.destinationViewController;
        destViewController.detailNameLabelText = [NSString stringWithFormat:@"%@", placeName];
        destViewController.detailAddressLabelText = [NSString stringWithFormat:@"Address: %@", placeFormattedAddress];
        destViewController.detailPhoneNumberLabelText = [NSString stringWithFormat:@"Phone Number: %@", placeFormattedNumber];
        destViewController.detailWebsiteLabelText = [NSString stringWithFormat:@"Website: %@", placeWebsite];
        destViewController.detailGoogleReviewLinkLabelText = [NSString stringWithFormat:@"Google Places Link: %@", placeReviewLink];
        destViewController.detailTotalRatingsLabelText = [NSString stringWithFormat:@"Total Ratings: %@", placeTotalRatings];
        destViewController.placeLatitude = [NSString stringWithFormat:@"%@", placeLatitude];
        destViewController.placeLongitude = [NSString stringWithFormat:@"%@", placeLongitude];
        
    }
}

-(void)setSelectedIndex {
    
    self.selectedIndex = -1;
}

-(void)callDataStore {
    
    self.dataStore = [GoogleMapsDataStore sharedGooglePlacesDataStore];
    
    [self.dataStore getDataForGooglePlacesDisplay:^(BOOL success) {
        
        [self.tableView reloadData];
    }];
}

@end
