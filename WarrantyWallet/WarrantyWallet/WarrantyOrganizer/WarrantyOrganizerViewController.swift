//
//  WarrantyOrganizerViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 25/05/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WarrantyOrganizerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func LOGINBTn(sender: AnyObject) {
        /*let homeScreenViewController = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "ViewController")
         rootNavigationController = navViewController(rootViewController: homeScreenViewController)
         rootNavigationController.isNavigationBarHidden = true
         self.window?.rootViewController = rootNavigationController*/
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func SIGNUPIN(sender: AnyObject) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpPage") as! SignUpPage
        self.navigationController?.pushViewController(newViewController, animated: true)
    
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
