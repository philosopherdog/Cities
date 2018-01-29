//
//  ViewController.m
//  Cities
//
//  Created by steve on 2018-01-29.
//  Copyright © 2018 steve. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic)UIScrollView *sv;
@property (nonatomic)UIImageView *imageView1;
@property (nonatomic)UIImageView *imageView2;
@property (nonatomic)UIPageControl *pageControl;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupScrollView];
  [self setupPageControl];
  [self setupLayout];
}

- (void)setupScrollView {
  self.sv = [[UIScrollView alloc] init];
  self.sv.pagingEnabled = YES;
  [self.view addSubview:self.sv];
  self.imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toronto"]];
  self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
  self.imageView1.clipsToBounds = YES;
  self.imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"montreal"]];
  self.imageView2.contentMode = UIViewContentModeScaleAspectFill;
  self.imageView2.clipsToBounds = YES;
  [self.sv addSubview:self.imageView1];
  [self.sv addSubview:self.imageView2];
  self.sv.delegate = self;
}

#define numPages 2

- (void)setupPageControl {
  self.pageControl = [[UIPageControl alloc] init];
  [self.view addSubview:self.pageControl];
  self.pageControl.backgroundColor = [UIColor blackColor];
  self.pageControl.alpha = 0.65;
  self.pageControl.numberOfPages = numPages;
  [self.view bringSubviewToFront:self.pageControl];
//  self.pageControl.layer.zPosition = 10;
}

#define pageControlHeight 50.0

- (void)viewDidLayoutSubviews {
  CGFloat maxY = CGRectGetMaxY(self.view.frame);
  CGFloat yVal = maxY - pageControlHeight;
  CGRect pageControlRect = CGRectMake(0, yVal, self.view.frame.size.width, pageControlHeight);
  self.pageControl.frame = pageControlRect;
}

- (void)setupLayout {
  self.sv.translatesAutoresizingMaskIntoConstraints = NO;
  self.imageView1.translatesAutoresizingMaskIntoConstraints = NO;
  self.imageView2.translatesAutoresizingMaskIntoConstraints = NO;
  
  // ScrollView Pinned
  [self.sv.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
  [self.sv.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
  [self.sv.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.sv.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  
  // Top and Bottom
  [self.imageView1.topAnchor constraintEqualToAnchor:self.sv.topAnchor].active = YES;
  [self.imageView2.topAnchor constraintEqualToAnchor:self.sv.topAnchor].active = YES;
  [self.imageView1.bottomAnchor constraintEqualToAnchor:self.sv.bottomAnchor].active = YES;
  [self.imageView2.bottomAnchor constraintEqualToAnchor:self.sv.bottomAnchor].active = YES;
  
  [self.imageView1.leadingAnchor constraintEqualToAnchor:self.sv.leadingAnchor].active = YES;
  [self.imageView1.trailingAnchor constraintEqualToAnchor:self.imageView2.leadingAnchor].active = YES;
  [self.imageView1.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
  [self.imageView1.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;

  [self.imageView2.leadingAnchor constraintEqualToAnchor:self.imageView1.trailingAnchor].active = YES;
  [self.imageView2.trailingAnchor constraintEqualToAnchor:self.sv.trailingAnchor].active = YES;
  [self.imageView2.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
  [self.imageView2.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;

}

// 100
// 200

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  CGFloat xOffset = scrollView.contentOffset.x;
  CGFloat viewWidth = self.view.frame.size.width;
  NSInteger pageNumber = (xOffset + viewWidth)/viewWidth;
  self.pageControl.currentPage = pageNumber-1;
}

@end
