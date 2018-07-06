//
//  SliderBaseViewViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 16/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class SliderBaseViewViewController: UIViewController {

    var drawerr:MMDrawerController?;
    var appObj:AppDelegate?;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDrawerController(_ controller:UIViewController){
        appObj = UIApplication.shared.delegate as? AppDelegate
        let drawer = MMDrawerController();
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let leftCntrl = storyBoard.instantiateViewController(withIdentifier: "WTMenuViewController") as! WTMenuViewController
        
        leftCntrl.cntrl = drawer;
        //let centerCntrl = GPHomeView(nibName: "GPHomeView", bundle: nil);
        // appObj!.isSubscribeView = false;
        drawer.leftDrawerViewController = leftCntrl;
        // drawer.centerViewController = centerCntrl;
        drawer.centerHiddenInteractionMode = MMDrawerOpenCenterInteractionMode.full;
        //        appObj?.drawerr = drawer;
        //        controller.navigationController?.pushViewController((appObj?.drawerr)!, animated:true)
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
