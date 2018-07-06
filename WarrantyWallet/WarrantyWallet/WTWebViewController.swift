//
//  WTWebViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 28/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WTWebViewController: UIViewController,UIWebViewDelegate,TopviewDelegate {

    
    @IBOutlet weak var webView: UIWebView!
    var topview:TopViewController!
    var webStrUrlGet = String()
    var RecvStrHdrTitle = String()
    @IBOutlet weak var lblHdr = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: webStrUrlGet)
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
        
        lblHdr?.text = RecvStrHdrTitle
        
       // self.addTopView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTopView(){
        topview = TopViewController(title: RecvStrHdrTitle, menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }

    @IBAction func clicktoDismiss(sender: AnyObject)
    {
        dismiss(animated: true, completion: nil)

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
