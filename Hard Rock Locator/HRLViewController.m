//
//  HRLViewController.m
//  Hard Rock Locator
//
//  Created by Dennis Schmidt on 14.12.13.
//  Copyright (c) 2013 dmrschmidt. All rights reserved.
//

#import "HRLViewController.h"
#import <MapKit/MapKit.h>
#import "HRLLocationProvider.h"
#import "HRLMapAnnotation.h"

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
  // Dispose of any resources that can be recreated.
}

#pragma mark - Location Methods

- (void)inititalizeLocations {
  HRLLocationProvider *locationProvider = [[HRLLocationProvider alloc] init];
  [locationProvider.locations enumerateObjectsUsingBlock:^(HRLMapAnnotation *annotation, NSUInteger idx, BOOL *stop) {
    [self.mapView addAnnotation:annotation];
  }];
}

@end
