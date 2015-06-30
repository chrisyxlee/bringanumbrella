//
//  Forecast.m
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import "Forecast.h"

@implementation Forecast

- (instancetype)initWithForecast:(NSArray *)forecast {
    self = [super init];
    if (self) {
        _weatherArray = [forecast mutableCopy];
    }
    return self;
}

@end
