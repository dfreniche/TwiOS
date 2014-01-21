//
//  DFTwitterHelper.m
//  TwiOS
//
//  Created by Diego Freniche Brito on 29/08/13.
//  Copyright (c) 2013 freniche. All rights reserved.
//

#import "DFTwitterHelper.h"
#import "DFTweet.h"
@implementation DFTwitterHelper

+ (void)twitterAccountInfoWithUser:(NSString *)twitterUser completion:(void(^)(DFTwitterAccountInfo *))completion  {
    
    __block DFTwitterAccountInfo *twAccountInfo;
    
    // Request access to the Twitter accounts
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (error) {
            NSLog(@"ERRORS: %@", [error description]);
            completion(nil);
            return;
        }
        
        if (!granted) {
            NSLog(@"No access granted");
            completion(nil);
            return;
        }
        
        NSArray *accounts = [accountStore accountsWithAccountType:accountType];
        // Check if the users has setup at least one Twitter account
        if (accounts.count == 0) {
            NSLog(@"** No accounts setup **");
            completion(nil);
            return;
        }
        ACAccount *twitterAccount = [accounts objectAtIndex:0];
        // Creating a request to get the info about a user on Twitter
        SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject:twitterUser forKey:@"screen_name"]];
        [twitterInfoRequest setAccount:twitterAccount];
        
        // Making the request
        [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // Check if we reached the reate limit
                if ([urlResponse statusCode] == 429) {
                    NSLog(@"Rate limit reached");
                    completion(nil);
                }
                // Check if there was an error
                if (error) {
                    NSLog(@"Error: %@", error.localizedDescription);
                    completion(nil);
                }
                // Check if there is some response data
                if (responseData) {
                    NSError *error = nil;
                    NSArray *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                    // Filter the preferred data
                    
                    twAccountInfo = [[DFTwitterAccountInfo alloc] init];
                    twAccountInfo.screenName  = [(NSDictionary *)TWData objectForKey:@"screen_name"];
                    twAccountInfo.name = [(NSDictionary *)TWData objectForKey:@"name"];
                    twAccountInfo.followersCount = [[(NSDictionary *)TWData objectForKey:@"followers_count"] integerValue];
                    twAccountInfo.followingCount = [[(NSDictionary *)TWData objectForKey:@"friends_count"] integerValue];
                    twAccountInfo.tweetsCount = [[(NSDictionary *)TWData objectForKey:@"statuses_count"] integerValue];
                    twAccountInfo.profileImageStringURL = [(NSDictionary *)TWData objectForKey:@"profile_image_url_https"];
                    twAccountInfo.bannerImageStringURL =[(NSDictionary *)TWData objectForKey:@"profile_banner_url"];
                    
                    twAccountInfo.lastTweet = [[(NSDictionary *)TWData objectForKey:@"status"] objectForKey:@"text"];
                    // Get the profile image in the original resolution
                    //profileImageStringURL = [profileImageStringURL stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
                    
                    completion(twAccountInfo);
                }
            });
        }];
    }];
    
}


// Method 4: Retrieving The User's Home Timeline. This uses v1.1 of the Twitter API. The v1.1 API link is included but commented out.
+ (void)readTweetsWithCompletion:(void(^)(NSArray *))completion {
    // Create an account store
    ACAccountStore *twitter = [[ACAccountStore alloc] init];
    
    // Create an account type
    ACAccountType *twAccountType = [twitter accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    // Request Access to the twitter account
    [twitter requestAccessToAccountsWithType:twAccountType options:nil completion:^(BOOL granted, NSError *error) {
        
        if (error) {
            NSLog(@"ERRORS: %@", [error description]);
            completion(nil);
            return;
        }
        
        if (!granted) {
            NSLog(@"No access granted");
            completion(nil);
            return;
        }

        // Create an Account
         ACAccount *twAccount = [[ACAccount alloc] initWithAccountType:twAccountType];
         NSArray *accounts = [twitter accountsWithAccountType:twAccountType];
         twAccount = [accounts lastObject];
         
         // Version 1.1 of the Twitter API only supports JSON responses.
         // Create an NSURL instance variable that points to the home_timeline end point.
         NSURL *twitterURL = [[NSURL alloc] initWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
         
         // Create a request
         SLRequest *requestUsersTweets = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:twitterURL parameters:nil];
             
         // Set the account to be used with the request
         [requestUsersTweets setAccount:twAccount];
         
         // Perform the request
         [requestUsersTweets performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error2) {
             
             if (error2) {
                 NSLog(@"ERROR getting tweets %@", error2.description);
                 completion(nil);
                 return;
             }
             
              // The output of the request is placed in the log.
             NSLog(@"HTTP Response: %i", [urlResponse statusCode]);
              // The output of the request is placed in the log.
             NSArray *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
             NSMutableArray *responseTweets = [[NSMutableArray alloc] init];
             
             for (NSDictionary *jsonTweet in jsonResponse) {
                 DFTweet *tweet = [[DFTweet alloc] initWithJSONObject:jsonTweet];
                 [responseTweets addObject:tweet];
             }
             completion(responseTweets);
          }];
         
         // Tidy Up
         twAccount = nil;
         accounts = nil;
         twitterURL = nil;
         requestUsersTweets = nil;
        
     }];
    
    // Tidy up
    twitter = nil;
    twAccountType = nil;
}



@end
