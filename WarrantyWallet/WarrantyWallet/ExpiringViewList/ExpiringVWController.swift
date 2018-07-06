//
//  ExpiringVWController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 12/02/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class ExpiringVWController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIScrollViewDelegate,TopviewDelegate {
   
    @IBOutlet weak var tblExpiringList: UITableView!
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
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredData:[String] = []
    
    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblExpiringList.register(UINib(nibName: "ExpiredCustomCell", bundle: nil), forCellReuseIdentifier: "ExpiredCustomCell")
        
        searchBar.delegate = self
        
        tblExpiringList.emptyExpiringCellsEnabled = false
        
        addTopView()
        addBottomView()
        
        // Do any additional setup after loading the view.
        dopostEXIRINGLIST_AppliancesListApi()
    
    }
    
    //Top view
    func addTopView(){
        topview = TopViewController(title: "Expiring Soon", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        topview.topBGVW.backgroundColor = UIColor .clear
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnDash.isSelected = true
        self.view.addSubview(bottomView.view)
    }
    
    //Tabel Method code here..
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
        
        
        customCell.btnDelete.tag = indexPath.row
        customCell.btnDelete.addTarget(self, action: #selector(AppliancesViewController.btnDeleteClicked), for: .touchUpInside)
        
        customCell.btnlogService.tag = indexPath.row
        customCell.btnlogService.addTarget(self, action: #selector(AppliancesViewController.btnLogServiceClicked), for: .touchUpInside)
        
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
    
    
    //logService click action
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
    
    
    //Delete button action
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
    
    //Api code here ----> Delete Api
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
                        // self.mainArr .removeObject(at: sender.tag)
                        DispatchQueue.main.async {
                            self.tblExpiringList .reloadData()
                            self.dopostEXIRINGLIST_AppliancesListApi()
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
    
    //Api  code here ---> Existing List here .....
    func dopostEXIRINGLIST_AppliancesListApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_EXPIRING_Appliances_LIst_API)! as URL)
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
                    
                    if (self.dict == "1")
                    {
                        // self.mainArr = NSMutableArray()
                        self.mainArr = (dictFromJSON["data"] as? NSMutableArray)!
                        print(self.mainArr)
                        
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
                            self.tblExpiringList.delegate = self
                            self.tblExpiringList.dataSource = self
                            self.tblExpiringList .reloadData()
                            
                        }
                        
                        self.self.filteredData = self.arrappliance_name_tag as! [String]
                        print("SaveAllDataInsearcArr",self.filteredData)
                        
                    }else
                    {
                        print (" status 0")
                        self.CommonstrMsg = (dictFromJSON["msg"] as? String)!
                        self.displayAlertMessagae(userMessage: self.CommonstrMsg)
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
    
    
    //Searchbar method here....
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchText.characters.count == 0 {
            isSearching = false;
            self.tblExpiringList.reloadData()
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
            self.tblExpiringList.reloadData()
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
    
    var emptyExpiringCellsEnabled: Bool {
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
