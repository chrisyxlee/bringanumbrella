//
//  WeatherAPI.m
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import "WeatherAPI.h"
#import "UserLocation.h"

NSString * const BaseURLStringWeather = @"http://api.openweathermap.org/data/2.5/weather";
NSString * const BaseURLStringForecast = @"http://api.openweathermap.org/data/2.5/forecast";
NSString * const APIKey = @"3ae7ed578eb03aa2b78f2329bd28c6f5";

#define WEATHER     0
#define FORECAST    1

@implementation WeatherAPI

+ (NSURL *)currentWeatherURLForLocation:(UserLocation *)location {
    NSInteger longitude = location.longitude;
    NSInteger latitude = location.latitude;
    
    NSNumber *lon = [NSNumber numberWithInteger:longitude];
    NSNumber *lat = [NSNumber numberWithInteger:latitude];
    
    NSDictionary *params = @{ @"lon":lon,
                              @"lat":lat };
    
    NSURL *currentWeatherURL = [self weatherURLWithWeatherType:WEATHER
                                                    parameters:params];
    return currentWeatherURL;
}

//private
+ (NSURL *)weatherURLWithWeatherType:(NSInteger)type
                          parameters:(NSDictionary *)params {
    NSURLComponents *components = nil;
    switch(type) {
        case WEATHER:
            components = [NSURLComponents componentsWithString:BaseURLStringWeather];
            break;
        case FORECAST:
            components = [NSURLComponents componentsWithString:BaseURLStringForecast];
            break;
        default:
            break;
    }
    
    NSMutableArray *queryItems = [NSMutableArray array];
    
    //currently assuming fahrenheit
    NSMutableDictionary *allParams = [@{ @"api_key" : APIKey,
                                         @"metric" : @"imperial",
                                         @"type" : @"accurate" } mutableCopy];
    
    [allParams addEntriesFromDictionary:params];
    
    for (NSString *queryKey in allParams.allKeys) {
        NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:queryKey
                                                                value:allParams[queryKey]];
        [queryItems addObject:queryItem];
    }
    
    components.queryItems = queryItems;
    return components.URL;
}


@end
