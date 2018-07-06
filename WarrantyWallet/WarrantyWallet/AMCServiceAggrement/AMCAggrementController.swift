//
//  AMCAggrementController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 13/02/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class AMCAggrementController: UIViewController,TopviewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var bottomView = BottomViewViewController()
    var topview:TopViewController!
    
    
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var mainArr = NSMutableArray()
   
    var strDescription = String()
    var arrRecvApplncData = NSMutableArray()
    var strRecvApplincName = String()
    var active_txtField = UITextField()
    var maivc = UIViewController()
    var strDateTenure = String()
    var imagePicker:UIImagePickerController?=UIImagePickerController()
    var spinnerActivity: MBProgressHUD = MBProgressHUD()
    var strRecvModelApplnc = String()
    
     var current_arr : [String] = []
    
    var postString = String()
     var arrAplincIDAMC = NSMutableArray()
    
    
    @IBOutlet weak var ProductTYPE: UIPickerView!
    @IBOutlet weak var datePicker  = UIDatePicker()
   
    @IBOutlet weak var txtPrdct : UITextField!
    @IBOutlet weak var txtPEstCont : UITextField!
    @IBOutlet weak var txtStartDate : UITextField!
    @IBOutlet weak var txtAMCTenure : UITextField!
    @IBOutlet weak var txtProvider : UITextField!
    @IBOutlet weak var txtProvdrNumber : UITextField!
   
    @IBOutlet weak var btnAttach : UIButton!
    @IBOutlet weak var userUploadImageView: UIImageView!
    
    @IBOutlet weak var isbtnarrowAgrmnt : UIButton!
    
    @IBOutlet weak var vwProductAMCTAb : UIView!
    @IBOutlet weak var txtisAMCHDN : UITextField!
    
    var List = NSMutableArray()
    
    var ArrAMCTicketNameTag = NSMutableArray()
    var allDictValue = NSDictionary()
    
    var stramc_type = String()
    var strname_of_service = String()
    
    var strProdctAplnc = String()
    var strAmcTenure = String()
    var strStartDate = String()
    var strProvide = String()
    var strPrvdNumber = String()
    
    
    var strBase64 = String()
    
    
     @IBOutlet weak var btnAttachlyr : UIButton!
     @IBOutlet weak var btnSubmitlyr : UIButton!
    
    
    var Sublist = ["Warranty Tenure","6 Months","1 Year" , "2 Years" , "3 Years" , "4 Years ","5 Years"]
    
    @IBOutlet weak var vwLyrChsAMC : UIView!
    @IBOutlet weak var vwLyrsrvcpost : UIView!
    @IBOutlet weak var vwLyrAmcTenr : UIView!
    @IBOutlet weak var vwLyrdate : UIView!
    @IBOutlet weak var vwLyrPhnNm : UIView!
    @IBOutlet weak var vwLyrPrvdr : UIView!
    
    var drawingHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var topConstraint: NSLayoutConstraint!

    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //return ArrRaiseNameTag[row] as? String
        return current_arr[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
       // return ArrRaiseNameTag.count
       return self.current_arr.count
    
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if active_txtField == txtPrdct
        {
        
            //txtPrdct.inputView = ProductTYPE
            var temp = List.object(at: row) as! String
            
            if temp == "Product AMC"
            {
               vwProductAMCTAb.isHidden = false
                
                
                self.vwLyrsrvcpost.isHidden = false
                
                vwLyrAmcTenr.frame = CGRect(x: 0, y: 138, width: 344, height: 61)
                vwLyrdate.frame = CGRect(x: 0, y: 207, width: 344, height: 61)
                vwLyrPrvdr.frame = CGRect(x: 0, y: 276, width: 344, height: 61)
                vwLyrPhnNm.frame = CGRect(x: 0, y: 345, width: 344, height: 61)
                
                
            }
                
            else if  temp == "Choose Service Type"
                
            {
                self.vwLyrsrvcpost.isHidden = true
                self.vwProductAMCTAb.isHidden = true
                
                vwLyrAmcTenr.frame = CGRect(x: 0, y: 69, width: 344, height: 61)
                vwLyrdate.frame = CGRect(x: 0, y: 138, width: 344, height: 61)
                vwLyrPrvdr.frame = CGRect(x: 0, y: 207, width: 344, height: 61)
                vwLyrPhnNm.frame = CGRect(x: 0, y: 276, width: 344, height: 61)
                
            }
            
            else {
                txtPEstCont.text = ""
                vwProductAMCTAb.isHidden = true
                
                
                self.vwLyrsrvcpost.isHidden = false
                
                vwLyrAmcTenr.frame = CGRect(x: 0, y: 138, width: 344, height: 61)
                vwLyrdate.frame = CGRect(x: 0, y: 207, width: 344, height: 61)
                vwLyrPrvdr.frame = CGRect(x: 0, y: 276, width: 344, height: 61)
                vwLyrPhnNm.frame = CGRect(x: 0, y: 345, width: 344, height: 61)
                
                
                
            }
            
            stramc_type = (current_arr[row] as? String)!
            
            print(stramc_type)
            
            txtPrdct.text = current_arr[row] as? String
        
        }
            
        else if active_txtField == txtStartDate
        {
            txtStartDate.inputView = datePicker
        }
            
        else if active_txtField == txtPEstCont
        {
            

        }
        else if active_txtField == txtisAMCHDN
        {
            
            strProdctAplnc = (arrAplincIDAMC[row] as? String)!
            print("Appliance ID",strname_of_service)
            
            txtisAMCHDN.inputView = ProductTYPE
            txtisAMCHDN.text = current_arr[row] as? String
            
        }
            
        else if active_txtField == txtAMCTenure
        {
            txtAMCTenure.inputView = ProductTYPE
            txtAMCTenure.text = current_arr[row] as? String
            
        }
            
        else {
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        List = ["Choose Service Type","Product AMC","Service Contract AMC"]

        btnAttachlyr.layer.cornerRadius = 20
        btnAttachlyr.layer.borderColor =  UIColor(red:60/255.0, green:79/255.0, blue:95/255.0, alpha: 1.0).cgColor
        btnAttachlyr.layer.borderWidth = 1.0

        btnSubmitlyr.layer.cornerRadius = 20
        btnSubmitlyr.layer.borderColor =  UIColor(red:60/255.0, green:79/255.0, blue:95/255.0, alpha: 1.0).cgColor
        btnSubmitlyr.layer.borderWidth = 1.0

        vwProductAMCTAb.layer.cornerRadius = 10
        
        vwLyrChsAMC.layer.cornerRadius = 10
        vwLyrsrvcpost.layer.cornerRadius = 10
        vwLyrAmcTenr.layer.cornerRadius = 10
        vwLyrdate.layer.cornerRadius = 10
        vwLyrPhnNm.layer.cornerRadius = 10
        vwLyrPrvdr.layer.cornerRadius = 10
        
        //self.vwLyrsrvcpost.frame = CGRect(x: 0, y: 20, width: 67, height: 30)
        
        txtPrdct.delegate = self
        txtPEstCont.delegate = self
        txtStartDate.delegate = self
        txtAMCTenure.delegate = self
        txtProvider.delegate = self
        txtProvdrNumber.delegate = self
        txtisAMCHDN.delegate = self
        
        ProductTYPE.delegate = self
        ProductTYPE.dataSource = self
        maivc.view .addSubview(ProductTYPE)
        ProductTYPE.isHidden = false
        
        datePicker?.isHidden = false
        createDatePicker()
        maivc.view .addSubview(datePicker!)
        
        
        txtPrdct.inputView = ProductTYPE
        txtAMCTenure.inputView = ProductTYPE
        txtStartDate.inputView = datePicker
        txtisAMCHDN.inputView = ProductTYPE
        
        txtProvdrNumber.keyboardType = .numberPad
        
         dopostAllGETApplianceList_API()   /* AppliancesList */
        
        /* Code New updated here...*/
        self.vwLyrsrvcpost.isHidden = true
    
        vwLyrAmcTenr.frame = CGRect(x: 0, y: 69, width: 344, height: 61)
        vwLyrdate.frame = CGRect(x: 0, y: 138, width: 344, height: 61)
        vwLyrPrvdr.frame = CGRect(x: 0, y: 207, width: 344, height: 61)
        vwLyrPhnNm.frame = CGRect(x: 0, y: 276, width: 344, height: 61)
        
        addTopView()
        addBottomView()
   
    }

    //Top View
    func addTopView(){
        topview = TopViewController(title: "Add AMC", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    
    }
    
    //Bottom View
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnAddAplinc.isSelected = true
        self.view.addSubview(bottomView.view)
    }

    //Date Picket code here
    func createDatePicker(){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let dnebtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ModelEnterViewController.doneClick))
        toolBar.setItems([dnebtn], animated: false)
        
        toolBar.frame = CGRect(x: 0, y: 105, width: view.frame.size.width, height: 40)
        
        txtStartDate?.inputAccessoryView = toolBar
        txtStartDate.inputView = datePicker
        
        self.view.endEditing(true)
        
    }
    
    //Done button action
    func  doneClick(){
        
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd-MM-yyyy"
        txtStartDate.text = dateformat.string(from: (datePicker?.date)!)
        self.view.endEditing(true)
        
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        active_txtField = textField
        switch textField {
        case txtPrdct:
            print("txtPrdc")
            current_arr = List as! [String]
            
            ProductTYPE.isHidden = false
            
        case txtPEstCont:
            print("txtMdlNm")
            
          case txtisAMCHDN:
             print("txtMdlNm")
            current_arr = ArrAMCTicketNameTag as! [String]
            
        case txtStartDate:
            print("txtTenure")
            
            datePicker?.isHidden = false
            
        case txtAMCTenure:
            print("txtDescription")
             current_arr = Sublist
            
        case txtProvider:
            print("txtDescription")
            
        case txtProvdrNumber:
            print("txtDescription")
            
        default:
            print("default")
        }
        
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("End Text Method")
    }
    
    //All Get Applinaces Lst
    func dopostAllGETApplianceList_API()
    {
        
        self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        self.spinnerActivity.label.text = "Loading..."
        
        let userID = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_APPLIANCES_LIST_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "Authorization")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "Access_Token")
        
        let postString = "userId=\(String(describing: userID))&tokenId=\(String(describing: UserToken))"
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
                            
                            self.ArrAMCTicketNameTag.addObjects(from: [self.allDictValue.value(forKey: "appliance_name_tag")!])
                            print("mylist",self.ArrAMCTicketNameTag)
                            
                            self.arrAplincIDAMC.addObjects(from: [self.allDictValue.value(forKey: "appliance_id")!])
                             print("mylist",self.arrAplincIDAMC)
                             
                             /*self.arrModelNumTxt.addObjects(from: [self.allDictValue.value(forKey: "appliances_model")!])
                             print("mylist",self.arrModelNumTxt)*/
                            
                        }
                        
                        DispatchQueue.main.async {
                            //  self.RegstrPickVW.delegate = self
                            // self.RegstrPickVW.dataSource = self
                            //self.RegstrPickVW .reloadComponent(true)
                        }
                        
                    }else
                    {
                        
                    }
                    
                }
                
            }catch
            {
                print("error")
                self.displayAlertMessagae(userMessage: "")
            }
            
        }
        
        task.resume()
        
    }
    
    
    /*do postcategory list*/
    func POST_AMCAGGREMENT_Api()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        //strProdctAplnc = txtisAMCHDN.text!
        strAmcTenure = txtAMCTenure.text!
        strStartDate = txtStartDate.text!
        strProvide = txtProvider.text!
        strPrvdNumber = txtProvdrNumber.text!
        strname_of_service = txtPEstCont.text!
        
        print("strname_of_seerf",strname_of_service)
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_RENEW_AMC_TICKET_API)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        if strname_of_service.isEmpty
        {
            postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&amc_document=\(String(describing: strBase64))&image_extension=\(String(describing: ".png"))&amc_provider=\(String(describing: strProvide))&applianceId=\(String(describing: strProdctAplnc))&amc_provider_number=\(String(describing: strPrvdNumber))&amc_tenure=\(String(describing: strAmcTenure))&amc_start_date=\(String(describing: strStartDate))&amc_type=\(String(describing: stramc_type))&name_of_service=\(String(describing: ""))"
            
        }
        else {
            
            postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&amc_document=\(String(describing: strBase64))&image_extension=\(String(describing: ".png"))&amc_provider=\(String(describing: strProvide))&applianceId=\(String(describing: ""))&amc_provider_number=\(String(describing: strPrvdNumber))&amc_tenure=\(String(describing: strAmcTenure))&amc_start_date=\(String(describing: strStartDate))&amc_type=\(String(describing: stramc_type))&name_of_service=\(String(describing: strname_of_service))"
        }
        
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
                    }
                    
                }
                
            }catch
            {
                print("error")
                
                
            }
            
        }
        
        task.resume()
        
    }
    
    
    @IBAction func clicktoAttachFileAMCAggrement(sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            imagePicker?.delegate = self
            imagePicker?.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker?.allowsEditing = true
            self.present(imagePicker!, animated: true, completion: nil)
            
        }
        else
        {
            let alert:UIAlertController = UIAlertController(title: "Camera Unavailable", message: "Unable to find a camera on this device", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            alert.view.tintColor = UIColor(red:0.37, green:0.66, blue:0.44, alpha:1.0)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userUploadImageView.contentMode = .scaleToFill
            userUploadImageView.image = pickedImage
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
                self.spinnerActivity.label.text = "Uploading Please wait..."
            })
        
            let imageData = UIImagePNGRepresentation(userUploadImageView.image!) as NSData?
            let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose
            strBase64 = (UIImageJPEGRepresentation(userUploadImageView.image!, jpegCompressionQuality)?.base64EncodedString())!
            
        
        }
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
            
            let snackbar = TTGSnackbar.init(message: "Image Upload Successfully", duration: .middle)
            snackbar.show()
            MBProgressHUD.hide(for: self.view!, animated: true)
            
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func click_AMCSAVE_AGGREMENT(sender: AnyObject){
        
        if ((txtAMCTenure?.text?.isEmpty)! || (txtProvider.text?.isEmpty)! || (txtStartDate?.text!.isEmpty)!)
        {
            displayAlertMessagae(userMessage: "All Fields are mandatory.")
            return
        }
        
       else if (txtProvdrNumber.text?.characters.count)! < 10
        {
            displayAlertMessagae(userMessage: "Please fill Phone number 10  digit")
            return
        }
        
        POST_AMCAGGREMENT_Api()
    
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
