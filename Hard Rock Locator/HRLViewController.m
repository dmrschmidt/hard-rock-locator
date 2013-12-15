//
//  HRLViewController.m
//  Hard Rock Locator
//
//  Created by Dennis Schmidt on 14.12.13.
//  Copyright (c) 2013 dmrschmidt. All rights reserved.
//

#import "HRLViewController.h"
#import "HRLLocationProvider.h"
#import "HRLMapAnnotation.h"
#import "HRLMapAnnotationView.h"

@interface HRLViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation HRLViewController

- (void)viewDidLoad {
  [super viewDidLoad];
	
  [self inititalizeLocations];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - MKMapViewDelegate methods

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
  MKPinAnnotationView *pin = (MKPinAnnotationView *)view;
  HRLMapAnnotation *annotation = (HRLMapAnnotation *)view.annotation;
  [annotation setVisited:!annotation.visited];
  pin.pinColor = annotation.pinColor;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  HRLMapAnnotationView *pin = [[HRLMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"hardrock"];
  return pin;
}

#pragma mark - Location Methods

- (void)inititalizeLocations {
  HRLLocationProvider *locationProvider = [[HRLLocationProvider alloc] init];
  [locationProvider.locations enumerateObjectsUsingBlock:^(HRLMapAnnotation *annotation, NSUInteger idx, BOOL *stop) {
    [self.mapView addAnnotation:annotation];
  }];
}

@end
