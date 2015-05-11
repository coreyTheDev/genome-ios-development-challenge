//
//  FacebookLoginViewController.m
//  Genome-IOS-Development Challenge
//
//  Created by Kavan Brandon on 5/10/15.
//  Copyright (c) 2015 Kavan Brandon. All rights reserved.
//

#import "FacebookLoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FacebookLoginViewController ()

@end

@implementation FacebookLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.loginButton.delegate = self;
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    // Do any additional setup after loading the view.
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    NSLog(@"You are logged out.");

}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    NSLog(@"You are logged in.");
    [self performSegueWithIdentifier:@"tabBarSegue" sender:self];
}

-(void)loginView:(FBSDKLoginButton *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
