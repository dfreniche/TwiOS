//
//  TWFirstViewController.m
//  TwiOS
//
//  Created by Diego Freniche Brito on 27/08/13.
//  Copyright (c) 2013 freniche. All rights reserved.
//

#import "TWTimelineViewController.h"
#import <Social/Social.h>

@interface TWTimelineViewController ()

@end

@implementation TWTimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
@end
