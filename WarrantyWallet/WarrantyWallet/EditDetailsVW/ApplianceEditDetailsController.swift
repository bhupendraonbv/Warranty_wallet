//
//  ApplianceEditDetailsController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 04/02/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class ApplianceEditDetailsController: UIViewController,TopviewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    var bottomView = BottomViewViewController()
    var topview:TopViewController!
    
     @IBOutlet weak var txtUserProductNM : UITextField!
    @IBOutlet weak var txtPrdctManufctr: UITextField!
    @IBOutlet weak var txtPrdctCapcty: UITextField!
    @IBOutlet weak var txtPrdctModl: UITextField!
    @IBOutlet weak var txtPrdctSerial: UITextField!
    @IBOutlet weak var txtPurchaseDate: UITextField!
    @IBOutlet weak var txtExpDate: UITextField!
    
    @IBOutlet weak var btnAddInvoice: UIButton!
    @IBOutlet weak var btnAddParts: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    
    @IBOutlet weak var txtAddPartsName: UITextField!  // Add Parts
    @IBOutlet weak var txtAddDAtePerchs: UITextField! // Add Parts
    @IBOutlet weak var txtAddWrntyTime: UITextField! // Add Parts
    
    @IBOutlet weak var txtLocation: UITextField!
    
    var ArrGetEditAppliance = NSMutableArray()
    
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnCncl: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    
    
    @IBOutlet weak var bgTransparent: UIView!
    
    var strHdrTitle = String()
    var strApplianceiD = String()
    
    var strCategoryName = String()
    var strInvoiceNo = String()
    
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var spinnerActivity: MBProgressHUD = MBProgressHUD()
    var commonmsgStr = String()
    var current_arr : [String] = []
    
    var active_txtField = UITextField()
    
    @IBOutlet weak var isVWAddpartsDesignBGMain: UIView!
    
    @IBOutlet weak var RegstrPickVW: UIPickerView!
     @IBOutlet weak var datePicker  = UIDatePicker()
    
    var Sublist = ["Warranty Tenure","6 Months","1 Year" , "2 Years" , "3 Years", "4 Years ","5 Years"]
   
    var List = ["Current Location","Home","Office"]
    
    var maivc = UIViewController()
    
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
        
        if active_txtField == txtAddWrntyTime
        {
           // txtAddWrntyTime.inputView = RegstrPickVW
            active_txtField.text = current_arr[row] as? String
        }
        else if active_txtField == txtAddDAtePerchs
        {
            txtAddDAtePerchs.inputView = datePicker
        }
        else if active_txtField == txtLocation
        {
            txtLocation.text = current_arr[row] as? String
        }
            
        else {
            
        }
        
    }
    
    //Date Picker code here.
    func createDatePicker(){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let dnebtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ModelEnterViewController.doneClick))
        toolBar.setItems([dnebtn], animated: false)
        
        toolBar.frame = CGRect(x: 0, y: 105, width: view.frame.size.width, height: 40)
        
        txtAddDAtePerchs?.inputAccessoryView = toolBar
        txtAddDAtePerchs.inputView = datePicker
        
        self.view.endEditing(true)
        
    }
    
    //Done button action
    func  doneClick(){
        
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd-MM-yyyy"
        
        txtAddDAtePerchs.text = dateformat.string(from: (datePicker?.date)!)
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
        print(ArrGetEditAppliance)
        
        btnSave.layer.cornerRadius = 20
        
        btnCncl.layer.cornerRadius = 20
        btnCncl.layer.borderWidth = 1
        btnCncl.layer.borderColor =  UIColor(red:60/255.0, green:79/255.0, blue:95/255.0, alpha: 1.0).cgColor
        
        btnUpload.layer.cornerRadius = 20
        btnUpload.layer.borderColor =  UIColor(red:60/255.0, green:79/255.0, blue:95/255.0, alpha: 1.0).cgColor
        btnUpload.layer.borderWidth = 1
        
        btnAdd.layer.cornerRadius = 20
        btnAdd.layer.borderColor =  UIColor(red:60/255.0, green:79/255.0, blue:95/255.0, alpha: 1.0).cgColor
        btnAdd.layer.borderWidth = 1
        
       // btnAddInvoice.layer.borderColor = UIColor(red:78/255.0, green:178/255.0, blue:175/255.0, alpha: 1.0).cgColor
       // btnAddInvoice.layer.borderWidth = 2.0
       // btnAddInvoice.layer.cornerRadius = 3.0
        
       // btnAddParts.layer.borderColor = UIColor(red:78/255.0, green:178/255.0, blue:175/255.0, alpha: 1.0).cgColor
       // btnAddParts.layer.borderWidth = 2.0
       // btnAddParts.layer.cornerRadius = 3.0
        
        
        txtLocation.delegate = self
        txtLocation.inputView = RegstrPickVW
        
        maivc.view .addSubview(RegstrPickVW)
        RegstrPickVW.isHidden = false
        
        self.RegstrPickVW.delegate = self
        self.RegstrPickVW.dataSource = self
        
        
        strHdrTitle = ((ArrGetEditAppliance.object(at: 0) as AnyObject).value(forKey: "appliance_name_tag") as? String)!
        
        strApplianceiD = ((ArrGetEditAppliance.object(at: 0) as AnyObject).value(forKey: "appliance_id") as? String)!
        
        strCategoryName = ((ArrGetEditAppliance.object(at: 0) as AnyObject).value(forKey: "appliance_category") as? String)!
        
        strInvoiceNo = ((ArrGetEditAppliance.object(at: 0) as AnyObject).value(forKey: "appliance_invoice") as? String)!
        
        txtUserProductNM.text = (ArrGetEditAppliance.object(at: 0) as AnyObject).value(forKey: "appliance_name_tag") as? String
        txtPrdctManufctr.text = (ArrGetEditAppliance.object(at: 0) as AnyObject).value(forKey: "appliance_manufacturer") as? String
        txtPrdctCapcty.text = (ArrGetEditAppliance.object(at: 0) as AnyObject).value(forKey: "appliance_capacity") as? String
        txtPrdctModl.text = (ArrGetEditAppliance.object(at: 0) as AnyObject).value(forKey: "appliances_model") as? String
        txtPrdctSerial.text = (ArrGetEditAppliance.object(at: 0) as AnyObject).value(forKey: "appliances_serial") as? String
        txtPurchaseDate.text = (ArrGetEditAppliance.object(at: 0) as AnyObject).value(forKey: "appliance_date_of_parched") as? String
        txtExpDate.text = (ArrGetEditAppliance.object(at: 0) as AnyObject).value(forKey: "appliance_expiry_date") as? String
        
        txtLocation.text = (ArrGetEditAppliance.object(at: 0) as AnyObject).value(forKey: "appliance_location_tag") as? String
        
        
       addTopView()
      //setGradientBackground()
       addBottomView()
        
    }
    
    //Code gradient level..
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 84.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 128.0/255.0, green: 209.0/255.0, blue: 199.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.isVWAddpartsDesignBGMain.bounds
        
        self.isVWAddpartsDesignBGMain.layer.addSublayer(gradientLayer)
        
    }
    
    
    
    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func addTopView(){
        topview = TopViewController(title: strHdrTitle.uppercased(), menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }

    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.view.addSubview(bottomView.view)
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        active_txtField = textField
        switch textField {
        case txtAddPartsName:
            
              print("csd")
           // current_arr = arrappliance_name_tag as! [String]
            
        case txtAddDAtePerchs:
            
            print("csd")
             txtAddDAtePerchs.inputView = datePicker
            
        case txtAddWrntyTime:
            
            current_arr = Sublist
            
        case txtLocation:
            
            current_arr = List

            
        default:
            print("default")
        }
        
        RegstrPickVW .reloadAllComponents()
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    @IBAction func ClickToADDPAtsButton(sender: AnyObject)
    {
     
        
        isVWAddpartsDesignBGMain.isHidden = false
        bgTransparent.isHidden = false
        
        
        
//        isVWAddpartsDesignBGMain.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        txtAddPartsName.delegate = self
        txtAddDAtePerchs.delegate = self
        txtAddWrntyTime.delegate = self
        
        txtAddWrntyTime.inputView = RegstrPickVW
     // txtWrntType.inputView = RegstrPickVW
        
        maivc.view .addSubview(RegstrPickVW)
        RegstrPickVW.isHidden = false
        
        self.RegstrPickVW.delegate = self
        self.RegstrPickVW.dataSource = self
        
        
        datePicker?.isHidden = false
        createDatePicker()
        maivc.view .addSubview(datePicker!)
        
   
    }
    
    
    @IBAction func ClickToCancelButton(sender: AnyObject)
    {
        isVWAddpartsDesignBGMain.isHidden = true
        bgTransparent.isHidden = true
        
    }
    
    //Save button action
    @IBAction func ClickToSaveEidtsInfo(sender: AnyObject)
    {
        doPostServiceUPDATEApplianceApi()
    }
    
    // Api call here.....
    func doPostServiceUPDATEApplianceApi(){
        
        self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        self.spinnerActivity.label.text = "Loading..."
        
        var TempManufactr = String()
        TempManufactr = (txtPrdctManufctr.text)!
        
        var TempCapacity = String()
        TempCapacity = (txtPrdctCapcty.text)!
        
        var TempApplncNameTAg = String()
        TempApplncNameTAg = (txtUserProductNM.text)!
        
        
        var TempMODEL = String()
        TempMODEL = (txtPrdctModl.text)!
        
        var TempSERIAL = String()
        TempSERIAL = (txtPrdctSerial.text)!
        
        
        var TempPURCHASEdATE = String()
        TempPURCHASEdATE = (txtPurchaseDate.text)!
        
        var TempEXPIRYDATE = String()
        TempEXPIRYDATE = (txtExpDate.text)!
        
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_Update_Edit_Appliance_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&applianceId=\(String(describing: strApplianceiD))&manufacturer=\(String(describing: TempManufactr))&capacity=\(String(describing: TempCapacity))&name_tag=\(String(describing: TempApplncNameTAg))&model_no=\(String(describing: TempMODEL))&serial_no=\(String(describing: TempSERIAL))&date_of_parched=\(String(describing: TempPURCHASEdATE))&expiry_date=\(String(describing: TempEXPIRYDATE))&category=\(String(describing: strCategoryName))&invoice_no=\(String(describing: strInvoiceNo))"
        print("Userid&usertoken--->",postString)
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){data, response, error in
            guard error == nil && data != nil else{
                print("error")
                DispatchQueue.main.async(execute: {() -> Void in                                                                           MBProgressHUD.hide(for: self.view!, animated: true)
                })
                
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
                    self.commonmsgStr = (dictFromJSON["msg"] as? String)!
                   
                    if (self.dict == "1")
                    {
                        //arrCategoryList
                        
                        self.displayAlertMessagae(userMessage: self.commonmsgStr)
                    }
                    else {
                        
                    }
                    
                }
                
            }catch
            {
                print("error")
                DispatchQueue.main.async(execute: {() -> Void in                                                                           MBProgressHUD.hide(for: self.view!, animated: true)
                })
            }
            
        }
        
        task.resume()
        
    }
    
    //Generic alert mesage
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
