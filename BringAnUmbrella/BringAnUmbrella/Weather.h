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
@property (nonatomic) NSInteger rain;           //in millimeters
@property (nonatomic) CGFloat temperature;
@property (nonatomic) NSInteger minTemp;
@property (nonatomic) NSInteger maxTemp;
@property (nonatomic) NSInteger clouds;         //percentage out of 100
@property (nonatomic) NSInteger humidity;       //percentage out of 100

- (instancetype)initWithType:(NSString *)type
                 temperature:(CGFloat)temp
                 minimumTemp:(NSInteger)minTemp
                 maximumTemp:(NSInteger)maxTemp
                amountOfRain:(NSInteger)rain
                    humidity:(NSInteger)humidity
                      clouds:(NSInteger)clouds NS_DESIGNATED_INITIALIZER;

@end
