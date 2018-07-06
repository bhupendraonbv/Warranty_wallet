//
//  WtExpiredListController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 09/02/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WtExpiredListController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIScrollViewDelegate,TopviewDelegate {

    
    @IBOutlet weak var tblExpiredList: UITableView!
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    
    var CommonstrMsg = String()

    var allDictValue = NSDictionary()
    var mainArr = NSMutableArray()
    var strPassAplnc_ID = String()
    var isSearching = false
    
    var arrappliance_name_tag = NSMutableArray()
    var  arrappliance_date_of_parched = NSMutableArray()
    var  arrappliance_expiry_date = NSMutableArray()
    var  arrappliance_model = NSMutableArray()
     var  ArrAplinc_iD = NSMutableArray()
    var  ArrSubCattegry = NSMutableArray()
    
    var strDeleteID = String()
    var strSendApplnvTagName = String()
    var strSendModelApplnc = String()
    var strSendApplncIDtoRaise = String()
    var strRecvCatLocationFromAp = String()
    var bottomView = BottomViewViewController()
    var topview:TopViewController!
    
    
    @IBOutlet weak var btnFull: UIButton!
    @IBOutlet weak var thankVW: UIView!
    
    @IBOutlet weak var cnclPOP : UIButton!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredData:[String] = []

    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.tblExpiredList.register(UINib(nibName: "ExpiredCustomCell", bundle: nil), forCellReuseIdentifier: "ExpiredCustomCell")
        
         searchBar.delegate = self
        tblExpiredList.emptyExpiredCellsEnabled = false
        // Do any additional setup after loading the view.
      
        addTopView()
        addBottomView()
    }
    
    //Top View
    func addTopView(){
        topview = TopViewController(title: "Expired Product & AMCs", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    //Bottom View
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnDash.isSelected = true
        self.view.addSubview(bottomView.view)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
       dopostEXpired_AppliancesListApi()
        
        print(mainArr)
        
        
    }
    
    //Method Name....
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching
        {
            return filteredData.count
        }
        
        return mainArr.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier: String = "ExpiredCustomCell"
        var customCell : ExpiredCustomCell!
        customCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ExpiredCustomCell
        
        
        customCell.selectionStyle = .none
        
        customCell.lblYear?.font = UIFont .systemFont(ofSize: 9)
        customCell.lblYear?.text = arrappliance_date_of_parched.object(at: indexPath.row) as? String
        
        if isSearching
        {
            customCell.productName?.text = filteredData[indexPath.row]as? String //self.applinName
            
        }
        else{
            customCell.productName?.text = arrappliance_name_tag.object(at: indexPath.row) as? String //self.applinName
        }
        
        customCell.purchasedDate?.text = arrappliance_expiry_date.object(at: indexPath.row) as? String
        customCell.modelProduct?.text = arrappliance_model.object(at: indexPath.row) as? String
        customCell.lblSubCat?.text = ArrSubCattegry.object(at: indexPath.row) as? String
        
        //customCell.btnVW.addTarget(self, action: #selector(AppliancesViewController.clickEditViewApplincs), for: .touchUpInside)
        
        customCell.btnDelete.tag = indexPath.row
        customCell.btnDelete.addTarget(self, action: #selector(AppliancesViewController.btnDeleteClicked), for: .touchUpInside)
        
        customCell.btnlogService.tag = indexPath.row
        customCell.btnlogService.addTarget(self, action: #selector(AppliancesViewController.btnLogServiceClicked), for: .touchUpInside)
        
       // customCell.btnVW.tag = indexPath.row
        //customCell.btnVW.addTarget(self, action: #selector(AppliancesViewController.btnVIewClickedServce), for: .touchUpInside)
        
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
    
    
    func btnLogServiceClicked(sender : UIButton) {
        let btnLogServiceTag = sender.tag
        print(btnLogServiceTag)
        
        strSendApplnvTagName  = arrappliance_name_tag.object(at: btnLogServiceTag) as! String
        strSendModelApplnc = arrappliance_model.object(at: btnLogServiceTag) as! String
        strSendApplncIDtoRaise = ArrAplinc_iD.object(at: btnLogServiceTag) as! String
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTRaiseVWController") as! WTRaiseVWController
        newViewController.arrRecvApplncData = mainArr
        newViewController.strRecvApplincName = strSendApplnvTagName
        newViewController.strRecvModelApplnc = strSendModelApplnc
        newViewController.strAplincID = strSendApplncIDtoRaise
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    // Delete Button action..
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
    
    //Api code delete
    @objc func POST_DELETE_API()
    {
        
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_DELETE_Appliance_LIST_API)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&applianceId=\(String(describing: strDeleteID))"
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
                        DispatchQueue.main.async {
                            self.tblExpiredList .reloadData()
                            self.dopostEXpired_AppliancesListApi()
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
    
    
    //Api code here.....
    func dopostEXpired_AppliancesListApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_EXPIRED_Appliances_LIst_API)! as URL)
        let set = CharacterSet()
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))"
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
                 
                    self.CommonstrMsg = (dictFromJSON["msg"] as? String)!
                    
                    if (self.dict == "1")
                    {
                       // self.mainArr = NSMutableArray()
                        if let featured = dictFromJSON["data"] as? NSMutableArray {
                            print("Success")
                            self.mainArr = featured
                            print(self.mainArr)
                            
                        }
                        else {
                            print("Failure")
                           // self.displayAlertMessagae(userMessage: self.CommonstrMsg)

                            self.btnFull.isHidden = false
                            self.thankVW.isHidden = false
                            
                        }
                        
                        for allApplinc in 0..<self.mainArr.count
                        {
                            self.allDictValue = self.mainArr[allApplinc] as! NSDictionary
                            print("self.allDictValue",self.allDictValue.value(forKey: "appliance_name_tag")!)
                            
                            self.arrappliance_name_tag.addObjects(from: [self.allDictValue.value(forKey: "appliance_name_tag")!])
                            print("mylist",self.arrappliance_name_tag)
                            
                            self.arrappliance_date_of_parched.addObjects(from: [self.allDictValue.value(forKey: "appliance_expiry_date")!])
                            
                            self.arrappliance_expiry_date.addObjects(from: [self.allDictValue.value(forKey: "appliance_date_of_parched")!])
                            
                            self.ArrAplinc_iD.addObjects(from: [self.allDictValue.value(forKey: "appliance_id")!])
                            
                            self.arrappliance_model.addObjects(from: [self.allDictValue.value(forKey: "appliances_model")!])
                            
                             self.ArrSubCattegry.addObjects(from: [self.allDictValue.value(forKey: "appliance_subCategory")!])
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.tblExpiredList.delegate = self
                            self.tblExpiredList.dataSource = self
                            self.tblExpiredList .reloadData()
                            
                        }
                        
                        self.self.filteredData = self.arrappliance_name_tag as! [String]
                        print("SaveAllDataInsearcArr",self.filteredData)
                        
                    }else
                    {
                        print (" status 0")
                        //self.CommonstrMsg = (dictFromJSON["msg"] as? String)!
                      //  self.displayAlertMessagae(userMessage: self.CommonstrMsg)
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
    
    @IBAction func cnclPopUPcrosbtn(sender: AnyObject) {
        
        thankVW.isHidden = true
        btnFull.isHidden = true
        
    }
    
    
    @IBAction func GOTOScanView(sender: AnyObject) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ScanInvoiceViewController") as! ScanInvoiceViewController
        
        AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /* if searchBar.text == nil || searchBar.text == ""{
         isSearching = false
         view.endEditing(true)
         tblAppliancesList.reloadData()
         }else {
         isSearching = true
         filteredData = arrappliance_name_tag.filter(using: {searchBar.text})
         
         }*/
        
        if searchText.characters.count == 0 {
            isSearching = false;
            self.tblExpiredList.reloadData()
        } else {
            filteredData = arrappliance_name_tag.filter({ (text) -> Bool in
                let tmp: NSString = text as! NSString
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            }) as! [String]
            if(filteredData.count == 0){
                isSearching = true;         //after Change here and fix issue
            } else {
                isSearching = true;
                print("afterSearchArray",filteredData)
            }
            self.tblExpiredList.reloadData()
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    
    /*Generic Alert view functionality */
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
    
    var emptyExpiredCellsEnabled: Bool {
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

