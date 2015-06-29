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
                 temperature:(CGFloat)temp
                 minimumTemp:(NSInteger)minTemp
                 maximumTemp:(NSInteger)maxTemp
                amountOfRain:(NSInteger)rain
                    humidity:(NSInteger)humidity
                      clouds:(NSInteger)clouds {
    self = [super init];
    if (self) {
        _type = type;
        _temperature = temp;
        _minTemp = minTemp;
        _maxTemp = maxTemp;
        _rain = rain;
        _clouds = clouds;
        _humidity = humidity;
    }
    return self;
}

@end
