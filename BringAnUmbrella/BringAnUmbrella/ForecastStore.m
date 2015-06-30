//
//  Forecast.m
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import "ForecastStore.h"
#import "Weather.h"
#import "WeatherAPI.h"
#import "UserLocation.h"
#import "Forecast.h"

@interface ForecastStore ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ForecastStore

- (instancetype)init{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (Forecast *)getForecastFromFiveDayForecastFetchWithLocation:(UserLocation *)location {
    NSURL *fiveDayURL = [WeatherAPI fiveDayWeatherURLForLocation:location];
    
    __block Forecast *forecast;
    NSURLRequest *request = [NSURLRequest requestWithURL:fiveDayURL];
    NSLog(@"%@",fiveDayURL);
    NSURLSessionDataTask *task =
        [self.session dataTaskWithRequest:request
                        completionHandler:^(NSData *data,
                                            NSURLResponse *response,
                                            NSError *error) {
                            if (data) {
                                forecast = [WeatherAPI forecastFromJSONData:data];
                                
                                NSLog(@"forecast set");
                                
                                NSLog(@"count: %lu",(unsigned long)forecast.weatherArray.count);
                                
                                for (Weather *weather in forecast.weatherArray) {
                                    NSLog(@"Rain: %f, Cloud: %ld, Humidity: %f, Temperature: %f",
                                          weather.rain,weather.clouds,weather.humidity,weather.temperature);
                                }
                            } else NSLog(@"Failed to fetch data. Error: %@", error.localizedDescription);
                        }];
    [task resume];
    return forecast;
}

@end
