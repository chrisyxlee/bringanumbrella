//
//  Forecast.h
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Forecast;
@class UserLocation;

@interface ForecastStore : NSObject

- (Forecast *)getForecastFromFiveDayForecastFetchWithLocation:(UserLocation *)location;

@end
