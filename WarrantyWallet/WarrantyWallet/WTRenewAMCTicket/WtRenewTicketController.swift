//
//  WtRenewTicketController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 02/02/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WtRenewTicketController: UIViewController,TopviewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var bottomView = BottomViewViewController()
    var topview:TopViewController!
     @IBOutlet var txtPhnNumber: UITextField!
     @IBOutlet var txtPrdctApplinc: UITextField!
     @IBOutlet var txtAMCTenure: UITextField!
     @IBOutlet var txtStrtDate: UITextField!
     @IBOutlet var txtProvide: UITextField!
    
    @IBOutlet var txtChoseServType: UITextField!
    
    @IBOutlet var txtContractAMC: UITextField!
    
    @IBOutlet var vwBGGradient: UIView!
    
    
     @IBOutlet var vwIsHdnAMC: UIView!
    
    var active_txtField = UITextField()
    var current_arr : [String] = []
    
    @IBOutlet weak var AddAMCPickerVW: UIPickerView!
    @IBOutlet weak var datePicker  = UIDatePicker()
    var maivc = UIViewController()
    
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var mainArr = NSMutableArray()
    var spinnerActivity: MBProgressHUD = MBProgressHUD()

    
    var ArrAMCTicketNameTag = NSMutableArray()
    var allDictValue = NSDictionary()
    var arrAplincIDRaise = NSMutableArray()
    var strAplincID = String()
    var arrModelNumTxt = NSMutableArray()
    
    var arrContractAMCList = NSMutableArray()
    
    
     var strProdctAplnc = String()
     var strAmcTenure = String()
     var strStartDate = String()
     var strProvide = String()
     var strPrvdNumber = String()
    
     var ServiceTypeList = NSMutableArray()
    
     var param = Dictionary<String, AnyObject>()
    
    var imagePicker:UIImagePickerController?=UIImagePickerController()
     @IBOutlet weak var userUploadImageView: UIImageView!

     @IBOutlet weak var btnAtchFile: UIButton!
     @IBOutlet weak var btnSbmt: UIButton!
    
    @IBOutlet var vwServiceTyp: UIView!
    @IBOutlet var VwPrdctApp: UIView!
    @IBOutlet var VWAMCTenure: UIView!
    @IBOutlet var vwStrtDAte: UIView!
    @IBOutlet var vwProvider: UIView!
    @IBOutlet var vwProviderPHNNM: UIView!

    var list = ["Compressor" , "Mixer" , "BPL" , "Voltas"]
    
    var Sublist = ["Warranty Tenure","6 Months","1 Year" , "2 Years" , "3 Years" , "4 Years ","5 Years"]
    
    var Manufecture = ["Machine/Body"]
    
    var EmptyArry = ["No AMC data"]
    
    
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
        
        if active_txtField == txtPrdctApplinc
        {
        active_txtField.text = current_arr[row] as? String
            
        }
        else if active_txtField == txtAMCTenure
        {
            active_txtField.text = current_arr[row] as? String
        }
            
        else if active_txtField == txtChoseServType
        {
        
            var temp = ServiceTypeList.object(at: row) as! String
            
            if temp == "Service Contract AMC"
            {
                vwIsHdnAMC.isHidden = false
            }
                
            else {
               
                txtContractAMC.text = ""
                vwIsHdnAMC.isHidden = true
            }
            
            
            active_txtField.text = current_arr[row] as? String
        
        }
            
        else {
            
            if current_arr.count > 0
            {
                active_txtField.text = current_arr[row] as? String
            }
            
            else{
                
                displayAlertMessagae(userMessage: "NO AMC Service request data")
            }
            
        }
        AddAMCPickerVW.reloadAllComponents();
        
    }
    
    //Date Picker view
    func createDatePicker(){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let dnebtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ModelEnterViewController.doneClick))
        toolBar.setItems([dnebtn], animated: false)
        
        toolBar.frame = CGRect(x: 0, y: 105, width: view.frame.size.width, height: 40)
        
        txtStrtDate?.inputAccessoryView = toolBar
        txtStrtDate.inputView = datePicker
        
        self.view.endEditing(true)
        
    }
    
    //Done button
    func  doneClick(){
        
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd-MM-yyyy"
        
        txtStrtDate.text = dateformat.string(from: (datePicker?.date)!)
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ServiceTypeList = ["Choose Service" , "Appliance AMC" , "Service Contract AMC"]
        
        addTopView()
       // setGradientBackground()
        addBottomView()
        
        
        btnAtchFile.layer.cornerRadius = 22
        btnAtchFile.layer.borderColor = UIColor(red: 60.0/255.0, green: 79.0/255.0, blue: 95.0/255.0, alpha: 1.0).cgColor
        btnAtchFile.layer.borderWidth = 1.0
        
        
        btnSbmt.layer.cornerRadius = 22
        btnSbmt.layer.borderColor = UIColor(red: 60.0/255.0, green: 79.0/255.0, blue: 95.0/255.0, alpha: 1.0).cgColor
        btnSbmt.layer.borderWidth = 1.0
        
        vwServiceTyp.layer.cornerRadius = 10
        VwPrdctApp.layer.cornerRadius = 10
        VWAMCTenure.layer.cornerRadius = 10
        vwStrtDAte.layer.cornerRadius = 10
        vwProvider.layer.cornerRadius = 10
        vwProviderPHNNM.layer.cornerRadius = 10
        vwIsHdnAMC.layer.cornerRadius = 10
        
        
        txtPhnNumber.keyboardType = .numberPad
        
        txtPhnNumber.delegate = self
        txtPrdctApplinc.delegate = self
        txtAMCTenure.delegate = self
        txtStrtDate.delegate = self
        txtProvide.delegate = self
        txtChoseServType.delegate = self
        txtContractAMC.delegate = self
        

        AddAMCPickerVW.delegate = self
        AddAMCPickerVW.dataSource = self
        maivc.view .addSubview(AddAMCPickerVW)
        AddAMCPickerVW.isHidden = false
        
        datePicker?.isHidden = false
        createDatePicker()
        maivc.view .addSubview(datePicker!)
        
        
        txtPrdctApplinc.inputView = AddAMCPickerVW
        txtAMCTenure.inputView = AddAMCPickerVW
        txtStrtDate.inputView = datePicker
        txtChoseServType.inputView = AddAMCPickerVW
        txtContractAMC.inputView = AddAMCPickerVW
        
        
        dopostAllGETApplianceList_API()
        doPostRegisteredAMCApi()  //Comment for Temperary ....Jass
        
        // Do any additional setup after loading the view.
    }
    
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 84.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 128.0/255.0, green: 209.0/255.0, blue: 199.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = (self.vwBGGradient?.bounds)!
        self.vwBGGradient?.layer.addSublayer(gradientLayer)
        
    }
    
    
    func addBottomView(){
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnApplinc.isUserInteractionEnabled = false
        self.bottomView.btnServc.isSelected = true
        self.view.addSubview(bottomView.view)
    }
    
    func addTopView(){
        topview = TopViewController(title: "Renew AMC", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
       // topview.topBGVW.backgroundColor = UIColor .clear
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        active_txtField = textField
        switch textField {
        case txtPrdctApplinc:
            
            current_arr = ArrAMCTicketNameTag as! [String]
            
        case txtAMCTenure:
            
            current_arr = Sublist
            
        case txtStrtDate:
            
            current_arr = Manufecture
            
        case txtChoseServType:
            
            current_arr = ServiceTypeList as! [String]
            
        case txtContractAMC:
            
          if arrContractAMCList.count > 0
          {
            current_arr = arrContractAMCList as! [String]
          }
          else {
            
            current_arr = EmptyArry as! [String]
            
            }
            
        default:
            print("default")
        }
        
        AddAMCPickerVW .reloadAllComponents()
        return true
        
    }
    
    //Post Api code
    func dopostAllGETApplianceList_API()
    {
        
        let userID = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_APPLIANCES_LIST_API)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: userID))&tokenId=\(String(describing: UserToken))"
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
                            
                            self.ArrAMCTicketNameTag.addObjects(from: [self.allDictValue.value(forKey: "appliance_name_tag")!])
                            print("mylist",self.ArrAMCTicketNameTag)
                            
                            
                        }
                        
                        DispatchQueue.main.async {
                            
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

    
    
    @IBAction func clicktoAttachFileRenewAMCTicket(sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            // let imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker?.delegate = self
            //imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
    
    @IBAction func click_RENEWAMC_Service(sender: AnyObject){
        
        if ((txtPhnNumber?.text?.isEmpty)! || (txtPrdctApplinc?.text!.isEmpty)! || (txtAMCTenure?.text?.isEmpty)! || (txtProvide.text?.isEmpty)! || (txtStrtDate?.text!.isEmpty)!)
        {
            displayAlertMessagae(userMessage: "All Fields are mandatory.")
            return
            
        }
        POST_AMCRenew_Api()
    }
    
    /*do postcategory list*/
    func POST_AMCRenew_Api()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        strProdctAplnc = txtPrdctApplinc.text!
        strAmcTenure = txtAMCTenure.text!
        strStartDate = txtStrtDate.text!
        strProvide = txtProvide.text!
        strPrvdNumber = txtPhnNumber.text!
        
        if userUploadImageView.image == nil
        {
            displayAlertMessagae(userMessage: "Please upload Image")
            return
        }
        
        let imageData = UIImagePNGRepresentation(userUploadImageView.image!) as NSData?
        let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose
        let strBase64 = UIImageJPEGRepresentation(userUploadImageView.image!, jpegCompressionQuality)?.base64EncodedString()
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_RENEW_AMC_TICKET_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
       let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&amc_document=\(String(describing: strBase64!))&image_extension=\(String(describing: ".png"))&amc_provider=\(String(describing: strProvide))&applianceId=\(String(describing: strProdctAplnc))&amc_provider_number=\(String(describing: strPrvdNumber))&amc_tenure=\(String(describing: strAmcTenure))&amc_start_date=\(String(describing: strStartDate))"
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
                        
                       // arrContractAMCList = mainArr.value(forKey: )
                        
                    }
                    
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
        
    }

    
    /*do postcategory list*/
    func doPostRegisteredAMCApi()
    {
        
        self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        self.spinnerActivity.label.text = "Loading..."
        
        
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_APPLIANCES_AMCLIST_API)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))"
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
                            
                            self.arrContractAMCList.addObjects(from: [self.allDictValue.value(forKey: "amc_tag_name")!])
                            
                            print("AllvalueListAMC",self.arrContractAMCList)
                           
                        }
                        
                       
                    }else{
                        DispatchQueue.main.async {
                           // self.displayAlertMessagae(userMessage: "AMc List is empty.")
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
    
 
  /*  func POST_AMCRenew_Api()
    {
        
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        strProdctAplnc = txtPrdctApplinc.text!
        strAmcTenure = txtAMCTenure.text!
        strStartDate = txtStrtDate.text!
        strProvide = txtProvide.text!
        strPrvdNumber = txtPhnNumber.text!
        
        print(strStartDate)
        
        /*var myurl: URL!
        myurl = NSURL(string:POST_RENEW_AMC_TICKET_API)! as URL;
        let request = NSMutableURLRequest(url:myurl! as URL)
        request.httpMethod = "POST"*/
        
       
        var imageData: NSData?
        
        if userUploadImageView.image == nil
         {
              param = [
                "userId" : user_id,
                "tokenId" : UserToken,
                "amc_document" :"",
                "image_extension" :".png",
                "amc_provider" : strProvide,
                "applianceId" : strProdctAplnc,
                "amc_provider_number" : strPrvdNumber,
                "amc_tenure" : strAmcTenure,
                "amc_start_date" : strStartDate
                
                ] as [String : AnyObject]
         }
        
        else{
            
            let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose
            
            let strBase64 = UIImageJPEGRepresentation(userUploadImageView.image!, jpegCompressionQuality)?.base64EncodedString()
            
             imageData = UIImagePNGRepresentation(userUploadImageView.image!) as NSData?
            
              param = [
                "userId" : user_id,
                "tokenId" : UserToken,
                "amc_document" :strBase64!,
                "image_extension" :".png",
                "amc_provider" : strProvide,
                "applianceId" : strProdctAplnc,
                "amc_provider_number" : strPrvdNumber,
                "amc_tenure" : strAmcTenure,
                "amc_start_date" : strStartDate
                
                ] as [String : AnyObject]
        }
        
        let request = NSMutableURLRequest(url: (NSURL(string: POST_RENEW_AMC_TICKET_API)! as? URL)!)
        request.httpMethod = "POST"
        
        
        /*let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&description=\(String(describing: strDescription))&service_document=\(String(describing: "text"))&image_extension=\(String(describing: ".png"))&applianceId=\(String(describing: strAplincID))&preffered_schedule=\(String(describing: strDateTenure))"*/
        
        
        print("Userid&usertoken--->",param)
        let boundary = generateBoundaryString()
        
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        if(imageData==nil)  {
            //return;
            
        }
        else {
             request.httpBody = createBodyWithParameters(param: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        }
        
        let task =  URLSession.shared.dataTask(with: request as URLRequest,
                                               completionHandler: {
                                                (data, response, error) -> Void in
                                                if let data = data {
                                                    // You can print out response object
                                                    print("******* response = \(String(describing: response))")
                                                    print(data.count)
                                                    // you can use data here
                                                    // Print out reponse body
                                                    
                                                    let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                                                    print("****** response data = \(responseString!)")
                                                    
                                                    let json = try!JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                                                    
                                                    print("json value \(String(describing: json))")
                                                    
                                                    DispatchQueue.main.async(execute: {
                                                        
                                                        self.userUploadImageView.image = nil;
                                                        
                                                        if let dictFromJSON = json as? [String:AnyObject] {
                                                            
                                                            print(dictFromJSON)
                                                            
                                                            self.dict = (dictFromJSON["status"] as? String)!
                                                            print("hfuwfhwq",self.dict)
                                                            
                                                            if (self.dict == "1")
                                                            {
                                                                
                                                                //arrCategoryList
                                                                self.mainArr = NSMutableArray()
                                                                //  self.mainArr = (dictFromJSON["data"] as? NSMutableArray)!
                                                                //  print(self.mainArr)
                                                                
                                                                let alert = UIAlertController(title: "", message: "Raise Service Request Successfully.", preferredStyle: .alert)
                                                                self.present(alert, animated: true, completion: nil)
                                                                
                                                                let when = DispatchTime.now() + 0.8
                                                                DispatchQueue.main.asyncAfter(deadline: when){
                                                                    // your code with delay
                                                                    alert.dismiss(animated: true, completion: nil)
                                                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTRegisteredAMCViewController") as! WTRegisteredAMCViewController
                                                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                                                }
                                                                
                                                            }
                                                            else {
                                                                
                                                                
                                                                print ("status o")
                                                            }
                                                        }
                                                        
                                                        
                                                    });
                                                    
                                                }
                                                else if let error = error {
                                                    print(error)
                                                    
                                                }
        })
        
        task.resume()
        
    }*/
    
    func createBodyWithParameters(param:[String:AnyObject], filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        var body = NSMutableData();
        
        let mimetype = "image/jpg"
        let filename = "user-profile.jpg"
        
        if param != nil {
            for (key, value) in param {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        body.appendString(string: "upload_appliance")
        
        return body
        
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
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
