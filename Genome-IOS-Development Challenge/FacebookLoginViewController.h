//
//  FacebookLoginViewController.h
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/10/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FacebookLoginViewController : UIViewController <FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end
