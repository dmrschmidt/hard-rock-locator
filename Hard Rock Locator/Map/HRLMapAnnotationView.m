//
//  HRLMapAnnotationView.m
//  Hard Rock Locator
//
//  Created by Dennis Schmidt on 14.12.13.
//  Copyright (c) 2013 dmrschmidt. All rights reserved.
//

#import "HRLMapAnnotationView.h"
#import "HRLMapAnnotation.h"

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
  NSString *suffix = [(HRLMapAnnotation *)self.annotation visited] ? @"visited" : @"todo";
  UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon-%@", suffix]];
  return [[UIImageView alloc] initWithImage:image];
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
@end
