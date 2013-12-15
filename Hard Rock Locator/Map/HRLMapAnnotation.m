//
//  HRLMapAnnotation.m
//  Hard Rock Locator
//
//  Created by Dennis Schmidt on 14.12.13.
//  Copyright (c) 2013 dmrschmidt. All rights reserved.
//

#import "HRLMapAnnotation.h"

@implementation HRLMapAnnotation

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate id:(NSString *)hardrockID name:(NSString *)name address:(NSString *)address thumbImageURLString:(NSString *)thumbImageURLString {
  self = [super init];
  if(self) {
    _coordinate = aCoordinate;
    self.hardrockID = hardrockID;
    self.name = name;
    self.address = address;
    self.thumbImageURLString = thumbImageURLString;
    self.thumbImageURL = [NSURL URLWithString:self.thumbImageURLString];
  }
  return self;
}

- (MKPinAnnotationColor)pinColor {
  return self.visited ? MKPinAnnotationColorGreen : MKPinAnnotationColorRed;
}

#pragma mark - Overrides

- (NSString *)title {
  return self.name;
}

- (NSString *)subtitle {
  return self.address;
}

- (BOOL)visited {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  return [userDefaults boolForKey:[self userDefaultsKey]];
}

- (void)setVisited:(BOOL)visited {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setValue:[NSNumber numberWithBool:visited] forKey:[self userDefaultsKey]];
  [userDefaults synchronize];
  _visited = visited;
}

#pragma mark - Private methods

- (NSString *)userDefaultsKey {
  return [NSString stringWithFormat:@"visited_%@", self.hardrockID];
}
@end
