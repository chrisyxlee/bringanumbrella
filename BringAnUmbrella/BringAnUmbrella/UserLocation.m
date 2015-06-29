//
//  UserLocation.m
//  BringAnUmbrella
//
//  Created by Zareen Choudhury on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import "UserLocation.h"

@implementation UserLocation

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSDate *eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 30.0)
    {
        self.longitude = location.coordinate.longitude;
        self.latitude = location.coordinate.latitude;
    }
}

- (void)startSignificantChangeUpdates
{
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    self.locationManager.delegate = self;
    [self.locationManager startMonitoringSignificantLocationChanges];
}

@end
