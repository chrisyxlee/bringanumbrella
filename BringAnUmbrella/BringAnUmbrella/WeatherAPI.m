//
//  WeatherAPI.m
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import "WeatherAPI.h"
#import "UserLocation.h"

NSString * const BaseURLString = @"http://api.openweathermap.org/data/2.5/weather";
NSString * const APIKey = @"3ae7ed578eb03aa2b78f2329bd28c6f5";

@implementation WeatherAPI

+ currentWeatherURLForLocation:(UserLocation *)location {
    NSInteger longitude = location.longitude;
    NSInteger latitude = location.latitude;
    
    NSNumber *lon = [NSNumber numberWithInteger:longitude];
    NSNumber *lat = [NSNumber numberWithInteger:latitude];
    
    NSDictionary *params = @{ @"lon":lon,
                              @"lat":lat };
    
    NSURL *currentWeatherURL = [self weatherURLWithParameters:params];
    return currentWeatherURL;
}

//private
+ (NSURL *)weatherURLWithParameters:(NSDictionary *)params {
    NSURLComponents *components = [NSURLComponents componentsWithString:BaseURLString];
    NSMutableArray *queryItems = [NSMutableArray array];
    
    NSMutableDictionary *allParams = [@{ @"api_key" : APIKey } mutableCopy];
    
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
