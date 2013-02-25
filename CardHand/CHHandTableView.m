//
//  CHHandTableView.m
//  CardHand
//
//  Created by Augustine on 25/2/13.
//  Copyright (c) 2013 Augustine. All rights reserved.
//

#import "CHHandTableView.h"

@implementation CHHandTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
      self.transform = CGAffineTransformMakeRotation(-M_PI_2);
      self.separatorStyle = UITableViewCellSeparatorStyleNone;
      self.backgroundColor = [UIColor clearColor];
      self.clipsToBounds = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
