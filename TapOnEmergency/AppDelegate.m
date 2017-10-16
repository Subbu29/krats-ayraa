//
//  AppDelegate.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 04/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "AppDelegate.h"
#import "TOEConstants.h"

@import GoogleMaps;
@import GooglePlaces;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    NSUserDefaults *userStoredData  = [NSUserDefaults standardUserDefaults];
    NSString *isUserAuthanticated = [userStoredData objectForKey:USER_ACCESS_TOKEN];
     [userStoredData setObject:@"NO" forKey:IS_EMERGENCY];
    
    
    [GMSServices provideAPIKey:@"AIzaSyB5scIvoa4C8y3z1HE46zcSzVWT38OR8_w"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyB5scIvoa4C8y3z1HE46zcSzVWT38OR8_w"];
    
    if (isUserAuthanticated != nil && isUserAuthanticated.length>0) {
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    }
    else
    {
        [userStoredData removeObjectForKey:USER_STORED_DATA];
        [userStoredData removeObjectForKey:USER_ACCESS_TOKEN];
        
        UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
        self.window.rootViewController = navigation;
    }
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil]];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *deviceTokenString = [deviceToken description];
    deviceTokenString = [deviceTokenString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceTokenString = [deviceTokenString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",deviceTokenString);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
