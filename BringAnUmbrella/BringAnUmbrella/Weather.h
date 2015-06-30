//
//  Weather.h
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Weather : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic) float rain;           //in millimeters
@property (nonatomic) float temperature;
@property (nonatomic) float minTemp;
@property (nonatomic) float maxTemp;
@property (nonatomic) NSInteger clouds;     //percentage out of 100
@property (nonatomic) float humidity;       //percentage out of 100

- (instancetype)initWithType:(NSString *)type
                 temperature:(float)temp
                 minimumTemp:(float)minTemp
                 maximumTemp:(float)maxTemp
                amountOfRain:(float)rain
                    humidity:(float)humidity
                      clouds:(NSInteger)clouds NS_DESIGNATED_INITIALIZER;

@end
