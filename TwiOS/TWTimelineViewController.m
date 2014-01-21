//
//  TWFirstViewController.m
//  TwiOS
//
//  Created by Diego Freniche Brito on 27/08/13.
//  Copyright (c) 2013 freniche. All rights reserved.
//

#import "TWTimelineViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface TWTimelineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TWTimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self retrieveTweets:nil];
    
#pragma mark fixme
    
    // [self getInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendTweet:(id)sender {
    // if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetScreen = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetScreen setInitialText:@"Testing"];
        
        [self presentViewController:tweetScreen animated:YES completion:nil];

    //}
    
}

// Method 4: Retrieving The User's Home Timeline. This uses v1.1 of the Twitter API. The v1.1 API link is included but commented out.
- (IBAction)retrieveTweets:(id)sender
{
    // Create an account store
    ACAccountStore *twitter = [[ACAccountStore alloc] init];
    
    // Create an account type
    ACAccountType *twAccountType = [twitter accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    // Request Access to the twitter account
    [twitter requestAccessToAccountsWithType:twAccountType options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             // Create an Account
             ACAccount *twAccount = [[ACAccount alloc] initWithAccountType:twAccountType];
             NSArray *accounts = [twitter accountsWithAccountType:twAccountType];
             twAccount = [accounts lastObject];
             
             // Version 1.1 of the Twitter API only supports JSON responses.
             // Create an NSURL instance variable that points to the home_timeline end point.
             NSURL *twitterURL = [[NSURL alloc] initWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
             
             // Version 1.0 of the Twiter API supports XML responses.
             // Use this URL if you want to see an XML response.
             //NSURL *twitterURL2 = [[NSURL alloc] initWithString:@"http://api.twitter.com/1/statuses/home_timeline.xml"];
             
             // Create a request
             SLRequest *requestUsersTweets = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                requestMethod:SLRequestMethodGET
                                                                          URL:twitterURL
                                                                   parameters:nil];
             
             // Set the account to be used with the request
             [requestUsersTweets setAccount:twAccount];
             
             // Perform the request
             [requestUsersTweets performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error2)
              {
                  // The output of the request is placed in the log.
                  NSLog(@"HTTP Response: %i", [urlResponse statusCode]);
                  // The output of the request is placed in the log.
                  NSArray *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                  
                  NSLog(@"%@", jsonResponse);
                  
              }];
             
             // Tidy Up
             twAccount = nil;
             accounts = nil;
             twitterURL = nil;
             requestUsersTweets = nil;
         }
         
         // If permission is not granted to use the Twitter account...
         
         else
             
         {
             NSLog(@"Permission Not Granted");
             NSLog(@"Error: %@", error);
         }
     }];
    
    // Tidy up
    twitter = nil;
    twAccountType = nil;
}


@end
