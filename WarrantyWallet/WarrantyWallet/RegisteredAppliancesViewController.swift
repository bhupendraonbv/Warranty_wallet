//
//  RegisteredAppliancesViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 13/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class RegisteredAppliancesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*Veryfy OTP Method*/
    @IBAction func GoToAbout(sender: AnyObject)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    
    }
    
    //PushDetails Appliances
    @IBAction func DetailsAppliances(sender: AnyObject)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppliancesViewController") as! AppliancesViewController
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
