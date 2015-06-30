//
//  UserLocation.m
//  BringAnUmbrella
//
//  Created by Zareen Choudhury on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import "UserLocation.h"

@implementation UserLocation

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [_locationManager requestAlwaysAuthorization];
        }
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        [_locationManager startUpdatingLocation];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [locations lastObject];
    //NSDate *eventDate = self.currentLocation.timestamp;
    //NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    self.longitude = self.currentLocation.coordinate.longitude;
    self.latitude = self.currentLocation.coordinate.latitude;
    NSLog(@"Longitude: %.2f, Latitude: %.2f", self.longitude, self.latitude);
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error in finding location.");
}

@end
