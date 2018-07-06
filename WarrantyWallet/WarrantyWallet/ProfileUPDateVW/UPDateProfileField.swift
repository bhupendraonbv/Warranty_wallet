//
//  UPDateProfileField.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 05/05/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class UPDateProfileField: UIViewController,TopviewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

     @IBOutlet weak var grdntVWBG: UIView!
     var bottomView = BottomViewViewController()
     var topview:TopViewController!
    
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var vwphoneNM: UIView!
    @IBOutlet weak var vwSocila: UIView!
    @IBOutlet weak var vwSName: UIView!
    
    
    
    
    
    @IBOutlet weak var txtFirstName : UITextField!
    @IBOutlet weak var txtLstName : UITextField!
    @IBOutlet weak var txtEmail : UITextField!
    @IBOutlet weak var txtPhoneNm : UITextField!
    @IBOutlet weak var txtSocialConct : UITextField!
   
    @IBOutlet weak var imgUserProfile : UIImageView!
    
    var strImageUrl = String()
    var imagePicker:UIImagePickerController?=UIImagePickerController()
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var userDefault = UserDefaults.standard
    var spinnerActivity: MBProgressHUD = MBProgressHUD()
    var mainArr = NSMutableArray()
    var btnSelected:String!
    var strGender = String()
    
     var UPdateMainDict = NSDictionary()
    
     var AlertstrMsg = String()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (UPdateMainDict)
        
        setGradientBackground()
        addBottomView()
        addTopView()
        
        vwEmail.layer.cornerRadius = 10
        vwphoneNM.layer.cornerRadius = 10
        vwSocila.layer.cornerRadius = 10
        vwSName.layer.cornerRadius = 10
        
        imgUserProfile.layer.borderWidth = 1
        imgUserProfile.layer.masksToBounds = false
        imgUserProfile.layer.borderColor = UIColor .white .cgColor
        imgUserProfile.layer.cornerRadius = imgUserProfile.frame.height/2
        imgUserProfile.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool)
    {
        
        let dic = NSDictionary()
        let total = UPdateMainDict.allKeys.count
        if total > 0 {
            
            // Something's in there
            txtFirstName.text? = UPdateMainDict.value(forKey: "first_name") as! String
            txtEmail.text? = UPdateMainDict.value(forKey: "user_email") as! String
            txtPhoneNm.text? = UPdateMainDict.value(forKey: "user_phone") as! String
            // txtSocialConct.text? = ReceiveMainDict.value(forKey: "first_name") as! String
            self.strImageUrl = UPdateMainDict.value(forKey: "user_image") as! String
            self.imgUserProfile?.setImageEditProfileFromURl(stringImageUrl: self.strImageUrl)
        }
            
        else {
            // Nothing in there
            print("Dic key nill")
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Gradient BackView
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 84.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 128.0/255.0, green: 209.0/255.0, blue: 199.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.grdntVWBG.bounds
        
        self.grdntVWBG.layer.addSublayer(gradientLayer)
        
    }
    
    //Bottom View
    func addBottomView(){
        // bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnServc.isUserInteractionEnabled = false
        self.view.addSubview(bottomView.view)
    }

    //Top View
    func addTopView(){
        topview = TopViewController(title: "Edit Profile", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        topview.topBGVW.backgroundColor = UIColor .clear
        
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    @IBAction func clickSaveUserDataEditField(sender: AnyObject){
        // doPostEDITUpadetProfileApi()
    
         //self.displayAlertMessagae(userMessage: "Please check service request data")
         MyImageUploadRequest()
        
    }
    
    //Edit Profile api
    func doPostEDITUpadetProfileApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_EDIT_UPDATE_PROFILE_API)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
       
        if imgUserProfile.image == nil{
            
            return
            
        }
        
            let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&first_name=\(String(describing: txtFirstName.text!))&last_name=\(String(describing: txtEmail.text!))&image_extension=\(String(describing: ".png"))&profile_image=\(String(describing: imgUserProfile.image!))&gender=\(String(describing: ""))&email=\(String(describing: txtEmail.text!))&mobile=\(String(describing: txtPhoneNm.text!))"
        
        
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
                    
                     self.AlertstrMsg = (dictFromJSON["msg"] as? String)!
                    
                    if (self.dict == "1")
                    {
                        //arrCategoryList
                        self.mainArr = NSMutableArray()
                        self.mainArr = (dictFromJSON["data"] as? NSMutableArray)!
                        print(self.mainArr)
                        
                        DispatchQueue.main.async(execute: {
                            self.displayAlertMessagae(userMessage: self.AlertstrMsg)
                        })
                        
                    }
                    
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
        
    }
    
    @IBAction func clicktoSelectUserImage(sender: AnyObject){
        print ("You Select User image")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
        {
            // let imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker?.delegate = self
            imagePicker?.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker?.allowsEditing = false
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
        picker.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgUserProfile!.contentMode = .scaleToFill
            imgUserProfile!.image = pickedImage
            print("userSelect-->Img",imgUserProfile!.image!)
            
            /*DispatchQueue.main.async(execute: {() -> Void in
             self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
             self.spinnerActivity.label.text = "Loading.."
             })*/
            
             MyImageUploadRequest()
        }
        
        /*DispatchQueue.main.async(execute: {() -> Void in
         MBProgressHUD.hide(for: self.view!, animated: true)
         self.spinnerActivity.label.text = "Loading.."
         })*/
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("pathfile-->",paths)
        return paths[0]
    }
    
    
    func MyImageUploadRequest()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        
        let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose
        let strBase64 = UIImageJPEGRepresentation(imgUserProfile.image!, jpegCompressionQuality)?.base64EncodedString()
        
        var myurl: URL!
        myurl = NSURL(string: POST_EDIT_UPDATE_PROFILE_API)! as URL;
        let request = NSMutableURLRequest(url:myurl! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let imageData = UIImagePNGRepresentation(imgUserProfile.image!) as NSData?
        
        let param = [
            "userId" : user_id,
            "tokenId" : UserToken,
            "gender" : "",
            "first_name" :txtFirstName.text!,
            "last_name" : " ",
            "profile_image" : strBase64!,
            "mobile" : txtPhoneNm.text!,
            "email" : txtEmail.text!,
            
            "image_extension" : ".png"
            ] as [String : AnyObject]
        
        // print(param)
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(param: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        let task =  URLSession.shared.dataTask(with: request as URLRequest,
                                               completionHandler: {
                                                (data, response, error) -> Void in
                                                if let data = data {
                                                    // You can print out response object
                                                    print("******* response = \(String(describing: response))")
                                                    print(data.count)
                                                    
                                                    let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                                                    print("****** response data = \(responseString!)")
                                                    
                                                    let json = try!JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                                                    
                                                    print("json value \(String(describing: json))")
                                                    
                                                    DispatchQueue.main.async(execute: {
                                                        MBProgressHUD.hide(for: self.view!, animated: true)
                                                        //self.imgUserProfile.image = nil;
                                                        //DashBrdViewController.createHomeViewController()
                                                   
                                                    self.displayAlertMessagae(userMessage: "Profile Update Successfully.")
                                                    
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
        body.appendString(string: "upload_appliance")
        
        return body
        
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
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
