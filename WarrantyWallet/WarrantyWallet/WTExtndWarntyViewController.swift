//
//  WTExtndWarntyViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 09/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WTExtndWarntyViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,TopviewDelegate {

    @IBOutlet weak var RegstrPickVW: UIPickerView!
    
    //TextField Property 
     @IBOutlet weak var txtPrdct : UITextField!
     @IBOutlet weak var txtWrntTenure : UITextField!
     @IBOutlet weak var txtWrntType : UITextField!
    var topview:TopViewController!
    var strRecvApplncNAmeTAgforExtend = String()
    
    
    //Local Array Declare here.
    var list = ["Compressor" , "Mixer" , "BPL" , "Voltas"]
    
    var Sublist = ["Warranty Tenure","6 Months","1 Year" , "2 Years" , "3 Years" , "4 Years ","5 Years" ]
    
    var Manufecture = ["Machine/Body"]
    
    //Current Picker Text save in this.
    var current_arr : [String] = []
    var active_txtField = UITextField()
    var maivc = UIViewController()
    var bottomView:BottomViewViewController!
    var Token  = String()
    var userDefault = UserDefaults.standard
    var dict = String()
    var mainArr = NSMutableArray()
    var allDictValue = NSDictionary()
    var arrappliance_name_tag = NSMutableArray()
    var arrappliance_Extend_ID = NSMutableArray()
    var strExtnd_ApplncID = String()
    var user_id = String()
    
    //String Name
    var strPrdc = String()
    var strWrntyTenure = String()
    var strWrntyType = String()
    
    @IBOutlet weak var VWProduct : UIView!
     @IBOutlet weak var VWWRNtTenure : UIView!
     @IBOutlet weak var VWWrntyType : UIView!
    
     @IBOutlet weak var vwGrdntBG : UIView!
    
    
    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Picker Delegate and Data source method here.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return current_arr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.current_arr.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("selected item is",current_arr[row])
        
        if active_txtField == txtPrdct
        {
            txtPrdct.text = arrappliance_name_tag[row] as? String
            strExtnd_ApplncID = (arrappliance_Extend_ID[row] as? String)!
            print(strExtnd_ApplncID)
            
        }
        else if active_txtField == txtWrntTenure
        {
            active_txtField.text = current_arr[row] as? String
        }
        else {
            active_txtField.text = current_arr[row] as? String
        }
        RegstrPickVW.reloadAllComponents();
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPrdct.text? = strRecvApplncNAmeTAgforExtend
        
        print(strExtnd_ApplncID)
        
        VWProduct.layer.cornerRadius = 10
        VWWRNtTenure.layer.cornerRadius = 10
        VWWrntyType.layer.cornerRadius = 10

        txtPrdct.delegate = self
        txtWrntTenure.delegate = self
        txtWrntType.delegate = self
       
        txtPrdct.inputView = RegstrPickVW
        txtWrntTenure.inputView = RegstrPickVW
        txtWrntType.inputView = RegstrPickVW
        
        maivc.view .addSubview(RegstrPickVW)
        
        RegstrPickVW.isHidden = false
        
        
        
        self.RegstrPickVW.delegate = self
        self.RegstrPickVW.dataSource = self
        
        
        addTopView()
        setGradientBackground()
        addBottomView()
      
    }
    
    //Gradient Method here...
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 84.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 128.0/255.0, green: 209.0/255.0, blue: 199.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.vwGrdntBG.bounds
        
        self.vwGrdntBG.layer.addSublayer(gradientLayer)
        
    }
    
    //Top View here
    func addTopView(){
        topview = TopViewController(title: "Extend Warranty", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        topview.topBGVW.backgroundColor = UIColor .clear
        
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
        
    }

    //Bottom View here..
    func addBottomView(){
        bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnServc.isSelected = true
        self.view.addSubview(bottomView.view)
    }
    
     override func viewWillAppear(_ animated: Bool){
      dopostExtendTagNMApi()
    }
    
    //ExtendApi here .
    func dopostExtendTagNMApi()
    {
        
        let userID = userDefault.string(forKey: "user_id")!
        Token = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_APPLIANCES_LIST_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: userID))&tokenId=\(String(describing: Token))"
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
                            
                            self.arrappliance_Extend_ID.addObjects(from: [self.allDictValue.value(forKey: "appliance_id")!])
                             print("mylist",self.arrappliance_Extend_ID)
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.RegstrPickVW.delegate = self
                            self.RegstrPickVW.dataSource = self
                            //self.RegstrPickVW .reloadComponent(true)
                            
                        }
                        
                    }else
                    {
                        
                    }
                    
                }
                
            }catch
            {
                print("error")
                //self.displayAlertMessagae(userMessage: "Error!")
            }
            
        }
        
        task.resume()
        
    }

    /*Extend Api IN Up button click */
    func doPostExtendWarrentyApi()
    {
        strPrdc = txtPrdct.text!
        strWrntyTenure = txtWrntTenure.text!
        strWrntyType = txtWrntType.text!
        
        Token = userDefault.string(forKey: "UserToken")!
        print("print Token",Token) 
        
        user_id = userDefault.string(forKey: "user_id")!
        print("print userID",user_id)
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_EXTEND_WARRANTY_LIST_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: Token))&product_name=\(String(describing: strPrdc))&warranty_tenure=\(String(describing: strWrntyTenure))&warranty_type=\(String(describing: strWrntyType))&applianceId=\(String(describing: strExtnd_ApplncID))"
        
        print(postString)
        
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
                    
                    
                    let alert = UIAlertController(title: "", message: "Appliance Extend Warranty Successfully Submitted", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    
                    // change to desired number of seconds (in this case 5 seconds)
                    let when = DispatchTime.now() + 0.9
                    DispatchQueue.main.asyncAfter(deadline: when){
                        // your code with delay
                        alert.dismiss(animated: true, completion: nil)
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppliancesViewController") as! AppliancesViewController
                        // self.navigationController?.pushViewController(newViewController, animated: true)
                        AppDelegateInstance.rootNavigationController.pushViewController(newViewController, animated: true)
                        
                    }
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
        
    }
    
    /*Keyboard Dismiss Method*/
    func dismissKeyboard()
    {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    
    }
    
    //  Text Field delegate and data source declare here..
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        active_txtField = textField
        switch textField {
        case txtPrdct:
            
            current_arr = arrappliance_name_tag as! [String]
            
        case txtWrntTenure:
            
            current_arr = Sublist
            
            
        case txtWrntType:
            
            current_arr = Manufecture
            
        default:
            print("default")
        }
        
        RegstrPickVW .reloadAllComponents()
        return true
  
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    
    //Alert
    @IBAction func clickRequestNW(sender: AnyObject) {
        /*if let url = NSURL(string: "https://www3.lenovo.com/in/en/warranty-upgrades"){
            UIApplication.shared.openURL(url as URL)
        }*/
        
        if ((txtPrdct?.text?.isEmpty)! || (txtWrntTenure.text!.isEmpty) || (txtWrntType?.text?.isEmpty)!)
        {
            displayAlertMessagae(userMessage: "All Fields are mandatory.")
            return
        }
        
        self.doPostExtendWarrentyApi()
    }

    //Custom Method Alert....
    func displayAlertMessagae(userMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
  
