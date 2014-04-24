//
//  AppDelegate.h
//  Space_Coding_Challenge
//
//  Created by Frans Kurniawan on 4/23/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *viewController;

@end
