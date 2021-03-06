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
  self.stateButton.tag = 2;
  [self.stateButton setImage:image forState:UIControlStateNormal];
  self.stateButton.frame = CGRectMake(0, 0, 32, 32);
  
  return self.stateButton;
}

- (void)redraw {
  [self.stateButton setImage:[self currentStateImage] forState:UIControlStateNormal];
  self.pinColor = ((HRLMapAnnotation *)self.annotation).pinColor;
}

#pragma mark - Private methods
- (void)loadImage {
  UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
  leftButton.tag = 1;
  leftButton.frame = CGRectMake(0, 0, 32, 32);
  self.leftCalloutAccessoryView = leftButton;
  
  if(((HRLMapAnnotation *)self.annotation).thumbImageURL) {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
      NSData *imageData = [NSData dataWithContentsOfURL:((HRLMapAnnotation *)self.annotation).thumbImageURL];
      
      dispatch_async(dispatch_get_main_queue(), ^(void){
        [leftButton setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
      });
    });
  } else {
    [leftButton setImage:[UIImage imageNamed:@"icon-car"] forState:UIControlStateNormal];
  }
}

- (UIImage *)currentStateImage {
  NSString *suffix = [(HRLMapAnnotation *)self.annotation visited] ? @"visited" : @"todo";
  UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon-%@", suffix]];
  return image;
}

@end
