//
//  HRLMapAnnotation.h
//  Hard Rock Locator
//
//  Created by Dennis Schmidt on 14.12.13.
//  Copyright (c) 2013 dmrschmidt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HRLMapAnnotation : NSObject <MKAnnotation> {
  BOOL _visited;
}

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) NSString *hardrockID;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSURL *thumbImageURL;
@property(nonatomic, strong) NSString *thumbImageURLString;

@property(nonatomic, assign) BOOL visited;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
                                id:(NSString *)hardrockID
                              name:(NSString *)name
                           address:(NSString *)address
               thumbImageURLString:(NSString *)thumbImageURLString;
- (MKPinAnnotationColor)pinColor;
@end
