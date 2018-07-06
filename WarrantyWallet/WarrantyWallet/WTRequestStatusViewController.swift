//
//  WTRequestStatusViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 09/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WTRequestStatusViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,TopviewDelegate {

    var topview:TopViewController!
    @IBOutlet weak var tblAMCList: UITableView!
    var bottomView = BottomViewViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTopView()
        
        tblAMCList.delegate = self
        tblAMCList.dataSource = self
        
        tblAMCList.backgroundColor = UIColor .clear
        
        self.tblAMCList.register(UINib(nibName: "CustmRequestCell", bundle: nil), forCellReuseIdentifier: "CustmRequestCell")
        
        //arrlisting = ["My Mac","Office Laptop","Washing Machine","My Lap"]
        // Do any additional setup after loading the view.
      
        tblAMCList.emptyTblCellsEnabled = false
         addTopView()
         addBottomView()
   
    }

    
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnServc.isSelected = true
        self.view.addSubview(bottomView.view)
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Table view delegate and data source method.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 112
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier: String = "CustmRequestCell"
        var customCell : CustmRequestCell!
        customCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CustmRequestCell
        
        return customCell
        
    }
    
    func addTopView(){
        topview = TopViewController(title: "Request Status", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
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

extension UITableView {
    
    var emptyTblCellsEnabled: Bool {
        set(newValue) {
            if newValue {
                tableFooterView = nil
            } else {
                tableFooterView = UIView()
            }
            
        }
        get {
            if tableFooterView == nil {
                return true
            }
            return false
        }
    }
}

