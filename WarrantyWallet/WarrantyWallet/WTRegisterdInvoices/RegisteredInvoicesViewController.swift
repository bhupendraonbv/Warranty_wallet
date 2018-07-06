//
//  RegisteredInvoicesViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 01/12/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class RegisteredInvoicesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tblRestrdInvoice: UITableView!
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var userDefault = UserDefaults.standard
    var topview:TopViewController!
    var allDictValue = NSDictionary()
    var mainArr = NSMutableArray()
    
    var arrinvoceExplst = NSMutableArray()
    var arrServcTagNMlst = NSMutableArray()
     var arrinvcManuFctrlst = NSMutableArray()
    var arrinvcModel = NSMutableArray()
    var strPassAplnc_ID = String()
    var  ArrAplinc_iD = NSMutableArray()
    var arrServcMdllst = NSMutableArray()
    var bottomView:BottomViewViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblRestrdInvoice.register(UINib(nibName: "RegistrdInvoiceCell", bundle: nil), forCellReuseIdentifier: "RegistrdInvoiceCell")
        
        self.addTopView()
        self.addBottomView()
    }

    //Bottom viw
    func addBottomView(){
        bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.view.addSubview(bottomView.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.doPostRegisteredInvoiceApi()

    }
    
    //Top View
    func addTopView(){
        
        topview = TopViewController(title: "Registered Invoice", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
        
    }

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
        let identifier: String = "RegistrdInvoiceCell"
        var customCell : RegistrdInvoiceCell!
        
        customCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RegistrdInvoiceCell
        
        customCell.selectionStyle = UITableViewCellSelectionStyle.none
        
        customCell.lblTagName?.text = arrServcTagNMlst.object(at: indexPath.row) as? String
        customCell.lblExpDate?.text = arrinvoceExplst.object(at: indexPath.row) as? String
        customCell.lblModel?.text = arrinvcModel.object(at: indexPath.row) as? String
        customCell.lblManuFctr?.text = arrinvcManuFctrlst.object(at: indexPath.row) as? String
        customCell.lblsrvc_model?.text = arrServcMdllst.object(at: indexPath.row) as? String

        let imageName = allDictValue.value(forKey: "brand_logo") as? String

         customCell.imgLogoBrand?.setImageFromURlInvoice(stringImageUrl: imageName!)
        
       
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
    
    /*do postcategory list*/
    func doPostRegisteredInvoiceApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_INVOICEAPPLIANCES_LIST_API)! as URL)
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
                            
                            self.arrServcTagNMlst.addObjects(from: [self.allDictValue.value(forKey: "appliance_name_tag")!])
                            self.arrinvoceExplst.addObjects(from: [self.allDictValue.value(forKey: "appliance_expiry_date")!])
                            self.arrinvcManuFctrlst.addObjects(from: [self.allDictValue.value(forKey: "appliance_manufacturer")!])
                          
                            self.ArrAplinc_iD.addObjects(from: [self.allDictValue.value(forKey: "appliance_id")!])
                            
                             self.arrinvcModel.addObjects(from: [self.allDictValue.value(forKey: "appliances_serial")!])
                            
                             self.arrServcMdllst.addObjects(from: [self.allDictValue.value(forKey: "appliances_model")!])
                        }
                        
                        DispatchQueue.main.async(execute: {
                            self.tblRestrdInvoice.isHidden = false
                            self.tblRestrdInvoice.delegate = self
                            self.tblRestrdInvoice.dataSource = self
                            self.tblRestrdInvoice.emptyCellsEnabledInvoice = false
                            self.tblRestrdInvoice .reloadData()
                        })
                    }else
                    {
                            // Update the UI
                        DispatchQueue.main.async {
                            self.tblRestrdInvoice.isHidden = true
                            self.displayAlertMessagae(userMessage: "Invoices List is empty.")
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

extension UIImageView{
    
    func setImageFromURlInvoice(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}

extension UITableView {
    
    var emptyCellsEnabledInvoice: Bool {
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
