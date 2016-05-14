//
//  Settings.h
//  The Daily Charger
//
//  Created by Miranda Durham on 9/7/15.
//  Copyright (c) 2015 dOOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Settings : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UISwitch *notesSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *weekendSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *timeSwitch;

- (IBAction)notesSwitchChange:(UISwitch *)sender;
- (IBAction)weekendSwitchChange:(UISwitch *)sender;
- (IBAction)timeSwitchChange:(UISwitch *)sender;
@end
