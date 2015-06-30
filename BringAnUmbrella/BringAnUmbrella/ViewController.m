//
//  ViewController.m
//  BringAnUmbrella
//
//  Created by Christine Lee on 6/29/15.
//  Copyright (c) 2015 Christine Lee. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    
    //STEP 1 Construct Panels
    MYIntroductionPanel *panel = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"Umbrella_icon"] title:@"Bring an Umbrella" description:@"Ready to never have to worrying about remembering your umbrella an again?" ];
    
    //You may also add in a title for each panel
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"Umbrella_icon"] title:@"Enable GPS" description:@"If you don't let Bring an Umbrella Access GPS, we won't be able to predict rain in your region!"];
    
    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"Umbrella_icon"] title:@"Enable Notifications" description:@"Its literally all this app does"];
    
    MYIntroductionPanel *panel4 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"Umbrella_icon"] title:@"We've got you covered" description:@"Great! From now on you'll get a notification whenever percipitation is coming your way"];
    
    //STEP 2 Create IntroductionView
    /*A standard version*/
    //MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) headerImage:[UIImage imageNamed:@"SampleHeaderImage.png"] panels:@[panel, panel2]];
    
    /*A version with no header (ala "Path")*/
    // MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) panels:@[panel, panel2]];
    
    /*A more customized version*/
    MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) headerText:@"MYIntroductionView" panels:@[panel, panel2, panel3, panel4] languageDirection:MYLanguageDirectionLeftToRight];
    [introductionView setBackgroundImage:[UIImage imageNamed:@"SampleBackground"]];
    
    /*
     MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) headerText:@"MYIntroductionView" panels:@[panel, panel2] languageDirection:MYLanguageDirectionLeftToRight];
     
     [introductionView setBackgroundColor:[UIColor colorWithRed:37.0/255 green:104.0/255 blue:154.0/255 alpha:1.0]];  */
    
    [introductionView.BackgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [introductionView.HeaderImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [introductionView.HeaderLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [introductionView.HeaderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [introductionView.PageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [introductionView.SkipButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    
    
    
    //Set delegate to self for callbacks (optional)
    introductionView.delegate = self;
    
    //STEP 3: Show introduction view
    [introductionView showInView:self.view animateDuration:0.0];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay: 30];
    [components setMonth: 6];
    [components setYear: 2015];
    [components setHour: 7];
    [components setMinute: 00];
    [components setSecond: 0];
    [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
    NSDate *date = [calendar dateFromComponents:components];
    
    UILocalNotification *note = [[UILocalNotification alloc] init];
    NSData *data = [@"\xF0\x9F\x98\x81" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *goodValue = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
    note.alertBody = @"\u2614 Bring an umbrella";
    NSLog(@"%@",note.alertBody);
    note.fireDate = date;
    [[UIApplication sharedApplication] scheduleLocalNotification:note];

    [note setRepeatInterval: NSCalendarUnitDay];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Sample Delegate Methods

-(void)introductionDidFinishWithType:(MYFinishType)finishType{
    if (finishType == MYFinishTypeSkipButton) {
        NSLog(@"Did Finish Introduction By Skipping It");
    }
    else if (finishType == MYFinishTypeSwipeOut){
        NSLog(@"Did Finish Introduction By Swiping Out");
    }
    
    //One might consider making the introductionview a class variable and releasing it here.
    // I didn't do this to keep things simple for the sake of example.
}

-(void)introductionDidChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
    NSLog(@"%@ \nPanelIndex: %ld", panel.Description, (long)panelIndex);
}

@end