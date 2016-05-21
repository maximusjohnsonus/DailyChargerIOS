//
//  Settings.m
//  The Daily Charger
//

#import "Settings.h"
#import "KeyDefinitions.h"
#import "SWRevealViewController.h"
#import "CustomMethods.h"

@interface Settings ()

@end

@implementation Settings

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.timeSwitch setOn:[CustomMethods use24HourTime]];
    [self.weekendSwitch setOn:[CustomMethods showWeekends]];
    [self.notesSwitch setOn:[CustomMethods enableNotes]];

    //Set up side bar
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)notesSwitchChange:(UISwitch *)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:sender.isOn forKey:KEY_NOTES];
    
    [userDefaults synchronize];
}
- (IBAction)weekendSwitchChange:(UISwitch *)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:sender.isOn forKey:KEY_WEEKEND];
    
    [userDefaults synchronize];
}
- (IBAction)timeSwitchChange:(UISwitch *)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:sender.isOn forKey:KEY_TIME24];
    
    [userDefaults synchronize];
}
@end
