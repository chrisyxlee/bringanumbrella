//
//  Forecast.m
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import "Forecast.h"
#import "Weather.h"

@implementation Forecast

//MARK: initializers
- (instancetype)init {
    NSArray *weatherArray = [NSArray array];
    self = [self initWithForecast:weatherArray];
    return self;
}

- (instancetype)initWithForecast:(NSArray *)forecast {
    self = [super init];
    if (self) {
        _weatherArray = [forecast mutableCopy];
    }
    return self;
}

- (BOOL)tomorrowWillRain {
    for (Weather *weather in self.weatherArray) {
        if (weather.rain > 0.05) return true;
    }
    return false;
}

@end
