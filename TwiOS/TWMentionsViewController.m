//
//  TWMentionsTableViewController.m
//  TwiOS
//
//  Created by Diego Freniche Brito on 14/03/14.
//  Copyright (c) 2014 freniche. All rights reserved.
//

#import "TWMentionsViewController.h"
#import "DFTwitterHelper.h"
#import "TWTweetCell.h"

@interface TWMentionsViewController ()
@property (nonatomic, strong) NSArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TWMentionsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [DFTwitterHelper mentionsWithCompletion:^(NSArray *tweets, NSError *error) {
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
