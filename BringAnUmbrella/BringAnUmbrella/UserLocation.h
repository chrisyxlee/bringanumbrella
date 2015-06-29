//
//  UserLocation.h
//  BringAnUmbrella
//
//  Created by Zareen Choudhury on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface UserLocation : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *currentLocation;
@property (nonatomic) float longitude;
@property (nonatomic) float latitude;

@end
