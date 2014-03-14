//
//  TWConfigViewController.m
//  TwiOS
//
//  Created by Diego Freniche Brito on 14/03/14.
//  Copyright (c) 2014 freniche. All rights reserved.
//

#import "TWConfigViewController.h"
#import "DFTwitterHelper.h"

@interface TWConfigViewController ()
@property (weak, nonatomic) IBOutlet UITextView *accountInfoText;
@property (nonatomic, strong) DFTwitterAccountInfo *accountInfo;
@end

@implementation TWConfigViewController

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
    [DFTwitterHelper twitterAccountInfoWithUser:@"dfrenichetester" completion:^(DFTwitterAccountInfo *accountInfo, NSError *error) {
        self.accountInfo = accountInfo;
        [self performSelectorOnMainThread:@selector(showInfo) withObject:self waitUntilDone:NO];
        
    }];
}

- (void)showInfo {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    NSString *s = [NSString stringWithFormat:@"%@\nFollowers: %d\nFollowing:%d", self.accountInfo.name, self.accountInfo.followersCount, self.accountInfo.followingCount];
    
    [self.accountInfoText setText:s];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)reconnect:(id)sender {
}

@end
