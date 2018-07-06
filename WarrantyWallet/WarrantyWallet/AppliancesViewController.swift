//  AppliancesViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 13/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.

import UIKit

class AppliancesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TopviewDelegate,UISearchBarDelegate,UIScrollViewDelegate {

    @IBOutlet weak var tblAppliancesList: UITableView!
    var genricArray:NSMutableArray!
    var  productArray:NSMutableArray!
    var  purchasedDate:NSMutableArray!
    
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    
    var applinName = String()
    var appliance_date_of_parched = String()
    var appliance_expiry_date = String()
    
    var arrappliance_name_tag = NSMutableArray()
    var  arrappliance_date_of_parched = NSMutableArray()
    var  arrappliance_expiry_date = NSMutableArray()
    var  arrappliance_model = NSMutableArray()
    
    var  ArrAplinc_iD = NSMutableArray()
    
    var allDictValue = NSDictionary()
    var mainArr = NSMutableArray()
    var strPassAplnc_ID = String()
    
    var bottomView = BottomViewViewController()
    var topview:TopViewController!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredData:[String] = []
    
    var CommonstrMsg = String()
    
    
    var isSearching = false
    
    var strCatIDApplncList = String()
    
    var strDeleteID = String()
    var strSendApplnvTagName = String()
    var strSendModelApplnc = String()
    var strSendApplncIDtoRaise = String()
    var strRecvCatLocationFromAp = String()
    var ArrSubCattegry = NSMutableArray()
    
 
    @IBOutlet weak var btnFull: UIButton!
    @IBOutlet weak var thankVW: UIView!

    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*Generic Alert view functionality */
    func displayAlertMessagae(userMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
    @IBAction func backclick(sender: AnyObject)
    {
      self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("catIDzFromAppLIt",strCatIDApplncList)
        print("strCatLocation",strRecvCatLocationFromAp)
        
        // Do any additional setup after loading the view.
    self.tblAppliancesList.register(UINib(nibName: "AppliancesCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "AppliancesCustomTableViewCell")
    
          genricArray = ["2015","2016","2017","2017"]
          productArray = ["Living Room AC" , "Living Room TV" , " Living Room Fan" , "Kitchen Fan"]
          purchasedDate = ["Purchased  10/05/2014" ,"Purchased  10/05/2015" ,"Purchased  10/05/2016" ,"Purchased  10/05/2016" ]
        
          tblAppliancesList.emptyCellsEnabled = false
        
          searchBar.delegate = self
         //searchBar.returnKeyType = UIReturnKeyType.done
        
          addTopView()
          addBottomView()
    }
    
    
    //Topview code here..
    func addTopView(){
        
        if strCatIDApplncList.isEmpty
        {
           topview = TopViewController(title: "Registered Products", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        }
        
        else {
            topview = TopViewController(title: strCatIDApplncList, menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        }
        
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    
    //Bottom view
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnApplinc.isSelected = true
        self.view.addSubview(bottomView.view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
    dopostAppliancesListApi()
        
        print(mainArr)
    
    }
    
    
    @IBAction func MenuSekected(sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
    

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
      return 138
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier: String = "AppliancesCustomTableViewCell"
        var customCell : AppliancesCustomTableViewCell!
        customCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AppliancesCustomTableViewCell
        
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
        
        print("wkbw",arrappliance_expiry_date)
        
        customCell.purchasedDate?.text = arrappliance_expiry_date.object(at: indexPath.row) as? String
        customCell.modelProduct?.text = arrappliance_model.object(at: indexPath.row) as? String
        customCell.btnVW.addTarget(self, action: #selector(AppliancesViewController.clickEditViewApplincs), for: .touchUpInside)
        
        customCell.btnDelete.tag = indexPath.row
        customCell.btnDelete.addTarget(self, action: #selector(AppliancesViewController.btnDeleteClicked), for: .touchUpInside)
        
        customCell.btnlogService.tag = indexPath.row
        customCell.btnlogService.addTarget(self, action: #selector(AppliancesViewController.btnLogServiceClicked), for: .touchUpInside)
        
        customCell.btnVW.tag = indexPath.row
        customCell.btnVW.addTarget(self, action: #selector(AppliancesViewController.btnVIewClickedServce), for: .touchUpInside)
        customCell.lblSubCat?.text = ArrSubCattegry.object(at: indexPath.row) as? String
        
        return customCell
    }
    
    //BtnService Action
    func btnVIewClickedServce(sender : UIButton) {
        
        let btnVIEWServiceTAG = sender.tag
        print(btnVIEWServiceTAG)
        
        strPassAplnc_ID = ArrAplinc_iD.object(at: btnVIEWServiceTAG) as! String
        print(strPassAplnc_ID)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ApplianceEditDetailsViewController") as! ApplianceEditDetailsViewController
        newViewController.strRecvAplnc_ID = strPassAplnc_ID
        newViewController.ArrGetAppilncData = mainArr
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
     //BtnLogService Action
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
    
    //BtnLogService Action
    func btnDeleteClicked(sender : UIButton) {
        
        btnFull.isHidden = false
        thankVW.isHidden = false
    
        
        /*var refreshAlert = UIAlertController(title: "", message: "Are you sure to delete this Appliance.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)*/
        
    }
    
    @IBAction func cnclPopUPcrosbtn(sender: AnyObject) {
        
        thankVW.isHidden = true
        btnFull.isHidden = true
        
    }
    
    @IBAction func OKProceddPopUP(sender: UIButton) {
    
        let btnTag = sender.tag
        print(btnTag)
        
        self.strDeleteID  = self.ArrAplinc_iD.object(at: btnTag) as! String
        print(self.strDeleteID)
        self.POST_DELETE_API()
   
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
        if searchText.characters.count == 0 {
            isSearching = false;
            self.tblAppliancesList.reloadData()
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
            self.tblAppliancesList.reloadData()
        }
    
    }
    
    
    //Scroll Method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    
    //Comment Now
    func clickEditViewApplincs(){
    
        /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ApplianceEditDetailsViewController") as! ApplianceEditDetailsViewController
        newViewController.strRecvAplnc_ID = strPassAplnc_ID
        newViewController.ArrGetAppilncData = mainArr
        self.navigationController?.pushViewController(newViewController, animated: true)*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dopostAppliancesListApi()
    {
          user_id = userDefault.string(forKey: "user_id")!
          UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_APPLIANCES_LIST_API)! as URL)
        let set = CharacterSet()
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&catId=\(String(describing:strCatIDApplncList))&cat_location=\(String(describing:strRecvCatLocationFromAp))"
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
                        self.mainArr = NSMutableArray()
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
                            
                            let monthNumber = 3
                            let fmt = DateFormatter()
                            fmt.dateFormat = "MM"
                            let month = fmt.monthSymbols[monthNumber - 1]
                            print(month)
                            
                            
                            self.ArrAplinc_iD.addObjects(from: [self.allDictValue.value(forKey: "appliance_id")!])
                            self.arrappliance_model.addObjects(from: [self.allDictValue.value(forKey: "appliances_model")!])
                            self.ArrSubCattegry.addObjects(from: [self.allDictValue.value(forKey: "appliance_subCategory")!])
                        
                        }
                        
                         DispatchQueue.main.async {
                          self.tblAppliancesList.delegate = self
                          self.tblAppliancesList.dataSource = self
                          self.tblAppliancesList .reloadData()
                        
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
    
    @objc func POST_DELETE_API()
    {
        
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_DELETE_Appliance_LIST_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "Authorization")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "Access_Token")
        
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
                        self.tblAppliancesList .reloadData()
                            
                          self.dopostAppliancesListApi()
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

    
    
    // MARK: LEFT MENU NAVIGATION CLASS
    class func createHomeViewController() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let leftCntrl = storyBoard.instantiateViewController(withIdentifier: "WTMenuViewController") as! WTMenuViewController
        let rightCntrl = storyBoard.instantiateViewController(withIdentifier: "WTMenuViewController") as! WTMenuViewController
        let centerCntrl = storyBoard.instantiateViewController(withIdentifier: "AppliancesViewController")  as! AppliancesViewController
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
        AppDelegateInstance.rootNavigationController.setViewControllers([AppDelegateInstance.drawerController], animated: true)
        
    }
    
    
}
extension UITableView {
    
    var emptyCellsEnabled: Bool {
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


extension String {
    public func addingPercentEncodingForQueryParameter() -> String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
        
        return allowed
    }()
}

