//
//  WTNotificationViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 22/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.


import UIKit

class WTNotificationViewController: UIViewController,TopviewDelegate,UITableViewDataSource,UITableViewDelegate {

    var topview:TopViewController!

    @IBOutlet weak var tblNotification: UITableView!
    
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    
    @IBOutlet weak var btnFull: UIButton!
    @IBOutlet weak var thankVW: UIView!
    @IBOutlet weak var cnclPOP : UIButton!
    
    var mainArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblNotification.delegate = self
        tblNotification.dataSource = self
        
        self.tblNotification.register(UINib(nibName: "custemNotificationCell", bundle: nil), forCellReuseIdentifier: "custemNotificationCell")
        
        self.tblNotification.emptyCellsNotificationEnabledAMC = false
        
        addTopView()
        dopostNotificationListApi()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addTopView(){
        
        topview = TopViewController(title: "Notification", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
}

    
    func dopostNotificationListApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_NOTIFICATION_LIST_API)! as URL)
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
                        //arrCategoryList
                        self.mainArr = NSMutableArray()
                        self.mainArr = (dictFromJSON["data"] as? NSMutableArray)!
                        print(self.mainArr)
                        
                        for allApplinc in 0..<self.mainArr.count
                        {
                            /*self.allDictValue = self.mainArr[allApplinc] as! NSDictionary
                            print("self.allDictValue",self.allDictValue.value(forKey: "appliance_name_tag")!)
                            self.arrappliance_name_tag.addObjects(from: [self.allDictValue.value(forKey: "appliance_name_tag")!])
                            print("mylist",self.arrappliance_name_tag)
                            self.arrappliance_date_of_parched.addObjects(from: [self.allDictValue.value(forKey: "appliance_expiry_date")!])*/
                        }
                    
                    }
                    else {
                        
                        DispatchQueue.main.async(execute: {() -> Void in
                            self.thankVW.isHidden = false
                            self.btnFull.isHidden = false
                        })
                    }
                  
                }
                
            }catch
            {
                print("error")
               // self.displayAlertMessagae(userMessage: "Error!")
            }
            
        }
        
        task.resume()
    }
    
    
    @IBAction func cnclPopUPcrosbtn(sender: AnyObject) {
        
        thankVW.isHidden = true
        btnFull.isHidden = true
        
    }
    
    
    
 //Tbl code here...
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 76
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier: String = "custemNotificationCell"
        var customCell : custemNotificationCell!
        customCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! custemNotificationCell
        
        //customCell.setCollectionViewDataSourceDelegate(indexPath)
        return customCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
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
    
    var emptyCellsNotificationEnabledAMC: Bool {
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
