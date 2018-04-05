//
//  AppDelegate.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 23.02.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import UIKit
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GameAnalytics.configureBuild("alpha 0.1.0")
        GameAnalytics.configureAvailableResourceCurrencies(["Coins"])
        GameAnalytics.configureAvailableResourceItemTypes(["Plane"])
        
        GameAnalytics.initialize(withGameKey:"66373e53bdbe0464d51bc2470e4d3b4a", gameSecret:"57e2efb4e4cc2baa6f24fe302ec183830e6c1685")
        
        UIApplication.shared.isStatusBarHidden = true
        TWTRTwitter.sharedInstance().start(withConsumerKey:"UHmnuRibzDctekY4DpX5T8BQr", consumerSecret:"htuScUEmyqrkNSzFQkADlobmcmSvfGbgFjjfsJc7ywixtxhyxv")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var vc: UIViewController
        
        if (UserDefaults.standard.value(forKey: "onboardingFinished") != nil) {
            vc = storyboard.instantiateInitialViewController()!
        } else {
            vc = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
        }
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

