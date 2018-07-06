//
//  SplashViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 22/12/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    var accessToken : String!
    var userToken:String!
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    Thread.sleep(forTimeInterval: 3.0)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
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
            AppDelegateInstance.rootNavigationController = navViewController(rootViewController: dashvwController)
            AppDelegateInstance.rootNavigationController.isNavigationBarHidden = true
            self.window?.rootViewController = AppDelegateInstance.rootNavigationController
        }
            
        else if userToken != nil
        {
            let dashvwController = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "DashBrdViewController")
            AppDelegateInstance.rootNavigationController = navViewController(rootViewController: dashvwController)
            AppDelegateInstance.rootNavigationController.isNavigationBarHidden = true
            DashBrdViewController.createHomeViewController()
            //self.window?.rootViewController = AppDelegateInstance.rootNavigationController
         // self.navigationController?.pushViewController(dashvwController, animated: true)
            AppDelegateInstance.rootNavigationController.pushViewController(dashvwController, animated: true)
            
        }
        else
        {
            let homeScreenViewController = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "ViewController")
            AppDelegateInstance.rootNavigationController = navViewController(rootViewController: homeScreenViewController)
            AppDelegateInstance.rootNavigationController.isNavigationBarHidden = true
            self.window?.rootViewController = AppDelegateInstance.rootNavigationController
        }
        

        print("userToken",userToken)
        print("access",accessToken)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
