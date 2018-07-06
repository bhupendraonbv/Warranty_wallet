//
//  RegisterDeviceViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 24/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

//self.view.endEditing(false)  // bindtext.inputview  = picker

import UIKit

class RegisterDeviceViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,TopviewDelegate {

    @IBOutlet weak var RegstrPickVW: UIPickerView!
    @IBOutlet weak var txtFldCategory: UITextField!
    @IBOutlet weak var txtFldSubcategory: UITextField!
    @IBOutlet weak var txtManufacture: UITextField!
    
    var arrCategoryList = NSArray()
    var arrCategoryID = NSArray()
    var arrSubCategoryList = NSArray()
     var arrManufactrList = NSArray()
    var dict = String()
    
    var arrSubCategoryID = NSArray()
    var cst = String()
    var sbCAtID = String()
    var bottomView:BottomViewViewController!
    var topview:TopViewController!
    var mainArr = NSMutableArray()
    
    var storeArray = NSMutableArray()
    
    var list = ["LG" , "Videocon" , "BPL" , "Voltas" , "BlueStar"]
    
    var Sublist = ["mobile" , "laptop" , "AC" , "LCD" , "Music"]
    
    var Manufecture = ["LG" , "Videocon" , "Apple" , "Dalkin" , "BPL"]
    
    var current_arr : [String] = []
    var active_txtField = UITextField()
    var maivc = UIViewController()
    
    @IBOutlet weak var VWCategry: UIView!
    @IBOutlet weak var VWSubCategry: UIView!
    @IBOutlet weak var VWManufctr: UIView!
    @IBOutlet weak var VWManuCustm: UIView!
    
    @IBOutlet weak var btnNextLayer: UIButton!
    
    
    @IBAction func clickBackVW(sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        txtFldCategory.delegate = self
        txtFldSubcategory.delegate = self
        txtManufacture.delegate = self
        
        
        btnNextLayer.layer.cornerRadius = 20
        btnNextLayer.layer.borderWidth = 1
        btnNextLayer.layer.borderColor =  UIColor(red:60/255.0, green:75/255.0, blue:95/255.0, alpha: 1.0).cgColor
        
        VWCategry.layer.cornerRadius = 10
        VWSubCategry.layer.cornerRadius = 10
        VWManufctr.layer.cornerRadius = 10
        VWManuCustm.layer.cornerRadius = 10
        
        txtFldCategory.inputView = RegstrPickVW
        txtFldSubcategory.inputView = RegstrPickVW
        self.txtManufacture.inputView = self.RegstrPickVW

        
        self.RegstrPickVW.delegate = self
        self.RegstrPickVW.dataSource = self
        
        maivc.view .addSubview(RegstrPickVW)
        RegstrPickVW.isHidden = false
        
        addTopView()
        addBottomView()
    }
    
    //Topview
    func addTopView(){
        topview = TopViewController(title: "Register Product", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        topview.topBGVW.backgroundColor = UIColor (colorLiteralRed: 37/255, green: 105/255, blue: 135/255, alpha: 1.0)
        //topview.leftBack.isHidden = true
        
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    //Bottom view
    func addBottomView(){
        bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnAddAplinc.isSelected = true
        self.view.addSubview(bottomView.view)
    }
    
    //Clickopen Pickerview
    @IBAction func clickopenPickeVW(sender: AnyObject)
    {
        if sender.tag == 1001
        {
            
        }
        else if sender.tag == 1002
        {
        }
        else if sender.tag == 1003
        {
            
        }else{}
        
    }
    
    
    //Picker Delegate and Data source method here.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.current_arr.count == 0
        {
            return "String: \(row)"
        }
            
        else{
            return current_arr[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.current_arr.count == 0
        {
            return 0
        }
            
        else
        {
            return self.current_arr.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("selected item is",current_arr[row])
        
        if current_arr.count != 0{
            
            active_txtField.text = current_arr[row] as? AnyObject as? String
            
            if active_txtField == txtFldCategory
            {
                cst = arrCategoryID[row] as! String
            
                 if active_txtField.text! == "Other"
                {
                    VWSubCategry.isHidden = true
                    VWManufctr.isHidden = true
                }
                 else {
                    VWSubCategry.isHidden = false
                    VWManufctr.isHidden = false
                }
                
            }
            
           else if active_txtField == txtManufacture
            {
                
            }
            else {
                
                sbCAtID = arrSubCategoryID[row] as! String
                print("sbcatID-->>",sbCAtID)
            }
            
            if arrSubCategoryID.count == 0
            {
                
            }
            else
            {
                
            }
            
            print(cst)
            print(sbCAtID)
            RegstrPickVW.reloadAllComponents();
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        active_txtField = textField

        switch textField {
        case txtFldCategory:
            
            self.doPostCategoryListingApi()
            self.txtFldSubcategory.text = ""
            self.txtManufacture.text = ""

            DispatchQueue.main.async {
                self.current_arr = self.arrCategoryList as! [String]
            }
            
        case txtFldSubcategory:
            
            if (txtFldCategory.text?.isEmpty)!
            {
                displayAlertMessagae(userMessage: "Please Select Category.")
                
            }else{
                self.doPostSubCategoryListingApi()
                self.txtManufacture.text = ""
                
                DispatchQueue.main.async {
                    self.current_arr = self.arrSubCategoryList as! [String]
                    self.txtManufacture.isUserInteractionEnabled = true
                }
            }
            
            
        case txtManufacture:
            if (txtFldSubcategory.text?.isEmpty)!
            {
                displayAlertMessagae(userMessage: "Please Select SubCategory.")
            }else{
                print("dsds")
                self.doPostManufactureApi()
                DispatchQueue.main.async {
                    self.current_arr = self.arrManufactrList as! [String]
                }
            }
            
           
            //current_arr = Manufecture
            
        default:
            print("default")
        }
        
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
     print("End Text Method")
    }
    
    
    /*do postcategory list*/
    func doPostCategoryListingApi()
    {
        let request = NSMutableURLRequest(url: NSURL(string: POST_CATEGORY_LISt_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "Authorization")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "Access_Token")
        // let postString = "username=\(name)&password=\(pass)&countryCode=\(countrycode)&mobile=\(phonenum)"
        // request.httpBody = postString.data(using: String.Encoding.utf8)
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
                    
                    //arrCategoryList
                    var mainArrcategory = NSMutableArray()
                    mainArrcategory = (dictFromJSON["data"] as? NSMutableArray)!
                    print(mainArrcategory)
                    
                    self.arrCategoryList =  mainArrcategory.value(forKey: "cotegory_name") as! NSArray
                    print(self.arrCategoryList)
                    
                    self.arrCategoryID = mainArrcategory.value(forKey: "cotegory_id") as! NSArray
                    print(self.arrCategoryID)
                    
                    self.current_arr = self.arrCategoryList as! [String]
                    
                    DispatchQueue.main.async { // Correct
                        self.RegstrPickVW.reloadAllComponents();
                    }
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
    }
    
    /*do postSubcategory list*/
    func doPostSubCategoryListingApi()
    {
        let request = NSMutableURLRequest(url: NSURL(string: POST_SUB_CATEGORY_LIST_API)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "catId=\(cst)"
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
                    
                    //arrCategoryList
                   // var mainArr = NSMutableArray()
                   
                    //self.mainArr = (dictFromJSON["data"] as? NSMutableArray)!
                    print(self.mainArr)
                    
                    if let featured = dictFromJSON["data"] as? NSMutableArray {
                        print("Success")
                        self.mainArr = featured
                        print(self.mainArr)
                        
                    }
                    else {
                        print("Failure")
                        //self.displayAlertMessagae(userMessage: self.CommonstrMsg)
                    }
                    
                    self.arrSubCategoryList =  self.mainArr.value(forKey: "subcategory_name") as! NSArray
                    print(self.arrSubCategoryList)
                    
                    self.arrSubCategoryID = self.mainArr.value(forKey: "subcategory_id") as! NSArray
                    print(self.arrSubCategoryID)
                    
                    self.current_arr .removeAll()
                    
                    self.current_arr = self.arrSubCategoryList as! [String]
                    
                    
                    print(self.current_arr)
                    DispatchQueue.main.async { // Correct
                        self.RegstrPickVW.reloadAllComponents();
                    }
                    
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
        
    }
    
    
    /*do Manufacture list*/
    func doPostManufactureApi()
    { //subCatId
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_MANUFACTURER_LIST_API)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "subCatId=\(sbCAtID)"
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
                    
                    // var status = dictFromJSON["status"] as? AnyObject
                    if (self.dict == "1")
                    {
                        //arrCategoryList
                        var mainArr = NSMutableArray()
                        mainArr = (dictFromJSON["data"] as? NSMutableArray)!
                        print(mainArr)
                        
                        self.arrManufactrList =  (mainArr.value(forKey: "manufacturer_name") as? NSArray)!
                        print(self.arrManufactrList)
                        
                        print("manufacture--current",self.current_arr.count)
                        DispatchQueue.main.sync { // Correct
                            //self.RegstrPickVW.delegate = self
                            //self.RegstrPickVW.dataSource = self
                            
                            self.current_arr = self.arrManufactrList as! [String]
                            self.RegstrPickVW.reloadAllComponents();
                        }
                        
                    }else{
                        
                        DispatchQueue.main.sync {
                            // }
                            if self.current_arr.count == 0
                            {
                                self.displayAlertMessagae(userMessage: "Sorry No Manufacturer List")
                                self.txtManufacture.text = ""
                                self.txtManufacture.isUserInteractionEnabled = false
                            }
                            
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

    
    @IBAction func clickModelPushVW(sender: AnyObject)
    {
        if ((txtFldCategory?.text!.isEmpty)! || (txtFldSubcategory?.text!.isEmpty)! || (txtManufacture?.text!.isEmpty)!){
            displayAlertMessagae(userMessage: "please select all entry.")
           return
    }
        let defaults = UserDefaults.standard
        defaults.set(txtFldCategory.text, forKey: "txtCategory")
        defaults.set(txtFldSubcategory.text, forKey: "txtSubCatID")
        defaults.set(txtManufacture.text, forKey: "txtManufacture")
        defaults.synchronize()
        
        storeArray .addObjects(from: arrSubCategoryID as! [Any])
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ModelEnterViewController") as! ModelEnterViewController
        self.navigationController?.pushViewController(newViewController, animated: true)

}
    /*Generic Alert Method*/
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
