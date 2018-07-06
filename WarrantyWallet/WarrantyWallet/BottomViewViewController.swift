//
//  BottomViewViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 10/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit


@objc protocol BottomDelegate{
    
}
class BottomViewViewController: UIViewController {

    @IBOutlet weak var btnDash : UIButton!
    @IBOutlet weak var btnAddAplinc : UIButton!
    @IBOutlet weak var btnApplinc : UIButton!
    @IBOutlet weak var btnServc : UIButton!
    
    //bottom lbl declare here
    @IBOutlet weak var lblDash : UILabel!
    @IBOutlet weak var lblAddAplinc : UILabel!
    @IBOutlet weak var lblApplinc : UILabel!
    @IBOutlet weak var lblServc : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Do any additional setup after loading the view.
    
    }
 
    @IBAction func clickToDash(_ sender: AnyObject) {
      print("Dashboard")
      // AppDelegateInstance.rootNavigationController.popToRootViewController(animated: true)
    
        //AppDelegateInstance.rootNavigationController.popViewController(animated: true)
       
        
        DashBrdViewController.createHomeViewController()
    }
    
    @IBAction func clickToAddApplinc(_ sender: AnyObject) {
      print("Add Appliances")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ScanInvoiceViewController") as! ScanInvoiceViewController
        //self.navigationController?.pushViewController(newViewController, animated: true)
       //self.present(newViewController, animated: true, completion: nil)
        
        AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func clickToApplinc(_ sender: AnyObject) {
      print("Appliances")
        
        /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppliancesViewController") as! AppliancesViewController
        AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)*/
    
    // For Category Listing
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WtApplianceCategListViewController") as! WtApplianceCategListViewController
       
        AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
    
    }
  
    @IBAction func clickToService(_ sender: AnyObject) {
      print("WTCheckStatusViewController")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTCheckStatusViewController") as! WTCheckStatusViewController
        AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
    
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
