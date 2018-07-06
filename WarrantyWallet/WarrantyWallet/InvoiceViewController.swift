//
//  InvoiceViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 27/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class InvoiceViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TopviewDelegate {

    var userDefault = UserDefaults.standard
    var Token  = String()
    var dict = String()
    var user_id = String()
    
    //Dec;are
    var txtCategory = String()
    var txtSubCatID = String()
    var txtManufacture = String()
    var txtmodel = String()
    var txtSerialNM = String()
    var txtDAte = String()
    var txtlocation = String()
    var txtcustomLocation = String()
    var txtNameTAg = String()
    var txtInvoiceNo1 = String()
    var txtPurchasedFrm2 = String()
    var txtWarrentenr3 = String()
    var txtCarPck4 = String()
    var txtCarPckTenure5 = String()

    var bottomView:BottomViewViewController!
    
    @IBOutlet weak var txtInvoiceNo : UITextField!
    @IBOutlet weak var txtPurchasedFrm : UITextField!
    @IBOutlet weak var txtWarrentenr : UITextField!
    @IBOutlet weak var txtCarPck : UITextField!
    @IBOutlet weak var txtCarPckTenure : UITextField!
    @IBOutlet weak var invoicePicker: UIPickerView!
    @IBOutlet weak var btnAttach: UIButton!
    
    
    
    @IBOutlet weak var vwInvoice : UIView!
    @IBOutlet weak var vwWrntTenu : UIView!
    @IBOutlet weak var vwCarPCK : UIView!
    @IBOutlet weak var vwSprt : UIView!
    
    
    
    var currentArr : [String] = []
    
    var active_txtField : UITextField!
    var list = ["Hall" , "Room" , "Compnay" , "Kitchen"]
    var arrpurchaseFrm = ["croma","Big Bazar","Samsung","Apple","other"]
    var arrwarntyTenure = ["6 Months","1 Year","2 Year","3 Year","4 Year","5 Year"]
    var arrCarPackSprt = ["Yes","NO"]
    var arrCarPackTenure = ["6 Months","1 Year","2 Year","3 Year","4 Year","5 Year"]
    var maivc = UIViewController()
    var imagePicker:UIImagePickerController?=UIImagePickerController()
    var topview:TopViewController!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    @IBOutlet weak var vwCarPackTenure: UIView!
    
    var param = Dictionary<String, AnyObject>()
    var spinnerActivity: MBProgressHUD = MBProgressHUD()
    
    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        // RegstrPickVW.isHidden = true
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return currentArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return currentArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected item is",currentArr[row])
        
        
         var temp = currentArr[row] as! String
        
        if active_txtField == txtCarPck
        {
            if temp == "Yes"
            {
                vwCarPackTenure.isHidden = false
                
            }
            else {
                vwCarPackTenure.isHidden = true
            }
        }
        else {
            
        }
        
        active_txtField.text = currentArr[row]

        //locationTag.reloadAllComponents();
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwCarPackTenure.isHidden = false
        
        txtInvoiceNo.delegate = self
        txtPurchasedFrm.delegate = self
        txtWarrentenr.delegate = self
        txtCarPck.delegate = self
        txtCarPckTenure.delegate = self
        
        invoicePicker.delegate = self
        invoicePicker.dataSource = self
        
        txtPurchasedFrm.inputView = invoicePicker
        txtCarPck.inputView = invoicePicker
        txtCarPckTenure.inputView = invoicePicker
        txtWarrentenr.inputView = invoicePicker
        
        maivc.view .addSubview(invoicePicker)
        invoicePicker.isHidden = false
        
        // Do any additional setup after loading the view.
         addTopView()
        self.addBottomView()
    
    }
    
    //TopView
    func addTopView(){
        topview = TopViewController(title: "Register Product", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    //Bottom View
    func addBottomView(){
        bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnAddAplinc.isSelected = true
        self.view.addSubview(bottomView.view)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        active_txtField = textField
        switch textField {
        case txtPurchasedFrm:
            
        currentArr = arrpurchaseFrm
        
        print("dsds")
        case txtWarrentenr:
            
         currentArr = arrwarntyTenure
            
         print("dsds")
            
        case txtCarPck:
            
            currentArr = arrCarPackSprt
            print("dsds")
            
        case txtCarPckTenure:
            
            currentArr = arrCarPackTenure
            print("dsds")
    
            //current_arr = Manufecture
            
        default:
            print("default")
        }
        
        invoicePicker .reloadAllComponents()
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickBackVW(sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    //AttachDocument Method
    @IBAction func clicktoAttachFileInvoice(sender: AnyObject)
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
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
            self.spinnerActivity.label.text = "Uploading Please wait..."
        })
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userPhotoImageView.contentMode = .scaleToFill
            imagePicker?.sourceType = UIImagePickerControllerSourceType.camera
            
            userPhotoImageView.image = pickedImage
            userPhotoImageView.contentMode = UIViewContentMode.scaleAspectFit
            /* DispatchQueue.main.async(execute: {() -> Void in
             self.VWPopEntrDocumentNMBG.isHidden = false
             self.txtDocumentName.delegate = self
             })*/
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
        MBProgressHUD.hide(for: self.view!, animated: true)
        
    }
    
    /*do Manufacture list*/
    func doPostManufactureApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        Token = userDefault.string(forKey: "UserToken")!
        print("print Token",Token)
        
        txtCategory = userDefault.string(forKey: "txtCategory")!
        print (txtCategory)
        txtSubCatID = userDefault.string(forKey: "txtSubCatID")!
        print (txtSubCatID)
        txtManufacture = userDefault.string(forKey: "txtManufacture")!
        print (txtManufacture)
        txtmodel = userDefault.string(forKey: "txtmodel")!
        print (txtmodel)
        txtSerialNM = userDefault.string(forKey: "txtSerialNM")!
        print (txtSerialNM)
        txtDAte = userDefault.string(forKey: "txtDAte")!
        txtlocation = userDefault.string(forKey: "txtlocation")!
        txtcustomLocation = userDefault.string(forKey: "txtcustomLocation")!
        txtNameTAg = userDefault.string(forKey: "txtNameTAg")!
        txtInvoiceNo1 = userDefault.string(forKey: "txtInvoiceNo")!
        txtPurchasedFrm2 = userDefault.string(forKey: "txtPurchasedFrm")!
        txtWarrentenr3 = userDefault.string(forKey: "txtWarrentenr")!
        txtCarPck4 = userDefault.string(forKey: "txtCarPck")!
        txtCarPckTenure5 = userDefault.string(forKey: "txtCarPckTenure")!
        print (txtCarPckTenure5)
        
        // print(strBase64 ?? 09)
        
        var myurl: URL!
        myurl = NSURL(string:POST_Upload_Appliances_Document_API)! as URL;
        let request = NSMutableURLRequest(url:myurl! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        var imageData: NSData?
        
        if userPhotoImageView.image == nil
        {
             param = [
                "userId" : user_id,
                "tokenId" : Token,
                "appliance_document" : "",
                "category" : txtCategory,
                "subCategory" : txtSubCatID,
                "manufacturer" : txtManufacture,
                "model_no" : txtmodel,
                "serial_no" : txtSerialNM,
                "date_of_parched" : txtDAte,
                "location_tag" : txtlocation,
                "custom_location" : txtcustomLocation,
                "name_tag" : txtNameTAg,
                "invoice_no" : txtInvoiceNo1,
                "purchased_from" : txtPurchasedFrm2,
                "warranty_tenure" : txtWarrentenr3,
                "carePack" : txtCarPck4,
                "carePack_tenure" : txtCarPckTenure5,
                "image_extension" : ".png"
                ] as [String : AnyObject]
        }
        else
        {
            
            let jpegCompressionQuality: CGFloat = 0.2 //Set this to whatever suits your purpose
            let strBase64 = UIImageJPEGRepresentation(userPhotoImageView.image!, jpegCompressionQuality)?.base64EncodedString()
            
            imageData = UIImagePNGRepresentation(userPhotoImageView.image!) as NSData?

             param = [
                "userId" : user_id,
                "tokenId" : Token,
                "appliance_document" : strBase64!,
                "category" : txtCategory,
                "subCategory" : txtSubCatID,
                "manufacturer" : txtManufacture,
                "model_no" : txtmodel,
                "serial_no" : txtSerialNM,
                "date_of_parched" : txtDAte,
                "location_tag" : "",
                "custom_location" : "",
                "name_tag" : txtNameTAg,
                "invoice_no" : txtInvoiceNo1,
                "purchased_from" : txtPurchasedFrm2,
                "warranty_tenure" : txtWarrentenr3,
                "carePack" : txtCarPck4,
                "carePack_tenure" : txtCarPckTenure5,
                "image_extension" : ".png"
                ] as [String : AnyObject]
        }
        
         print(param)
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if(imageData==nil)
        {
            
            displayAlertMessagae(userMessage: "Please upload images")
            return;
        }
        
        request.httpBody = createBodyWithParameters(param: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
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
                                                        let snackbar = TTGSnackbar.init(message: "Appliance added Successfully", duration: .middle)
                                                        snackbar.show()
                                                        
                                                        MBProgressHUD.hide(for: self.view!, animated: true)
                                                        self.userPhotoImageView.image = nil;
                                                        
                                                         DashBrdViewController.createHomeViewController()
                                                    });
                                                    
                                                } else if let error = error {
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
        body.appendString(string: "upload_document")
        
        return body
        
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
   /* func doPostManufactureApi()
    {
     
        let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose
        let strBase64 = UIImageJPEGRepresentation(userPhotoImageView.image!, jpegCompressionQuality)?.base64EncodedString()
     
         txtCategory = userDefault.string(forKey: "txtCategory")!
        print (txtCategory)
         txtSubCatID = userDefault.string(forKey: "txtSubCatID")!
        print (txtSubCatID)
         txtManufacture = userDefault.string(forKey: "txtManufacture")!
        print (txtManufacture)
         txtmodel = userDefault.string(forKey: "txtmodel")!
        print (txtmodel)
         txtSerialNM = userDefault.string(forKey: "txtSerialNM")!
        print (txtSerialNM)
        txtDAte = userDefault.string(forKey: "txtDAte")!
         txtlocation = userDefault.string(forKey: "txtlocation")!
        txtcustomLocation = userDefault.string(forKey: "txtcustomLocation")!
         txtNameTAg = userDefault.string(forKey: "txtNameTAg")!
        txtInvoiceNo1 = userDefault.string(forKey: "txtInvoiceNo")!
        txtPurchasedFrm2 = userDefault.string(forKey: "txtPurchasedFrm")!
         txtWarrentenr3 = userDefault.string(forKey: "txtWarrentenr")!
         txtCarPck4 = userDefault.string(forKey: "txtCarPck")!
         txtCarPckTenure5 = userDefault.string(forKey: "txtCarPckTenure")!
        print (txtCarPckTenure5)

        user_id = userDefault.string(forKey: "user_id")!
       // UserToken = userDefault.string(forKey: "UserToken")!
        
        print (user_id)
        
        Token = userDefault.string(forKey: "UserToken")!
        print("print Token",Token)
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_SAVE_APPLIANCES_API)! as URL)
        request.httpMethod = "POST"
        
        
        let postString = "category=\(String(describing: txtCategory))&userId=\(String(describing: user_id))&subCategory=\(String(describing: txtSubCatID))&manufacturer=\(String(describing: txtManufacture))&model_no=\(String(describing: txtmodel))&serial_no=\(String(describing: txtSerialNM))&date_of_parched=\(String(describing: txtDAte))&location_tag=\(String(describing: txtlocation))&custom_location=\(String(describing: txtcustomLocation))&name_tag=\(String(describing: txtNameTAg))&tokenId=\(Token)&invoice_no=\(String(describing: txtInvoiceNo1))&purchased_from=\(String(describing: txtPurchasedFrm2))&warranty_tenure=\(String(describing: txtWarrentenr3))&carePack=\(String(describing: txtCarPck4))&carePack_tenure=\(String(describing: txtCarPckTenure5))&appliance_document=\(String(describing: strBase64!))&image_extension=\(String(describing: ".png"))"
        
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
                        
                        DispatchQueue.main.async {
                      
                            let snackbar = TTGSnackbar.init(message: "Appliance added Successfully", duration: .middle)
                            snackbar.show()
                            DashBrdViewController.createHomeViewController()
                        }
                    }
                    else{
                    
                    }
                    
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
    }*/
    
    @IBAction func clickDashBoardVW(sender: AnyObject)
    {
       
        if (txtInvoiceNo.text?.isEmpty)! || (txtPurchasedFrm.text?.isEmpty)! || (txtWarrentenr.text?.isEmpty)! || (txtCarPck.text?.isEmpty)!
        {
            displayAlertMessagae(userMessage: "Please select all the fields.")
        }else{
            
            let defaults = UserDefaults.standard
            defaults.set(txtInvoiceNo.text, forKey: "txtInvoiceNo")
            print(txtInvoiceNo.text)
            
            defaults.set(txtPurchasedFrm.text, forKey: "txtPurchasedFrm")
            
            print(txtPurchasedFrm.text)
            
            defaults.set(txtWarrentenr.text, forKey: "txtWarrentenr")
            print(txtWarrentenr.text)
            
            defaults.set(txtCarPck.text, forKey: "txtCarPck")
            
            print(txtCarPck.text)
            
            defaults.set(txtCarPckTenure.text, forKey: "txtCarPckTenure")
            
            print(txtCarPckTenure.text)
            
            defaults.synchronize()
            doPostManufactureApi()
        }
        
        /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashBrdViewController") as! DashBrdViewController
        self.navigationController?.pushViewController(newViewController, animated: true)*/
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
