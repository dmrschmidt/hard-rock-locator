//
//  HRLLocationProvider.m
//  Hard Rock Locator
//
//  Created by Dennis Schmidt on 14.12.13.
//  Copyright (c) 2013 dmrschmidt. All rights reserved.
//

#import "HRLLocationProvider.h"
#import "HRLMapAnnotation.h"
#import "HRLMapAnnotationView.h"

@implementation HRLLocationProvider
- (instancetype)init {
  self = [super init];
  if(self) {
    [self loadLocations];
    [self updateVisitedAnnotationsCount];
  }
  
  return self;
}

- (void)toggleAnnotationVisitedStatus:(HRLMapAnnotationView *)annotationView {
  HRLMapAnnotation *annotation = annotationView.annotation;
  [annotation setVisited:!annotation.visited];
  [annotationView redraw];
  
  [self updateVisitedAnnotationsCount];
}

#pragma mark - Private

- (void)loadLocations {
  NSArray *locationDictionaries = [self locationDictionaries];
  NSMutableArray *locations = [[NSMutableArray alloc] initWithCapacity:locationDictionaries.count];
  
  [locationDictionaries enumerateObjectsUsingBlock:^(NSDictionary *locationDict, NSUInteger idx, BOOL *stop) {
    HRLMapAnnotation *annotation = [self annotationFromDictionary:locationDict];
    [locations addObject:annotation];
  }];
  _locations = [NSArray arrayWithArray:locations];
}

- (void)updateVisitedAnnotationsCount {
  _visitedAnnotationsCount = 0;
  [self.locations enumerateObjectsUsingBlock:^(HRLMapAnnotation *annotation, NSUInteger idx, BOOL *stop) {
    _visitedAnnotationsCount += (NSUInteger)annotation.visited;
  }];
}

- (NSArray *)locationDictionaries {
  NSURL *JSONURL = [[NSBundle mainBundle] URLForResource:@"locations" withExtension:@"json"];
  NSString *stringPath = [JSONURL absoluteString];
  
  NSData *JSONData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringPath]];
  NSArray *locationDictionaries = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
  return locationDictionaries;
}

- (HRLMapAnnotation *)annotationFromDictionary:(NSDictionary *)dictionary {
  CLLocationDegrees latitude = [dictionary[@"lat"] floatValue];
  CLLocationDegrees longitude = [dictionary[@"long"] floatValue];
  CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
  HRLMapAnnotation *annotation = [[HRLMapAnnotation alloc] initWithCoordinate:coordinate
                                                                           id:dictionary[@"id"]
                                                                         name:dictionary[@"name"]
                                                                      address:dictionary[@"address"]
                                                          thumbImageURLString:dictionary[@"thumbImage"]];
  return annotation;
}

@end
