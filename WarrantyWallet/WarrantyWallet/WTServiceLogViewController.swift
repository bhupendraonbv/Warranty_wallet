//
//  WTServiceLogViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 20/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//
//

import UIKit

class WTServiceLogViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TopviewDelegate,UISearchBarDelegate,UIScrollViewDelegate {

    var topview:TopViewController!
    var bottomView = BottomViewViewController()
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    
    var allDictValue = NSDictionary()
    var mainArr = NSMutableArray()
    
    var arrExpirylst = NSMutableArray()
    var arrServicelst = NSMutableArray()
    var arrServcTagNMlst = NSMutableArray()
    var arrServcMdllst = NSMutableArray()
    var arrServcDatelst = NSMutableArray()
    var arrServcExplst = NSMutableArray()
    
    @IBOutlet weak var tblServiceRequest: UITableView!
    /*popup outlet design declaration*/
    
    @IBOutlet weak var popVWmainBG: UIView!
    @IBOutlet weak var lblservcTypePOPVW: UILabel!
    @IBOutlet weak var lbltagNMPOPVW: UILabel!
    @IBOutlet weak var lblMOdelPOPVW: UILabel!
    @IBOutlet weak var lblServicePOPVW: UILabel!
    @IBOutlet weak var lblServcWrntyPOPVW: UILabel!
    @IBOutlet weak var lbldatePOPVW: UILabel!
    @IBOutlet weak var lblAsstncNamePOP: UILabel!
    @IBOutlet weak var lblAsstncompnyPOP: UILabel!
    @IBOutlet weak var lblAsstNmbrPOP: UILabel!
    @IBOutlet weak var lblExpDatePOPVW: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnServc.isSelected = true
        self.view.addSubview(bottomView.view)
    }

    
    func addTopView(){
        topview = TopViewController(title: "Service Logs", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblServiceRequest.register(UINib(nibName: "CustemServiceCell", bundle: nil), forCellReuseIdentifier: "CustemServiceCell")
        
        searchBar.delegate = self
        
        addTopView()
        addBottomView()
        
        // Do any additional setup after loading the view.
    }

   
    
    
    override func viewWillAppear(_ animated: Bool){
    
        doPostServiceLogListApi()
    }
    
    
    /*do postcategory list*/
    func doPostServiceLogListApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_SERVICE_LOG_LIST_API)! as URL)
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
                            
                        self.arrServcTagNMlst.addObjects(from: [self.allDictValue.value(forKey: "service_tag_name")!])
                        self.arrServcExplst.addObjects(from: [self.allDictValue.value(forKey: "expiry_date")!])
                        self.arrServicelst.addObjects(from: [self.allDictValue.value(forKey: "service_type")!])
                        self.arrServcMdllst.addObjects(from: [self.allDictValue.value(forKey: "service_model")!])
                        self.arrServcDatelst.addObjects(from: [self.allDictValue.value(forKey: "service_date")!])
                            
                        }
                        
                        DispatchQueue.main.async(execute: {
                            self.tblServiceRequest.delegate = self
                            self.tblServiceRequest.dataSource = self
                            self.tblServiceRequest.emptyCellsEnabledServiceLog = false
                            
                            self.tblServiceRequest .reloadData()

                        })
                    }
                    
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 138.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier: String = "CustemServiceCell"
        var customCell : CustemServiceCell!
        
        
        customCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CustemServiceCell
        
        customCell.selectionStyle = UITableViewCellSelectionStyle.none
        customCell.lblsrvc_Type?.text = arrServicelst.object(at: indexPath.row) as? String
        customCell.lblsrvc_Tag?.text = arrServcTagNMlst.object(at: indexPath.row) as? String
        customCell.lblsrvc_model?.text = arrServcMdllst.object(at: indexPath.row) as? String
        customCell.lblsrvc_DAte?.text = arrServcDatelst.object(at: indexPath.row) as? String
        customCell.lblsrvc_PurchsDate?.text = arrServcExplst.object(at: indexPath.row) as? String

        //customCell.setCollectionViewDataSourceDelegate(indexPath)
        return customCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         self.view.endEditing(true)
        
        /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ApplianceEditDetailsViewController") as! ApplianceEditDetailsViewController
        self.present(newViewController, animated: true, completion: nil)*/
        
       // self.designWarentyPopVW()
    
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        popVWmainBG.isHidden = true
        self.view.endEditing(true)

        
    }
    
    
    //PopUP Design here code ....
    func designWarentyPopVW(){
        
        popVWmainBG.isHidden = false
        
        lblservcTypePOPVW.text = allDictValue.value(forKey: "service_type") as? String
        lbltagNMPOPVW.text = allDictValue.value(forKey: "service_tag_name") as? String
        lblMOdelPOPVW.text = allDictValue.value(forKey: "service_model") as? String
        lblServcWrntyPOPVW.text = allDictValue.value(forKey: "service_type") as? String
        lbldatePOPVW.text = allDictValue.value(forKey: "service_date") as? String
        lblAsstncNamePOP.text = allDictValue.value(forKey: "service_assistance_name") as? String
        lblAsstncompnyPOP.text = allDictValue.value(forKey: "service_assistance_company") as? String
        lblAsstNmbrPOP.text = allDictValue.value(forKey: "service_assistance_number") as? String
        lblExpDatePOPVW.text = allDictValue.value(forKey: "expiry_date") as? String
        
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
    
    
    // MARK: LEFT MENU NAVIGATION CLASS
    class func createHomeViewController() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let leftCntrl = storyBoard.instantiateViewController(withIdentifier: "WTMenuViewController") as! WTMenuViewController
        let rightCntrl = storyBoard.instantiateViewController(withIdentifier: "WTMenuViewController") as! WTMenuViewController
        let centerCntrl = storyBoard.instantiateViewController(withIdentifier: "WTServiceLogViewController")  as! WTServiceLogViewController
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
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
       /* if searchText.characters.count == 0 {
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
        }*/
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    
    
}

extension UITableView {
    
    var emptyCellsEnabledServiceLog: Bool {
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
