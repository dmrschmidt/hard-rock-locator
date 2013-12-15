//
//  HRLMapAnnotationView.m
//  Hard Rock Locator
//
//  Created by Dennis Schmidt on 14.12.13.
//  Copyright (c) 2013 dmrschmidt. All rights reserved.
//

#import "HRLMapAnnotationView.h"
#import "HRLMapAnnotation.h"

@interface HRLMapAnnotationView()
@property (strong, nonatomic) UIButton *stateButton;
@end

@implementation HRLMapAnnotationView
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
  if(self) {
    self.canShowCallout = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self addGestureRecognizer:tapGestureRecognizer];
    [self loadImage];
  }
  
  return self;
}

- (MKPinAnnotationColor)pinColor {
  return [(HRLMapAnnotation *)self.annotation pinColor];
}

- (UIView *)rightCalloutAccessoryView {
  UIImage *image = [self currentStateImage];
  
  self.stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.stateButton setImage:image forState:UIControlStateNormal];
  self.stateButton.frame = CGRectMake(0, 0, 32, 32);
  
  return self.stateButton;
}

- (void)didTap:(UITapGestureRecognizer *)gestureRecognizer {
//  CGPoint touchPoint = [gestureRecognizer locationInView:self];
//  NSLog(@"%f, %f", touchPoint.x, self.bounds.size.width);
//  if(touchPoint.x < self.bounds.size.width) {
//    NSLog(@"should open maps");
//  }
//  NSLog(@"did tap: %@", NSStringFromCGPoint(touchPoint));
//  NSLog(@"view: %@", [self hitTest:touchPoint withEvent:nil]);
//  NSLog(@"rect: %@", NSStringFromCGRect(self.frame));
}

- (void)redraw {
  [self.stateButton setImage:[self currentStateImage] forState:UIControlStateNormal];
  self.pinColor = ((HRLMapAnnotation *)self.annotation).pinColor;
}

#pragma mark - Private methods
- (void)loadImage {
  if(((HRLMapAnnotation *)self.annotation).thumbImageURL) {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
      UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
      NSData *imageData = [NSData dataWithContentsOfURL:((HRLMapAnnotation *)self.annotation).thumbImageURL];
      imageView.image = [UIImage imageWithData:imageData];
      
      dispatch_async(dispatch_get_main_queue(), ^(void){
        self.leftCalloutAccessoryView = imageView;
      });
    });
  }
}

- (UIImage *)currentStateImage {
  NSString *suffix = [(HRLMapAnnotation *)self.annotation visited] ? @"visited" : @"todo";
  UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon-%@", suffix]];
  return image;
}

@end
