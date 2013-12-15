//
//  HRLMapAnnotation.m
//  Hard Rock Locator
//
//  Created by Dennis Schmidt on 14.12.13.
//  Copyright (c) 2013 dmrschmidt. All rights reserved.
//

#import "HRLMapAnnotation.h"

@implementation HRLMapAnnotation

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate name:(NSString *)name address:(NSString *)address thumbImageURLString:(NSString *)thumbImageURLString {
  self = [super init];
  if(self) {
    _coordinate = aCoordinate;
    self.name = name;
    self.address = address;
    self.thumbImageURLString = thumbImageURLString;
  }
  return self;
}
@end
