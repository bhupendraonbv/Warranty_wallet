//
//  WTSettingViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 23/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WTSettingViewController: UIViewController,TopviewDelegate {

    var topview:TopViewController!
    var bottomView = BottomViewViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    addTopView()
    addBottomView()
    
    }
    
    
    
    //Bottomview code here..
    func addBottomView(){
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.view.addSubview(bottomView.view)
    }
    
    func addTopView(){
        topview = TopViewController(title: "Settings", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70)
        
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
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
