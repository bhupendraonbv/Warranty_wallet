//
//  WTRegisteredAMCViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 08/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WTRegisteredAMCViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TopviewDelegate {

     var topview:TopViewController!
     var userDefault = UserDefaults.standard
     var user_id = String()
     var UserToken = String()
     var dict = String()
     var mainArr = NSMutableArray()
     var allDictValue = NSDictionary()
    
    @IBOutlet weak var tblAMCList: UITableView!
    
    var arrlisting : NSMutableArray!
    
    var arrTagName = NSMutableArray()
    var arrPurchsDate = NSMutableArray()
    var arrExpiryDate = NSMutableArray()
    var arrSerial = NSMutableArray()
    var arrModel  = NSMutableArray()
    var ArrAplinc_iD = NSMutableArray()
    var strAMCPassAplnc_ID = String()
    var bottomView:BottomViewViewController!
    
    var spinnerActivity: MBProgressHUD = MBProgressHUD()
    var strDeleteID = String()
    
    
    @IBOutlet weak var btnFull: UIButton!
    @IBOutlet weak var thankVW: UIView!
    @IBOutlet weak var cnclPOP : UIButton!

    @IBAction func dismissVW(sender: AnyObject)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Tbl AMC
         self.tblAMCList.register(UINib(nibName: "CstmRegsAmcCell", bundle: nil), forCellReuseIdentifier: "CstmRegsAmcCell")
        
        arrlisting = ["My Mac","Office Laptop","Washing Machine","My Lap"]
        self.tblAMCList.emptyCellsEnabledAMC = false

        addBottomView()
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        addTopView()
        doPostRegisteredAMCApi()
    
    }
    
    //Top View
    func addTopView(){
        
        topview = TopViewController(title: "Saved Contracts", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    
    }
    
    //Bottom View
    func addBottomView(){
        bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnDash.isSelected = true
        self.view.addSubview(bottomView.view)
    }

    /*do postcategory list*/
    func doPostRegisteredAMCApi()
    {
        
        self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        self.spinnerActivity.label.text = "Loading..."
        
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_APPLIANCES_AMCLIST_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))"
        print("Userid&usertoken--->",postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){data, response, error in
            guard error == nil && data != nil else{
                print("error")
                DispatchQueue.main.async(execute: {() -> Void in                                                                           MBProgressHUD.hide(for: self.view!, animated: true)
                })
                self.displayAlertMessagae(userMessage: "No Internet connection.")
                
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                
                if httpStatus.statusCode == 0
                {
                    print("user alredy regestiter")
                }
            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            do
            {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary else{
                    return
                }
                
                if let dictFromJSON = json as? [String:AnyObject] {
                    
                    print(dictFromJSON)
                    
                    DispatchQueue.main.async(execute: {() -> Void in                                                                           MBProgressHUD.hide(for: self.view!, animated: true)
                    })
                    
                    self.dict = (dictFromJSON["status"] as? String)!
                    print("hfuwfhwq",self.dict)
                    
                    if (self.dict == "1")
                    {
                        //arrCategoryList
                        self.mainArr = NSMutableArray()
                        self.mainArr = (dictFromJSON["data"] as? NSMutableArray)!
                        print(self.mainArr)
                        
                        for storedict in 0..<self.mainArr.count
                        {
                            
                            self.allDictValue = self.mainArr[storedict] as! NSDictionary
                            print(self.allDictValue)
                            
                            self.arrTagName.addObjects(from: [self.allDictValue.value(forKey: "amc_tag_name")!])
                            
                            self.arrPurchsDate.addObjects(from: [self.allDictValue.value(forKey: "amc_date_of_parched")!])
                             self.arrSerial.addObjects(from: [self.allDictValue.value(forKey: "amc_provider_name")!])
                             //self.arrModel.addObjects(from: [self.allDictValue.value(forKey: "amc_model")!])
                            //self.ArrAplinc_iD.addObjects(from: [self.allDictValue.value(forKey: "appliance_id")!])
                            self.ArrAplinc_iD.addObjects(from: [self.allDictValue.value(forKey: "amc_id")!])
                            self.arrExpiryDate.addObjects(from: [self.allDictValue.value(forKey: "amc_expiry_date")!])
                        
                        }
                        
                        DispatchQueue.main.async(execute: {
                            self.tblAMCList.isHidden = false
                            self.tblAMCList.delegate = self
                            self.tblAMCList.dataSource = self
                            self.tblAMCList .reloadData()
                        })
                    }else{
                        DispatchQueue.main.async {
                            self.tblAMCList.isHidden = true
                            self.btnFull.isHidden = false
                            self.thankVW.isHidden = false
                        }
                        
                    }
                    
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
        
    }
    
    @IBAction func cnclPopUPcrosbtn(sender: AnyObject) {
        
        thankVW.isHidden = true
        btnFull.isHidden = true
     
        /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ScanInvoiceViewController") as! ScanInvoiceViewController
        //self.navigationController?.pushViewController(newViewController, animated: true)
        //self.present(newViewController, animated: true, completion: nil)
        AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)*/
    }
    
    
    @IBAction func GOTOScanView(sender: AnyObject) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ScanInvoiceViewController") as! ScanInvoiceViewController
        //self.navigationController?.pushViewController(newViewController, animated: true)
        //self.present(newViewController, animated: true, completion: nil)
        AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
    }
    
    
    
    
    //Alert Message
    func displayAlertMessagae(userMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    //Back Button Click..
    @IBAction func backclick(sender: AnyObject)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.mainArr.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier: String = "CstmRegsAmcCell"
        var customCell : CstmRegsAmcCell!
        customCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CstmRegsAmcCell
        
        customCell.selectionStyle = UITableViewCellSelectionStyle.none
        //customCell.setCollectionViewDataSourceDelegate(indexPath)
       
        customCell.lblPrdctName.text = arrTagName.object(at: indexPath.row) as? String
        //customCell.lblRegisAMC.text = arrModel.object(at: indexPath.row) as? String
        customCell.lblSerial.text = arrSerial.object(at: indexPath.row) as? String
        customCell.lblDate.text = arrPurchsDate.object(at: indexPath.row) as? String
        customCell.lblExpiryDate.text = arrExpiryDate.object(at: indexPath.row) as? String
       
        customCell.btnDelete.tag = indexPath.row
        customCell.btnDelete.addTarget(self, action: #selector(AppliancesViewController.btnDeleteClicked), for: .touchUpInside)
        
        let imageName = allDictValue.value(forKey: "amc_logo") as? String
        //let image = UIImage(named: imageName!)
    
        customCell.icnImg.setImageFromURlAMC(stringImageUrl: imageName!)
        
        return customCell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      //Comment Few Time 
         strAMCPassAplnc_ID = ArrAplinc_iD.object(at: indexPath.row) as! String
        print(strAMCPassAplnc_ID)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RegAMCDetailsView") as! RegAMCDetailsView
        newViewController.strRecvAplnc_ID = strAMCPassAplnc_ID
        self.navigationController?.pushViewController(newViewController, animated: true)
   
    }
    
    
    //Delete Click Action....
    func btnDeleteClicked(sender : UIButton) {
        
        var refreshAlert = UIAlertController(title: "", message: "Are you sure to delete this Appliance.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            let btnTag = sender.tag
            print(btnTag)
            
            self.strDeleteID  = self.ArrAplinc_iD.object(at: btnTag) as! String
            print(self.strDeleteID)
            
            self.POST_DELETE_API()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    //Delete Api Here code.....
    @objc func POST_DELETE_API()
    {
        
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_DELETE_AMCs_LIST_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "Authorization")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "Access_Token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&amcId=\(String(describing: strDeleteID))"
        print("Userid&usertoken--->",postString)
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){data, response, error in
            guard error == nil && data != nil else{
                print("error")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                
                if httpStatus.statusCode == 0
                {
                    print("user alredy regestiter")
                }
            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            do
            {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary else{
                    return
                }
                
                if let dictFromJSON = json as? [String:AnyObject] {
                    print(dictFromJSON)
                    
                    self.dict = (dictFromJSON["status"] as? String)!
                    print("status",self.dict)
                    
                    if (self.dict == "1")
                    {
                        // self.mainArr .removeObject(at: sender.tag)
                        DispatchQueue.main.async {
                            self.tblAMCList .reloadData()
                            
                            self.doPostRegisteredAMCApi()
                        }
                    }else
                    {
                        
                    }
                    
                }
                
            }catch
            {
                print("error")
                self.displayAlertMessagae(userMessage: "Error!")
            }
            
        }
        
        task.resume()
        
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


extension UIImageView{
    
    func setImageFromURlAMC(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}


extension UITableView {
    
    var emptyCellsEnabledAMC: Bool {
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

