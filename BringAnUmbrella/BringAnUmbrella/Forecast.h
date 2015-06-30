//
//  Forecast.h
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Forecast : NSObject

@property (nonatomic, strong) NSMutableArray *weatherArray;

- (instancetype)initWithForecast:(NSArray *)forecast NS_DESIGNATED_INITIALIZER;

@end
