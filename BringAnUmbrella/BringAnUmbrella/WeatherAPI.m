//
//  WeatherAPI.m
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import "WeatherAPI.h"
#import "UserLocation.h"
#import "Weather.h"

NSString * const BaseURLStringWeather = @"http://api.openweathermap.org/data/2.5/weather";
NSString * const BaseURLStringForecast = @"http://api.openweathermap.org/data/2.5/forecast";
NSString * const APIKey = @"3ae7ed578eb03aa2b78f2329bd28c6f5";

#define WEATHER     0
#define FORECAST    1

@implementation WeatherAPI

+ (NSURL *)currentWeatherURLForLocation:(UserLocation *)location {
    NSString *longitude = [NSString stringWithFormat:@"%d",(int)location.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%d",(int)location.latitude];
    
    NSDictionary *params = @{ @"lon":longitude,
                              @"lat":latitude };
    
    NSURL *currentWeatherURL = [self weatherURLWithWeatherType:WEATHER
                                                    parameters:params];
    return currentWeatherURL;
}

+ (Weather *)weatherFromJSON:(NSDictionary *)jsonDict {
    NSString *type = jsonDict[@"weather"][@"main"];
    CGFloat temp = [jsonDict[@"main"][@"temp"] floatValue];
    NSInteger humidity = [jsonDict[@"main"][@"humidity"] intValue];
    NSInteger minTemp = [jsonDict[@"main"][@"temp_min"] intValue];
    NSInteger maxTemp = [jsonDict[@"main"][@"temp_max"] intValue];
    NSInteger rain = 0.0;
    if (jsonDict[@"rain"]) rain = [jsonDict[@"main"][@"3h"] intValue];
    NSInteger clouds = 0;
    if (jsonDict[@"clouds"]) clouds = [jsonDict[@"clouds"][@"all"] intValue];
    
    if (!(type || temp || humidity || minTemp || maxTemp)) return nil;
    
    Weather *weather = [[Weather alloc] initWithType:type
                                         temperature:temp
                                         minimumTemp:minTemp
                                         maximumTemp:maxTemp
                                        amountOfRain:rain
                                            humidity:humidity
                                              clouds:clouds];
    return weather;
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
