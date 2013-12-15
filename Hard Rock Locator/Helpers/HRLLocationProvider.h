//
//  HRLLocationProvider.h
//  Hard Rock Locator
//
//  Created by Dennis Schmidt on 14.12.13.
//  Copyright (c) 2013 dmrschmidt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HRLMapAnnotationView;

@interface HRLLocationProvider : NSObject
- (NSArray *)locations;
- (void)toggleAnnotationVisitedStatus:(HRLMapAnnotationView *)annotationView;
@end
