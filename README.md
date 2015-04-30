# iOS Development Challenge

##Instructions

Create an application compatible with iOS 7.1 and above.

The requirements for the App are the following:

1. After launching the App for the first time, a LoginViewController with a button to login with Facebook must be presented. If the user is already logged in, the App should not present the LoginViewController.

2. After the user has successfully logged in with Facebook or if the user is already logged in, a HomeViewController will be presented. The HomeViewController must be a TabBarController with 2 tabs.

3. The first tab must present a Google Map showing the user's current location with a functional My Location button.

4. The second tab must present an UITableViewController with a list of the top 25 places that are located in a 100 meter radius around the user's current location. Use AFNetworking to make a request to the Google Places API Web Service (https://maps.googleapis.com/maps/api/place/search/json?location=40.7431735,-73.9799391&radius=100&key=YOUR_API_KEY_HERE
) and process the JSON response to populate your list. The UITableViewCells must show an image, the place's name and a disclosure indicator.

5. When a place in the list is tapped, a UIViewController must be presented to the user with more information about the place that was tapped. Again, use AFNetworking to get the details about a place from Google Places API Web Service (https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJpRvbqglZwokRSKzPisbuDcU&key=YOUR_API_KEY_HERE).


Extra points will be awarded if:
* You lazy load the images on the list.
* You implement "pull to refresh" in the UITableViewController.
* You come up with a nice and modern UI/UX.
* You use Test Driven Development and implement test cases.
* You document your classes and methods using HeaderDoc.

##Deadline

You'll have 3-5 days to complete this challenge. The clock starts ticking from the moment you receive access to this repository. If you finish it sooner... hey, extra points!


##Additional Information

Please add any additional information on how to run the project or any additional comments to the file called README_CANDIDATE.md.


##Third Party APIs Documentation

* Facebook SDK for iOS: https://developers.facebook.com/docs/ios

* Google Maps API for iOS: https://developers.google.com/maps/documentation/ios/

* Google Places API Web Service:
  * Place Search: https://developers.google.com/places/webservice/search
  * Place Details: https://developers.google.com/places/webservice/details


* AFNetworking: https://github.com/AFNetworking/AFNetworking



##Tools

* Xcode: https://developer.apple.com/xcode/downloads/
