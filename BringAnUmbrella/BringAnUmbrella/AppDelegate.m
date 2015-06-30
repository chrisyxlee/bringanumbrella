//
//  AppDelegate.m
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import "AppDelegate.h"
#import "UserLocation.h"
#import "WeatherAPI.h"
#import "ViewController.h"
#import "ForecastStore.h"
#import "Weather.h"
#import "Forecast.h"


@interface AppDelegate ()
@property (nonatomic, strong) UserLocation *location;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _location = [[UserLocation alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.viewController setLocation:self.location];
    [self.window makeKeyAndVisible];
    
    
    return YES;
    
}

- (void)setNotification
{
    ForecastStore *forecastStore = [[ForecastStore alloc] init];
    Forecast *forecast = [forecastStore forecastForTodayAt:self.location];
    BOOL willRain = [forecast tomorrowWillRain];
    
    NSDate *now = [NSDate date]; //today's date
    //NSDate *newDate = [now dateByAddingTimeInterval:60*60*24]; //tomorrow's date
    NSDate *newDate = now;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:newDate];
//    [components setHour:11];
//    [components setMinute:51];
//    [components setSecond:0];
//    [components setTimeZone:[NSTimeZone defaultTimeZone]];
    NSDate *someDate = [components date];
    someDate = [someDate dateByAddingTimeInterval:60];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    [localNotification setFireDate: [[NSCalendar currentCalendar] dateFromComponents:components]];
    [localNotification setTimeZone: [NSTimeZone defaultTimeZone]];
    
    if (!willRain) [localNotification setAlertBody:@"It's sunny today. And always will be!"];
    else [localNotification setAlertBody:@"Bring your umbrella!"];
    [localNotification setRepeatInterval: NSCalendarUnitMinute];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    ForecastStore *store = [[ForecastStore alloc] init];
    Forecast *forecast = [store forecastForTodayAt:_location];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
