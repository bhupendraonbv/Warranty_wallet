//
//  AMCEditFieldView.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 19/02/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class AMCEditFieldView: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var txtAMCTAgNAme: UITextField!
    @IBOutlet weak var txtAMCPurchsDate: UITextField!
    @IBOutlet weak var txtAmcTenure: UITextField!
    @IBOutlet weak var txtAMCPrvdrName: UITextField!
    @IBOutlet weak var txtAMCPrvdrNumb: UITextField!
    @IBOutlet weak var vwBGEditTxt: UIView!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var dict = String()
    
    var strAmciD  = String()
    var commonmsgStr = String()
    var strBase64 = String()
    var postString = String()
   
    
    var bottomView = BottomViewViewController()
    var topview:TopViewController!
    var ArrGetEditAMCDetails = NSMutableArray()
    var spinnerActivity: MBProgressHUD = MBProgressHUD()
    var imagePicker:UIImagePickerController?=UIImagePickerController()
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        vwBGEditTxt.layer.cornerRadius = 2.0
        vwBGEditTxt.layer.borderWidth = 1.5
        
        
         txtAMCTAgNAme.text = (ArrGetEditAMCDetails.object(at: 0) as AnyObject).value(forKey: "amc_tag_name") as? String
        
        txtAMCPurchsDate.text = (ArrGetEditAMCDetails.object(at: 0) as AnyObject).value(forKey: "amc_date_of_parched") as? String
        
       txtAmcTenure.text = (ArrGetEditAMCDetails.object(at: 0) as AnyObject).value(forKey: "amc_tenure") as? String
        
         txtAMCPrvdrName.text = (ArrGetEditAMCDetails.object(at: 0) as AnyObject).value(forKey: "amc_provider_name") as? String
        
        txtAMCPrvdrNumb.text = (ArrGetEditAMCDetails.object(at: 0) as AnyObject).value(forKey: "amc_provider_name") as? String
        
        strAmciD = ((ArrGetEditAMCDetails.object(at: 0) as AnyObject).value(forKey: "amc_id") as? String)!
        
        
        addTopView()
        addBottomView()
    
    }
    
    //Bottom View
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.view.addSubview(bottomView.view)
    }
    
    //Top View
    func addTopView(){
        topview = TopViewController(title: "AMCs Details", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    //DocumentAdd code here ...
    @IBAction func clickAddDocumntAMCField(sender: AnyObject){
        // self.usrMake_EditField()
      
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
            userPhotoImageView.contentMode = .scaleToFill
            
            userPhotoImageView.image = pickedImage
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
                self.spinnerActivity.label.text = "Uploading Please wait..."
            })
            
            let imageData = UIImagePNGRepresentation(userPhotoImageView.image!) as NSData?
            let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose
            strBase64 = (UIImageJPEGRepresentation(userPhotoImageView.image!, jpegCompressionQuality)?.base64EncodedString())!
            
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func clickToSaveBtnAMCUpdate(sender: AnyObject){
        // self.usrMake_EditField()
        
        DispatchQueue.main.async(execute: {() -> Void in                                                                                   self.doPostAMCUpdateApi()
        })
        
    }
    
    
    // Please open last comment api
   @objc func doPostAMCUpdateApi()
    {
     self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
     self.spinnerActivity.label.text = "Loading..."
     
     var TempTagName = String()
     TempTagName = (txtAMCTAgNAme.text)!
     
     var TempAMCPurchsDate = String()
     TempAMCPurchsDate = (txtAMCPurchsDate.text)!
     
     var TempAMCTenure = String()
     TempAMCTenure = (txtAmcTenure.text)!
     
     
     var TempAMCPrvdrName = String()
     TempAMCPrvdrName = (txtAMCPrvdrName.text)!
     
     var TempAMCNumb = String()
     TempAMCNumb = (txtAMCPrvdrNumb.text)!
     
     
     user_id = userDefault.string(forKey: "user_id")!
     UserToken = userDefault.string(forKey: "UserToken")!
     
        let request = NSMutableURLRequest(url: NSURL(string: POST_AMC_FIELD_UPDATE_API)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        if strBase64.isEmpty
        {
            postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&amc_id=\(String(describing: strAmciD))&amc_tag_name=\(String(describing: TempTagName))&amc_date_of_parched=\(String(describing: TempAMCPurchsDate))&amc_tenure=\(String(describing: TempAMCTenure))&amc_provider_name=\(String(describing: TempAMCPrvdrName))&amc_provider_number=\(String(describing: TempAMCNumb))&amc_document=\(String(describing: ""))&image_extension=\(String(describing: ""))"
        }else{
             postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&amc_id=\(String(describing: strAmciD))&amc_tag_name=\(String(describing: TempTagName))&amc_date_of_parched=\(String(describing: TempAMCPurchsDate))&amc_tenure=\(String(describing: TempAMCTenure))&amc_provider_name=\(String(describing: TempAMCPrvdrName))&amc_provider_number=\(String(describing: TempAMCNumb))&amc_document=\(String(describing: strBase64))&image_extension=\(String(describing: ".png"))"
            
        }
        
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
    print("*****responseString data = \(String(describing: responseString))")
     
     do
     {
    
     let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
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
    
    //Alert Message here..
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
