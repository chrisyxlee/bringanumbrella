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

- (Forecast *)forecastFromFiveDayForecastAt:(UserLocation *)location {
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

- (void)forecastForTodayAt:(UserLocation *)location {
    NSURL *fiveDayURL = [WeatherAPI fiveDayWeatherURLForLocation:location];
    
    __weak ForecastStore *weakSelf = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:fiveDayURL];
    NSLog(@"%@",fiveDayURL);
    NSURLSessionDataTask *task =
    [self.session dataTaskWithRequest:request
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
                        if (data) {
                            Forecast *forecast = [WeatherAPI forecastFromJSONData:data];
                            NSLog(@"blah forecast == nil %@", forecast == nil ? @"true":@"false");
                            NSLog(@"count: %lu",(unsigned long)forecast.weatherArray.count);
                            
                            //getting time for 6am next morning
                            NSDate *now = [NSDate date];
                            NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
                            now = [now dateByAddingTimeInterval:timeZone.secondsFromGMT];
                            
                            NSDateComponents* tomorrowComponents = [NSDateComponents new];
                            tomorrowComponents.day = 1 ;
                            NSCalendar* calendar = [NSCalendar currentCalendar] ;
                            NSDate* tomorrow = [calendar dateByAddingComponents:tomorrowComponents toDate:now options:0] ;
                            
                            NSDateComponents* tomorrowAt6AMComponents = [calendar components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:tomorrow] ;
                            [tomorrowAt6AMComponents setHour:6];
                            NSDate* tomorrowAt6AM = [calendar dateFromComponents:tomorrowAt6AMComponents];
                            tomorrowAt6AM = [tomorrowAt6AM dateByAddingTimeInterval:timeZone.secondsFromGMT]; //time zone fix

                            for (int i = 0; i < forecast.weatherArray.count; i++) {
                                Weather *weather = forecast.weatherArray[i];
                                int seconds = [weather.date timeIntervalSinceDate:tomorrowAt6AM];
                                if (seconds > (20 * 60 * 60) || seconds < 0) {
                                    [forecast.weatherArray removeObjectIdenticalTo:weather];
                                } else NSLog(@"Rain: %f, Cloud: %ld, Humidity: %f, Temperature: %f, Date: %@",
                                             weather.rain,weather.clouds,weather.humidity,weather.temperature, weather.date);

                            }
                            NSLog(@"%lu weathers",[forecast.weatherArray count]);
                            weakSelf.forecast = forecast;
                            NSLog(@"weakself forecast == nil %@", forecast == nil ? @"true" : @"false");
                        } else NSLog(@"Failed to fetch data. Error: %@", error.localizedDescription);
                    }];
    [task resume];
}

@end
