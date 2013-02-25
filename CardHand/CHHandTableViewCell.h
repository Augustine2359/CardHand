//
//  CHHandTableViewCell.h
//  CardHand
//
//  Created by Augustine on 25/2/13.
//  Copyright (c) 2013 Augustine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHHandTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier target:(UIViewController *)buttonTarget;
- (void)setButtonTarget:(UIViewController *)target;
- (void)setBackground:(UIColor *)color;
- (void)transformToView:(UIView *)view;
- (BOOL)containsButton:(UIButton *)button;

@end
