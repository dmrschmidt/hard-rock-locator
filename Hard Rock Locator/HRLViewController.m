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
@property (weak, nonatomic) IBOutlet UILabel *visitedCountLabel;
@property (strong, nonatomic) HRLLocationProvider *locationProvider;
@property (assign, nonatomic) NSTimeInterval firstStartTime;
@end

@implementation HRLViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    self.locationProvider = [[HRLLocationProvider alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.firstStartTime = [NSDate timeIntervalSinceReferenceDate];
  
  [self inititalizeLocations];
  [self updateVisitedCountLabel];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - MKMapViewDelegate methods

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
  if([NSDate timeIntervalSinceReferenceDate] > self.firstStartTime + 5) return;
  
  MKCoordinateRegion region;
  MKCoordinateSpan span;
  span.latitudeDelta = 10;
  span.longitudeDelta = 10;
  CLLocationCoordinate2D location;
  location.latitude = aUserLocation.coordinate.latitude;
  location.longitude = aUserLocation.coordinate.longitude;
  region.span = span;
  region.center = location;
  [aMapView setRegion:region animated:YES];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
  if(control.tag == 1) {
    [self openInMaps:view.annotation.coordinate];
  } else {
    HRLMapAnnotationView *pin = (HRLMapAnnotationView *)view;
    [self.locationProvider toggleAnnotationVisitedStatus:pin];
    [self updateVisitedCountLabel];
  }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  if ([annotation class] == MKUserLocation.class) {
    return nil;
  }
  
  return [[HRLMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"hardrock"];
}

#pragma mark - Location Methods

- (void)inititalizeLocations {
  [self.locationProvider.locations enumerateObjectsUsingBlock:^(HRLMapAnnotation *annotation, NSUInteger idx, BOOL *stop) {
    [self.mapView addAnnotation:annotation];
  }];
}

#pragma mark - Private methods
- (void)openInMaps:(CLLocationCoordinate2D)coordinate {
  Class mapItemClass = [MKMapItem class];
  if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [mapItem setName:@"Hard Rock Café"];
    [mapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving}];
  }
}

- (void)updateVisitedCountLabel {
  self.visitedCountLabel.text = [NSString stringWithFormat:@"visited %lu / %lu", (unsigned long)self.locationProvider.visitedAnnotationsCount, (unsigned long)self.locationProvider.locations.count];
}

@end
