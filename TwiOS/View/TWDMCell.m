//
//  TWDMCell.m
//  TwiOS
//
//  Created by Diego Freniche Brito on 14/03/14.
//  Copyright (c) 2014 freniche. All rights reserved.
//

#import "TWDMCell.h"



@interface TWDMCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblSender;
@property (weak, nonatomic) IBOutlet UILabel *lblDM;
@property (weak, nonatomic) IBOutlet UIImageView *imgSender;

@end

@implementation TWDMCell

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


- (void)setDm:(DFDirectMessage *)dm {
    self.lblSender.text = dm.sender;
    self.lblDM.text = dm.text;
    self.imgSender.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dm.senderImageURL]]];
    
}

@end
