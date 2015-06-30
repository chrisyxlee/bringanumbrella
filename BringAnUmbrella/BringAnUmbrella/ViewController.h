//
//  ViewController.h
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYIntroductionView.h"
@class UserLocation;

@interface ViewController : UIViewController <MYIntroductionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UserLocation *location;

@end

