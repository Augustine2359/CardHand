//
//  CHViewController.m
//  CardHand
//
//  Created by Augustine on 25/2/13.
//  Copyright (c) 2013 Augustine. All rights reserved.
//

#import "CHViewController.h"
#import "CHHandTableView.h"
#import "CHHandTableViewCell.h"

#define CARD_WIDTH 100

@interface CHViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CHHandTableView *handTableView;

@end

@implementation CHViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.handTableView = [[CHHandTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  self.handTableView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds)/2, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)/2);
  self.handTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.handTableView.dataSource = self;
  self.handTableView.delegate = self;
  [self.view addSubview:self.handTableView];
}

- (void)scrollToCellWithButton:(UIButton *)button {
  NSIndexPath *indexPath = [self.handTableView indexPathForCellWithButton:button];
  if (indexPath != nil) {
    CGFloat startingScrollOffset = (CGRectGetWidth(self.handTableView.frame) - CARD_WIDTH)/2;
    [self.handTableView setContentOffset:CGPointMake(0, (indexPath.row * CARD_WIDTH) - startingScrollOffset) animated:YES];
  }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return CARD_WIDTH;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *identifier = @"Identifier";
  CHHandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil) {
    cell = [[CHHandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier target:self];
  }
  
  switch (indexPath.row) {
    case 0:
      [cell setBackground:[UIColor redColor]];
      break;
    case 1:
      [cell setBackground:[UIColor blueColor]];
      break;
    case 2:
      [cell setBackground:[UIColor yellowColor]];
      break;
    case 3:
      [cell setBackground:[UIColor greenColor]];
      break;
    case 4:
      [cell setBackground:[UIColor grayColor]];
      break;
    default:
      break;
  }
  
  return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [self repositionCards];
}

- (void)repositionCards {
  for (CHHandTableViewCell *cell in self.handTableView.visibleCells) {
    [cell transformToView:self.view];
  }
}

@end
