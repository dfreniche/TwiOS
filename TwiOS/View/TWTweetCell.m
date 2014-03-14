//
//  TWTweetCell.m
//  TwiOS
//
//  Created by Diego Freniche Brito on 12/03/14.
//  Copyright (c) 2014 freniche. All rights reserved.
//

#import "TWTweetCell.h"

@interface TWTweetCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblTweetText;
@property (weak, nonatomic) IBOutlet UILabel *lblSource;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;

@end

@implementation TWTweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setTweet

- (void)setTweet:(DFTweet *)tweet {
    self.lblTweetText.text = tweet.text;
    self.lblSource.text = tweet.source;
    self.lblUserName.text = tweet.userName;
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tweet.profileImageUrl]]];
}

@end
