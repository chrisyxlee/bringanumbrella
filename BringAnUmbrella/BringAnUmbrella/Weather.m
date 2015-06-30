//
//  Weather.m
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import "Weather.h"

@implementation Weather

//MARK: initalizers
- (instancetype)initWithType:(NSString *)type
                 temperature:(float)temp
                 minimumTemp:(float)minTemp
                 maximumTemp:(float)maxTemp
                amountOfRain:(float)rain
                    humidity:(float)humidity
                      clouds:(NSInteger)clouds
                        date:(NSDate *)date {
    self = [super init];
    if (self) {
        _type = type;
        _temperature = temp;
        _minTemp = minTemp;
        _maxTemp = maxTemp;
        _rain = rain;
        _clouds = clouds;
        _humidity = humidity;
        _date = date;
    }
    return self;
}

@end
