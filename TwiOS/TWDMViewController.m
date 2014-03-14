//
//  TWDMViewController.m
//  TwiOS
//
//  Created by Diego Freniche Brito on 14/03/14.
//  Copyright (c) 2014 freniche. All rights reserved.
//

#import "TWDMViewController.h"
#import <STTwitter.h>
#import "TwitterPrivateKeys.h"
#import "TWDMCell.h"

@interface TWDMViewController ()
@property (nonatomic, strong) NSArray *dms;
@end

@implementation TWDMViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    STTwitterAPI *twitter = [STTwitterAPI twitterAPIWithOAuthConsumerName:nil
                                                              consumerKey:CONSUMER_KEY
                                                           consumerSecret:CONSUMER_SECRET];
    
    [twitter postReverseOAuthTokenRequest:^(NSString *authenticationHeader) {
        
        STTwitterAPI *twitterAPIOS = [STTwitterAPI twitterAPIOSWithFirstAccount];
        
        [twitterAPIOS verifyCredentialsWithSuccessBlock:^(NSString *username) {
            
            [twitterAPIOS postReverseAuthAccessTokenWithAuthenticationHeader:authenticationHeader
                                                                successBlock:^(NSString *oAuthToken,
                                                                               NSString *oAuthTokenSecret,
                                                                               NSString *userID,
                                                                               NSString *screenName) {
                                                                    
                                                                    STTwitterAPI *x = [STTwitterAPI twitterAPIWithOAuthConsumerName:nil
                                                                                                                        consumerKey:CONSUMER_KEY
                                                                                                                     consumerSecret:CONSUMER_SECRET
                                                                                                                         oauthToken:oAuthToken
                                                                                                                   oauthTokenSecret:oAuthTokenSecret];
                                                                    
                                                                    [x verifyCredentialsWithSuccessBlock:^(NSString *username) {
                                                                        
                                                                        [x getDirectMessagesSinceID:nil count:10 successBlock:^(NSArray *messages) {
                                                                            // ...
                                                                            
                                                                            self.dms = messages;
                                                                            [self performSelectorOnMainThread:@selector(repaintTable) withObject:self waitUntilDone:NO];

                                                                            
                                                                        } errorBlock:^(NSError *error) {
                                                                            // ...
                                                                        }];
                                                                        
                                                                    } errorBlock:^(NSError *error) {
                                                                        // ...
                                                                    }];
                                                                    
                                                                    
                                                                } errorBlock:^(NSError *error) {
                                                                    // ...
                                                                }];
            
        } errorBlock:^(NSError *error) {
            // ...
        }];
        
    } errorBlock:^(NSError *error) {
        // ...
    }];
    
}


- (void)repaintTable {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TWDMCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"DMCell"];
    
    DFDirectMessage *dm = [[DFDirectMessage alloc] initWithJSONObject:self.dms[indexPath.row]];
    [cell setDm:dm];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end
