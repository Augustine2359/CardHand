//
//  CHHandTableViewCell.m
//  CardHand
//
//  Created by Augustine on 25/2/13.
//  Copyright (c) 2013 Augustine. All rights reserved.
//

#import "CHHandTableViewCell.h"

@interface CHHandTableViewCell()

@property (nonatomic, strong) UIButton *backgroundButton;

@end

@implementation CHHandTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backgroundButton.frame = CGRectMake(0, 0, CARD_WIDTH, CARD_HEIGHT);
    [self.contentView addSubview:self.backgroundButton];
  }
  return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier target:(UIViewController *)target{
  self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setButtonTarget:target];
  }
  return self;
}

- (void)setButtonTarget:(UIViewController *)target {
  [self.backgroundButton addTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
  [self.backgroundButton addTarget:target action:@selector(scrollToCellWithButton:) forControlEvents:UIControlEventTouchDown];
}

- (void)setBackground:(UIColor *)color {
  [self.backgroundButton setBackgroundColor:color];
}

- (BOOL)containsButton:(UIButton *)button {
  if ([self.backgroundButton isEqual:button])
    return YES;
  return NO;
}

- (void)transformToView:(UIView *)view {
  CGFloat xInView = [self.superview convertPoint:self.center toView:view].x;
  CGFloat ratioOfPositionToScreen = (xInView + CGRectGetWidth(self.frame)/2) / (CGRectGetWidth(view.bounds) + CGRectGetWidth(self.frame));
  ratioOfPositionToScreen *= M_PI;
  CGFloat maximumRotation = 0.5;
  CGAffineTransform transform = CGAffineTransformIdentity;

  CGFloat rotation = maximumRotation * cosf(ratioOfPositionToScreen);
  rotation *= -1;
  transform = CGAffineTransformMakeRotation(rotation);

  CGFloat desiredDistanceFromBottomMiddleOfScreen = CGRectGetHeight(self.frame)/2;
  CGFloat distanceFromVerticalAxisAtMiddleOfScreen = CGRectGetWidth(view.bounds)/2 - xInView;
  CGFloat angle = atanf(distanceFromVerticalAxisAtMiddleOfScreen / desiredDistanceFromBottomMiddleOfScreen);
  CGFloat actualDistanceFromBottomMiddleOfScreen = desiredDistanceFromBottomMiddleOfScreen / cosf(angle);
  CGFloat overshotDistance = actualDistanceFromBottomMiddleOfScreen - desiredDistanceFromBottomMiddleOfScreen;

  CGFloat transformX = overshotDistance * cosf(angle);
  if (xInView > CGRectGetWidth(view.bounds)/2)
    transformX *= -1;
  CGFloat transformY = fabsf(overshotDistance * sinf(angle))/2;
  transform = CGAffineTransformTranslate(transform, transformX, transformY);

  self.backgroundButton.transform = transform;
}

@end
