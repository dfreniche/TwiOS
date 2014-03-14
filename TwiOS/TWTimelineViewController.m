//
//  TWFirstViewController.m
//  TwiOS
//
//  Created by Diego Freniche Brito on 27/08/13.
//  Copyright (c) 2013 freniche. All rights reserved.
//

#import "TWTimelineViewController.h"
//#import <Social/Social.h>
//#import <Accounts/Accounts.h>
#import "DFTwitterHelper.h"
#import "TWTweetCell.h"

@interface TWTimelineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweets;
@end

@implementation TWTimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [DFTwitterHelper tweetsWithCompletion:^(NSArray *tweets, NSError *error) {
        NSLog(@"Number of tweets: %d", [tweets count]);
        self.tweets = tweets;
        [self performSelectorOnMainThread:@selector(repaintTable) withObject:self waitUntilDone:NO];
        
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

- (IBAction)sendTweet:(id)sender {
    // if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetScreen = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetScreen setInitialText:@"Testing"];
        
        [self presentViewController:tweetScreen animated:YES completion:nil];

    //}
    
}

#pragma mark - UITableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TWTweetCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"TWCell"];
    
    [cell setTweet:[self.tweets objectAtIndex:indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

@end
