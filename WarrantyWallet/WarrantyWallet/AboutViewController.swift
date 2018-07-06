//
//  AboutViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 05/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController,TopviewDelegate {

    var topview:TopViewController!
    var bottomView = BottomViewViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTopView()
        addBottomView()
        
        // Do any additional setup after loading the view.
    }
    
    //Bottomview code here..
    func addBottomView(){
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        bottomView.view.backgroundColor = UIColor.white
        self.view.addSubview(bottomView.view)

    }

    //Topview code here.
    func addTopView(){
        topview = TopViewController(title: "About Us", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  //Backbutto action
    @IBAction func backclick(sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: LEFT MENU NAVIGATION CLASS
    class func createHomeViewController() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let leftCntrl = storyBoard.instantiateViewController(withIdentifier: "WTMenuViewController") as! WTMenuViewController
        let rightCntrl = storyBoard.instantiateViewController(withIdentifier: "WTMenuViewController") as! WTMenuViewController
        let centerCntrl = storyBoard.instantiateViewController(withIdentifier: "AboutViewController")  as! AboutViewController
        AppDelegateInstance.drawerController.showsShadow = false
        AppDelegateInstance.drawerController.centerHiddenInteractionMode = .none
        AppDelegateInstance.drawerController.leftDrawerViewController = leftCntrl
        AppDelegateInstance.drawerController.centerViewController = centerCntrl
        AppDelegateInstance.drawerController.rightDrawerViewController = rightCntrl
        AppDelegateInstance.drawerController.closeDrawerGestureModeMask = .all
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: WINDOW_WIDTH, height: WINDOW_HEIGHT))
        layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
        layer.tag = -1
        
        AppDelegateInstance.drawerController.setDrawerVisualStateBlock { (controller: MMDrawerController!, drawerSide: MMDrawerSide, percentOpen: CGFloat) -> Void in
            if !controller.centerViewController.view.subviews.contains(layer) {
                controller.centerViewController.view.addSubview(layer)
            }
            if percentOpen == 0.0 {
                layer.removeFromSuperview()
            }
        }
        
        AppDelegateInstance.drawerController.setMaximumLeftDrawerWidth(280, animated: true, completion: nil)
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
