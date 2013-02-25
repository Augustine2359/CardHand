//
//  CHHandTableViewCell.m
//  CardHand
//
//  Created by Augustine on 25/2/13.
//  Copyright (c) 2013 Augustine. All rights reserved.
//

#import "CHHandTableViewCell.h"

@interface CHHandTableViewCell()

@property (nonatomic, strong) UIView *backgroundColorView;

@end

@implementation CHHandTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      self.selectionStyle = UITableViewCellSelectionStyleNone;
      self.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);

      self.backgroundColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds))];
      self.backgroundColorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      [self.contentView addSubview:self.backgroundColorView];
    }
    return self;
}

- (void)setBackground:(UIColor *)color {
  self.backgroundColorView.backgroundColor = color;
}

- (void)transformToView:(UIView *)view {
  CGFloat xInView = [self.superview convertPoint:self.center toView:view].x;
  CGFloat ratioOfPositionToScreen = (xInView + CGRectGetWidth(self.frame)/2) / (CGRectGetWidth(view.frame) + CGRectGetWidth(self.frame));
  ratioOfPositionToScreen *= M_PI;
  CGFloat maximumRotation = 0.5;
  CGAffineTransform transform = CGAffineTransformIdentity;

  CGFloat rotation = maximumRotation * cosf(ratioOfPositionToScreen);
  rotation *= -1;
  transform = CGAffineTransformMakeRotation(rotation);

  CGFloat desiredDistanceFromBottomMiddleOfScreen = CGRectGetHeight(self.frame)/2;
  CGFloat distanceFromVerticalAxisAtMiddleOfScreen = CGRectGetWidth(view.frame)/2 - xInView;
  CGFloat angle = atanf(distanceFromVerticalAxisAtMiddleOfScreen / desiredDistanceFromBottomMiddleOfScreen);
  CGFloat actualDistanceFromBottomMiddleOfScreen = desiredDistanceFromBottomMiddleOfScreen / cosf(angle);
  CGFloat overshotDistance = actualDistanceFromBottomMiddleOfScreen - desiredDistanceFromBottomMiddleOfScreen;

  CGFloat transformX = overshotDistance * cosf(angle);
  if (xInView > CGRectGetWidth(view.frame)/2)
    transformX *= -1;
  CGFloat transformY = fabsf(overshotDistance * sinf(angle));
  transform = CGAffineTransformTranslate(transform, transformX, transformY);

  self.backgroundColorView.transform = transform;
}

@end
