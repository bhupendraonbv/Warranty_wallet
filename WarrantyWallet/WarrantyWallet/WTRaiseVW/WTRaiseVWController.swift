//
//  WTRaiseVWController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 09/01/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WTRaiseVWController: UIViewController,TopviewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    var topview:TopViewController!
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var mainArr = NSMutableArray()
    var list = ["Hall" , "Room" , "Compnay" , "Kitchen"]
    var strDescription = String()
    var arrRecvApplncData = NSMutableArray()
    var strRecvApplincName = String()
    var active_txtField = UITextField()
    var maivc = UIViewController()
    var strDateTenure = String()
    var imagePicker:UIImagePickerController?=UIImagePickerController()
    var spinnerActivity: MBProgressHUD = MBProgressHUD()
    var strRecvModelApplnc = String()

  
     @IBOutlet weak var ProductTYPE: UIPickerView!
     @IBOutlet weak var datePicker  = UIDatePicker()
     @IBOutlet weak var txtPrdct : UITextField!
     @IBOutlet weak var txtMdlNm : UITextField!
     @IBOutlet weak var txtTenure : UITextField!
     @IBOutlet weak var txtDescription : UITextField!
     @IBOutlet weak var btnAttach : UIButton!
     @IBOutlet weak var userUploadImageView: UIImageView!
    var bottomView = BottomViewViewController()
    
    var ArrRaiseNameTag = NSMutableArray()
    var allDictValue = NSDictionary()
    var arrAplincIDRaise = NSMutableArray()
    var strAplincID = String()
    var arrModelNumTxt = NSMutableArray()
    
    var param = Dictionary<String, AnyObject>()
    
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var VWGrdntBG: UIView!
    
    @IBOutlet weak var btnRqstNW : UIButton!
    
    
     @IBOutlet weak var VWprdc: UIView!
     @IBOutlet weak var VWDevice: UIView!
     @IBOutlet weak var VWdescrptn: UIView!
     @IBOutlet weak var VWPrfrdSchedule: UIView!
    
    //Date picker code here...
    func createDatePicker(){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let dnebtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ModelEnterViewController.doneClick))
        toolBar.setItems([dnebtn], animated: false)
        
        toolBar.frame = CGRect(x: 0, y: 105, width: view.frame.size.width, height: 40)
        
        txtTenure?.inputAccessoryView = toolBar
        txtTenure.inputView = datePicker
        
        self.view.endEditing(true)
        
    }
    
    func  doneClick(){
        
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd-MM-yyyy"
        
        txtTenure.text = dateformat.string(from: (datePicker?.date)!)
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(arrRecvApplncData)
        
        VWprdc.layer.cornerRadius = 10
        VWDevice.layer.cornerRadius = 10
        VWdescrptn.layer.cornerRadius = 10
        VWPrfrdSchedule.layer.cornerRadius = 10
        
        txtPrdct.delegate = self
        txtMdlNm.delegate = self
        txtTenure.delegate = self
        txtDescription.delegate = self
        
        btnAttach.layer.cornerRadius = 20
        btnAttach.layer.borderWidth = 1
        btnAttach.layer.borderColor =  UIColor(red:60/255.0, green:75/255.0, blue:95/255.0, alpha: 1.0).cgColor
        
        
        btnRqstNW.layer.cornerRadius = 20
        btnRqstNW.layer.borderWidth = 1
        btnRqstNW.layer.borderColor =  UIColor(red:60/255.0, green:75/255.0, blue:95/255.0, alpha: 1.0).cgColor
            
        // Do any additional setup after loading the view.
        txtPrdct.text? = strRecvApplincName
        txtMdlNm.text? = strRecvModelApplnc
        
       print(strAplincID)
       for storeTagName in 0..<self.arrRecvApplncData.count
        {
            self.allDictValue = self.arrRecvApplncData[storeTagName] as! NSMutableDictionary
            print(self.allDictValue)
            self.ArrRaiseNameTag.addObjects(from: [self.allDictValue.value(forKey: "appliance_name_tag")!])
            self.arrAplincIDRaise.addObjects(from: [self.allDictValue.value(forKey: "appliance_id")!])
           self.arrModelNumTxt.addObjects(from: [self.allDictValue.value(forKey: "appliances_model")!])
            
            print(self.arrAplincIDRaise)
        }
        
        txtPrdct.inputView = ProductTYPE
        txtTenure.inputView = datePicker
        
        ProductTYPE.delegate = self
        ProductTYPE.dataSource = self
        maivc.view .addSubview(ProductTYPE)
        ProductTYPE.isHidden = false

        datePicker?.isHidden = false
        createDatePicker()
        maivc.view .addSubview(datePicker!)
        
        addTopView()
        setGradientBackground()
        addBottomView()
        
        dopostExtendTagNMApi()
        print(ArrRaiseNameTag)
        
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 84.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 128.0/255.0, green: 209.0/255.0, blue: 199.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.VWGrdntBG.bounds
        
        self.VWGrdntBG.layer.addSublayer(gradientLayer)
    }
    
    //Delegate code here.......>>>>>>
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        active_txtField = textField
        switch textField {
        case txtPrdct:
           print("txtPrdc")
           ProductTYPE.isHidden = false
           
        case txtMdlNm:
           print("txtMdlNm")
            
            
        case txtTenure:
           print("txtTenure")
            
            datePicker?.isHidden = false
            
         case txtDescription:
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
    
    func addTopView(){
        topview = TopViewController(title: "Request Service", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        topview.btnNotifiy.isHidden = false
       
        topview.topBGVW.backgroundColor = UIColor .clear
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    
    }
    
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnServc.isSelected = true
        self.view.addSubview(bottomView.view)
    }

    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return ArrRaiseNameTag[row] as? String
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return ArrRaiseNameTag.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if active_txtField == txtPrdct
        {
            txtPrdct.text = ArrRaiseNameTag[row] as? String
            strAplincID = (arrAplincIDRaise[row] as? String)!
            print(strAplincID)
            
            strRecvModelApplnc = (arrModelNumTxt[row] as? String)!
            print(strAplincID)
            txtMdlNm.text? = strRecvModelApplnc
            
        }
        else if active_txtField == txtTenure
        {
            txtTenure.inputView = datePicker
        }
        else {
            
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clicktoCallRaise(sender: AnyObject)
    {
        UIApplication.shared.openURL(NSURL(string: "tel://9643296520")! as URL)
        
    }
    
    
    @IBAction func clicktoAttachFileRaise(sender: AnyObject)
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
    
    
    @IBAction func click_RaiseService(sender: AnyObject){
    
        if ((txtPrdct?.text?.isEmpty)! || (txtTenure.text!.isEmpty) || (txtDescription?.text?.isEmpty)!)
        {
            displayAlertMessagae(userMessage: "All Fields are mandatory.")
            return
        
        }
        
        self.POST_RaiseWebAPI()
    
    }
    //Api code here..
    func POST_RaiseWebAPI()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        strDescription = txtDescription.text!
        strDateTenure = txtTenure.text!
        print(strDateTenure)
        
        var imageData: NSData?
        
        if userUploadImageView.image == nil
        {
             param = [
                "userId" : user_id,
                "tokenId" : UserToken,
                "description" : strDescription,
                "applianceId" : strAplincID,
                "preffered_schedule" : strDateTenure,
                "service_document" : "",
                "image_extension" :".png"
                
                
                ] as [String : AnyObject]
        }
        else {
            
            let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose

            let strBase64 = UIImageJPEGRepresentation(userUploadImageView.image!, jpegCompressionQuality)?.base64EncodedString()
            
             imageData = UIImagePNGRepresentation(userUploadImageView.image!) as NSData?
            
             param = [
                "userId" : user_id,
                "tokenId" : UserToken,
                "service_document" :strBase64!,
                "image_extension" :".png",
                "description" : strDescription,
                "applianceId" : strAplincID,
                "preffered_schedule" : strDateTenure
                
                ] as [String : AnyObject]
            
            
        }
        
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_RAISE_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")

        /*let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&description=\(String(describing: strDescription))&service_document=\(String(describing: "text"))&image_extension=\(String(describing: ".png"))&applianceId=\(String(describing: strAplincID))&preffered_schedule=\(String(describing: strDateTenure))"*/
        
        print("Userid&usertoken--->",param)
        let boundary = generateBoundaryString()

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    if(imageData==nil)  {
        //return;tr
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&description=\(String(describing: strDescription))&service_document=\(String(describing: ""))&image_extension=\(String(describing: ".png"))&applianceId=\(String(describing: strAplincID))&preffered_schedule=\(String(describing: strDateTenure))"
        request.httpBody = postString.data(using: String.Encoding.utf8)
         print("Userid&usertoken--->",postString)
    
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
                                                                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTServiceLogViewController") as! WTServiceLogViewController
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
        
    }

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
    
    
    func dopostExtendTagNMApi()
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
                            
                            self.ArrRaiseNameTag.addObjects(from: [self.allDictValue.value(forKey: "appliance_name_tag")!])
                            print("mylist",self.ArrRaiseNameTag)
                            
                            self.arrAplincIDRaise.addObjects(from: [self.allDictValue.value(forKey: "appliance_id")!])
                            print("mylist",self.arrAplincIDRaise)
                            
                            self.arrModelNumTxt.addObjects(from: [self.allDictValue.value(forKey: "appliances_model")!])
                            print("mylist",self.arrModelNumTxt)
                            
                            
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
                //self.displayAlertMessagae(userMessage: "Error!")
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

}
