//
//  HRLMapAnnotation.h
//  Hard Rock Locator
//
//  Created by Dennis Schmidt on 14.12.13.
//  Copyright (c) 2013 dmrschmidt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HRLMapAnnotation : NSObject <MKAnnotation>

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSString *thumbImageURLString;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate name:(NSString *)name address:(NSString *)address thumbImageURLString:(NSString *)thumbImageURLString;
@end
