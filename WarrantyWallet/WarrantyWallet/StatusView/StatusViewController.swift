//
//  StatusViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 31/05/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController,TopviewDelegate {

    var topview:TopViewController!
    var bottomView = BottomViewViewController()
    @IBOutlet weak var vwGrdntBG : UIView!
    
    @IBOutlet weak var btnCncl : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         addTopView()
        addBottomView()
        setGradientBackground()
        
        
        btnCncl.layer.borderWidth = 1.0
        btnCncl.layer.cornerRadius = 16
        
        btnCncl.layer.borderColor = UIColor (colorLiteralRed: 60/255, green: 79/255, blue: 95/255, alpha: 1.0).cgColor

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Topview code here.
    func addTopView(){
        topview = TopViewController(title: "Request Status", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        //topview.topBGVW.backgroundColor = UIColor .clear
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        topview.topBGVW.backgroundColor = UIColor .clear
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
        
    }
    
    //Gradient Method here...
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 84.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 128.0/255.0, green: 209.0/255.0, blue: 199.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.vwGrdntBG.bounds
        
        self.vwGrdntBG.layer.addSublayer(gradientLayer)
        
    }
    
    //Bottomview code here..
    func addBottomView(){
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.view.addSubview(bottomView.view)
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
