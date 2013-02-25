//
//  CHHandTableView.m
//  CardHand
//
//  Created by Augustine on 25/2/13.
//  Copyright (c) 2013 Augustine. All rights reserved.
//

#import "CHHandTableView.h"
#import "CHHandTableViewCell.h"

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

- (NSIndexPath *)indexPathForCellWithButton:(UIButton *)button {
  for (CHHandTableViewCell *cell in [self visibleCells]) {
    if ([cell containsButton:button])
      return [self indexPathForCell:cell];
  }
  return nil;
}

@end
