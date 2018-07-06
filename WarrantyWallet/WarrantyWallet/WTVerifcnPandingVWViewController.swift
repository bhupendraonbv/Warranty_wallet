//
//  WTVerifcnPandingVWViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 30/04/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class  WTVerifcnPandingVWViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TopviewDelegate {

    var topview:TopViewController!
    var bottomView:BottomViewViewController!
    
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var mainArr = NSMutableArray()
    var allDictValue = NSDictionary()
    
    var arrTagName = NSMutableArray()
    var arrPurchsDate = NSMutableArray()
    var arrExpiryDate = NSMutableArray()
    var arrSerial = NSMutableArray()
    var arrModel  = NSMutableArray()
    var ArrAplinc_iD = NSMutableArray()
    
    
    var strPassAplnc_ID = String()
    
    
    @IBOutlet weak var tblAMCList: UITableView!
    var spinnerActivity: MBProgressHUD = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.tblAMCList.register(UINib(nibName: "CustomCellVerificationTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCellVerificationTableViewCell")
        
        
        // Do any additional setup after loading the view.
        self.tblAMCList.emptyCellsEnabledPanding = false
    
        addTopView()

        self.addBottomView()

        
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        doPostRegisteredAMCApi()
    }
    
    //Top View here
    func addTopView(){
        
        topview = TopViewController(title: "Products", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
        
    }
    
    //Bottom View here..
    func addBottomView(){
        bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnDash.isSelected = true
        self.view.addSubview(bottomView.view)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainArr.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 138
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier: String = "CustomCellVerificationTableViewCell"
        var customCell : CustomCellVerificationTableViewCell!
        customCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CustomCellVerificationTableViewCell
        
        
        print(arrTagName)
        print(arrSerial)
        print(arrPurchsDate)
        
        
        customCell.selectionStyle = UITableViewCellSelectionStyle.none
        //customCell.setCollectionViewDataSourceDelegate(indexPath)
        
        customCell.lblCatList?.text = arrTagName.object(at: indexPath.row) as? String
        
         customCell.lblSubCat.text! = (arrSerial.object(at: indexPath.row) as? String)!
        customCell.lblDateExp.text! = (arrPurchsDate.object(at: indexPath.row) as? String)!
        customCell.lblTopHdr.text! = (arrModel.object(at: indexPath.row) as? String)!
        
        return customCell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        strPassAplnc_ID = ArrAplinc_iD.object(at: indexPath.row) as! String
        print(strPassAplnc_ID)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ApplianceEditDetailsViewController") as! ApplianceEditDetailsViewController
        newViewController.strRecvAplnc_ID = strPassAplnc_ID
        newViewController.ArrGetAppilncData = mainArr
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    func doPostRegisteredAMCApi()
    {
        
        self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        self.spinnerActivity.label.text = "Loading..."
        
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_VERIFICATION_PENDING_API)! as URL)
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
                            
                            self.arrTagName.addObjects(from: [self.allDictValue.value(forKey: "appliance_subCategory")!])
                           
                            self.ArrAplinc_iD.addObjects(from: [self.allDictValue.value(forKey: "appliance_id")!])

                            self.arrPurchsDate.addObjects(from: [self.allDictValue.value(forKey: "appliance_expiry_date")!])
                            self.arrSerial.addObjects(from: [self.allDictValue.value(forKey: "appliances_model")!])
                            self.arrModel.addObjects(from: [self.allDictValue.value(forKey: "appliance_category")!])
                        
                        
                        
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
                            self.displayAlertMessagae(userMessage: "Verification List is empty.")
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
    
    
    func displayAlertMessagae(userMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
extension UITableView {
    
    var emptyCellsEnabledPanding: Bool {
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

