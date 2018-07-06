
//  AppDelegate.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 26/09/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

import Google
import GoogleSignIn



let AppDelegateInstance = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    /*func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
       
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user?.profile.email
            
            
            //userToken = UserDefaults.standard.string(forKey: "UserToken")
             var UserDefault = UserDefaults.standard
             UserDefault.setValue(idToken, forKey: "UserToken")
            
           // UserEmail.setValue(textfieldEmail.text, forKey: "RememberName")
            UserDefault.synchronize()//user_email
            
            // Redirect to home page.
            let dashvwController = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "DashBrdViewController")
            rootNavigationController = navViewController(rootViewController: dashvwController)
            rootNavigationController.isNavigationBarHidden = true
            DashBrdViewController.createHomeViewController()
            self.window?.rootViewController = rootNavigationController
            
            
        }
        
        print("Successfully logged into Google", user)
    }*/
    
    var window: UIWindow?
    var accessToken : String!
    var userToken:String!
    var drawerController = MMDrawerController()
    var rootNavigationController: navViewController!
    //var dashvwController1 = DashBrdViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /*let defaults = UserDefaults.standard
        defaults.set(userSessionToken, forKey: "session_token")
        print("userdefault",defaults.set(userSessionToken, forKey: "session_token"))
        print(SessionToken)*/
        
        UIApplication.shared.statusBarStyle = .lightContent

        accessToken = UserDefaults.standard.string(forKey: "session_token")
        print(accessToken)
        
        /*if accessToken != nil
        {
            let dashvwController = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "DashBrdViewController")
            rootNavigationController = navViewController(rootViewController: dashvwController)
            rootNavigationController.isNavigationBarHidden = true
            DashBrdViewController.createHomeViewController()
            self.window?.rootViewController = rootNavigationController
        }*/
        
        userToken = UserDefaults.standard.string(forKey: "UserToken")
        
        if accessToken != nil{
            /*let dashvwController = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "DashBrdViewController")
            rootNavigationController = navViewController(rootViewController: dashvwController)
            rootNavigationController.isNavigationBarHidden = true
            DashBrdViewController.createHomeViewController()
            self.window?.rootViewController = rootNavigationController*/
            
            let dashvwController = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "ScanInvoiceViewController")
            rootNavigationController = navViewController(rootViewController: dashvwController)
            rootNavigationController.isNavigationBarHidden = true
            self.window?.rootViewController = rootNavigationController
        }
            
        else if userToken != nil
        {
            let dashvwController = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "DashBrdViewController")
            rootNavigationController = navViewController(rootViewController: dashvwController)
            rootNavigationController.isNavigationBarHidden = true
            DashBrdViewController.createHomeViewController()
            self.window?.rootViewController = rootNavigationController
        }
        else
        {
            //Coment for Walkthoriugh screen
            /*let homeScreenViewController = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "ViewController")
            rootNavigationController = navViewController(rootViewController: homeScreenViewController)
            rootNavigationController.isNavigationBarHidden = true
            self.window?.rootViewController = rootNavigationController*/
            

            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WalkThroughViewController") as! WalkThroughViewController
            rootNavigationController = navViewController(rootViewController: newViewController)
            rootNavigationController.isNavigationBarHidden = true
            self.window?.rootViewController = rootNavigationController
        }
        
        Thread.sleep(forTimeInterval: 3.0)
        print("userToken",userToken)
        print("access",accessToken)
        
        /*var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")*/
       // GIDSignIn.sharedInstance().delegate = self as! GIDSignInDelegate

        
        // MARK: - Appearance
        
        if #available(iOS 9.0, *) {
            
            // Apply styles for text fields contained in AppearanceViewController
            let styles = SkyFloatingLabelTextField.appearance(
               // whenContainedInInstancesOf: [AppearanceViewController.self]
            )
            
            // Text-, placeholder- and tintcolor
            styles.textColor          = .gray
            styles.tintColor          = .gray
            styles.placeholderColor   = .gray
            styles.selectedTitleColor = .gray
            styles.errorColor         = .purple
            
            // Fonts
            #if swift(>=4.0)
               // styles.font               = .systemFont(ofSize: 17, weight: UIFont.Weight(rawValue: 1.0))
              //  styles.placeholderFont    = .systemFont(ofSize: 17, weight: UIFont.Weight(0.1))
            #else
              //  styles.font               = .systemFont(ofSize: 17, weight: 1.0)
             //   styles.placeholderFont    = .systemFont(ofSize: 17, weight: 0.1)
            #endif
            
            // Line
            styles.lineHeight = 0
            styles.lineColor          = .brown
            
            // Selected line
            styles.selectedLineHeight = 0
            styles.selectedLineColor  = .orange
        }
        
        // MARK: - Icon appearance
        
        if #available(iOS 9.0, *) {
            
            // Apply icon styles
            let iconStyles = SkyFloatingLabelTextFieldWithIcon.appearance(
              //  whenContainedInInstancesOf: [AppearanceViewController.self]
            )
            
            // Icon colors
            iconStyles.iconColor          = .brown
            iconStyles.selectedIconColor  = .orange
            
            // Icon font
           // iconStyles.iconFont = UIFont(name: "FontAwesome", size: 15)
            
            // Icon margins
            iconStyles.iconMarginLeft = 0
            iconStyles.iconMarginBottom = 0
        }
        
        
        registerForPushNotifications()

        return true
    }

   
    
    /*func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
    }*/
    
    /*func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("Failed to log into Google: ", err)
            return
        }
        
        print("Successfully logged into Google", user)
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }*/
    
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    //Notification Methd........
    
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
        
            DispatchQueue.main.async(execute: {
                UIApplication.shared.registerForRemoteNotifications()
            })
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        /*let tokenParts = deviceToken.map { data -> String in
            print(data)
            return String(format: "%02.2hhx", data)
        }*/
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
      //  let token = tokenParts.joined()
      //  print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    /*func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "653639818409-kku4nl74t0gfnfu2pgo2rqnopl51d94v.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self as! GIDSignInDelegate
        
        return true
    }*/
    
   /* func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            // ...
        } else {
            println("\(error.localizedDescription)")
        }
    }*/
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "WarrantyWallet")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

