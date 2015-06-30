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
#import "Forecast.h"

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

+ (NSURL *)fiveDayWeatherURLForLocation:(UserLocation *)location {
    NSString *longitude = [NSString stringWithFormat:@"%d",(int)location.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%d",(int)location.latitude];
    
    NSDictionary *params = @{ @"lon":longitude,
                              @"lat":latitude };
    
    NSURL *forecastWeatherURL = [self weatherURLWithWeatherType:FORECAST
                                                    parameters:params];
    return forecastWeatherURL;
}

+ (Forecast *)forecastFromJSONData:(NSData *)jsonData {
    NSMutableArray *forecast = [NSMutableArray array];
    
    NSError *parseError = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&parseError];
    
    if (jsonObject) {
        NSArray *list = jsonObject[@"list"];
        for (NSDictionary *weather in list) {
            NSString *type = [weather[@"weather"] firstObject][@"main"];
            float temp = [weather[@"main"][@"temp"] floatValue];
            float minTemp = [weather[@"main"][@"temp_min"] floatValue];
            float maxTemp = [weather[@"main"][@"temp_max"] floatValue];
            float rain = [weather[@"rain"][@"3h"] floatValue];
            float humidity = [weather[@"main"][@"humidity"] floatValue];
            NSInteger clouds = [weather[@"clouds"][@"all"] intValue];
            
            Weather *weather = [[Weather alloc] initWithType:type
                                                 temperature:temp
                                                 minimumTemp:minTemp
                                                 maximumTemp:maxTemp
                                                amountOfRain:rain
                                                    humidity:humidity
                                                      clouds:clouds];
            [forecast addObject:weather];
        }
    } else NSLog(@"Failed to parse JSON forecast data. Error: %@", parseError.localizedDescription);
    
    Forecast *weatherForecast = [[Forecast alloc] initWithForecast:forecast];
    return weatherForecast;
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
                                         @"units" : @"imperial",
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
