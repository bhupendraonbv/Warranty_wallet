//
//  ScanInvoiceViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 25/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit


enum ImageFormat{
    case Unknown, PNG, JPEG, GIF, TIFF
}
class ScanInvoiceViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,iCarouselDataSource,iCarouselDelegate,TopviewDelegate {

    
    @IBOutlet weak var scrllScanAll : UIScrollView!
    @IBOutlet weak var VWScanAll : UIView!
    @IBOutlet weak var btnslidescan : UIButton!
    var xposition : CGFloat = 0
    
     @IBOutlet weak var userPhotoImageView: UIImageView!
    var user_id = String()
    var UserToken = String()
    var dict = String()
    var userDefault = UserDefaults.standard
    var bottomView = BottomViewViewController()
    
    var imgBytes = String()
    
   // var param = Dictionary<String, AnyObject>()
    
    var param = Dictionary<String, AnyObject>()
    var compressUploadImage: UIImage!
    var imagePicker:UIImagePickerController?=UIImagePickerController()
    var bytes64 = String()
    var spinnerActivity: MBProgressHUD = MBProgressHUD()
    
    @IBOutlet weak var btncustmTag : UIButton!
    
    @IBOutlet weak var VWPopEntrDocumentNMBG : UIView!
    @IBOutlet weak var txtDocumentName : UITextField!
    @IBOutlet weak var btnCancelPOP : UIButton!
    @IBOutlet weak var btnOKAyPop : UIButton!
    var strDocumentName = String()
     @IBOutlet weak var VWPopForUploadDocument : UIView!
    
    @IBOutlet var carousel: iCarousel!
    var items: [Int] = []
    var titleArrayName = Array<String>()
    
     @IBOutlet weak var btnDot1 : UIButton!
     @IBOutlet weak var btnDot2 : UIButton!
     @IBOutlet weak var btnDot3 : UIButton!
     var topview:TopViewController!
    
    var strUserNameDashboard = String()
    @IBOutlet weak var lblHdrStr : UILabel!
    
    @IBOutlet weak var VWgrdntBG : UIView!
    
     var InsideArrayName = Array<String>()
    
    @IBOutlet weak var lblDownSliderHdr : UILabel!
     @IBOutlet weak var lblDownSliderDesc : UILabel!
    
    @IBOutlet weak var btnRegister : UIButton!
    @IBOutlet weak var btnScan : UIButton!
    @IBOutlet weak var btnRegisterForAMC : UIButton!
    @IBOutlet weak var btnUpload : UIButton!

    
    @IBOutlet weak var txtEntPopDocumentNam : UITextField!
    
    @IBAction func dismiss(sender: AnyObject)
    {
        self.dismiss(animated: true, completion: nil)
    
    }
    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        let currentIndex: Int = carousel.currentItemIndex
        print("currentValue =\(currentIndex)")
        
        if currentIndex == 0
        {
           
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                imagePicker?.delegate = self
                
                imagePicker?.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker?.allowsEditing = true
                
                self.present(imagePicker!, animated: true, completion: nil)
                
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when){
                    self.VWPopEntrDocumentNMBG.isHidden = false
                    self.txtDocumentName.delegate = self
                }
                //DispatchQueue.main.async {
                //}
                
            }
            else
            {
                let alert:UIAlertController = UIAlertController(title: "Camera Unavailable", message: "Unable to find a camera on this device", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                alert.view.tintColor = UIColor(red:0.37, green:0.66, blue:0.44, alpha:1.0)
                self.present(alert, animated: true, completion: nil)
            }
        }
        else if currentIndex == 1
        {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterDeviceViewController") as! RegisterDeviceViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
            
        else if currentIndex == 2
        {
            //Temp Comment
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AMCAggrementController") as! AMCAggrementController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
            
        else{
            print("iCraousel")
        }
        
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        var itemView: UIImageView
        
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
            //get a reference to the label in the recycled view
            label = itemView.viewWithTag(1) as! UILabel
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
            let strUrl = titleArrayName[index]
           
            //InsideItem.image = UIImage(name: "AddManualIcon")
            itemView.image = UIImage(named: strUrl)
            itemView.contentMode = .center
            
            label = UILabel(frame: itemView.bounds)
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.font = label.font.withSize(50)
            label.tag = 1
            itemView.addSubview(label)
            
        }
        
        return itemView
    }
    
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 2.1     // 1.1
        }
        
        let Activeimage = UIImage(named:"DotNewSelected")
        let Inactiveimage = UIImage(named:"DotNewIcon")
        
        
        let currentIndex: Int = carousel.currentItemIndex
        print("currentValue =\(currentIndex)")
        
        
        if currentIndex == 0
         {
            print ("Index --0")
            lblDownSliderHdr.text? = "Scan your Invoice"
            lblDownSliderDesc.text? = "Click to scan or upload your Invoice /Warranty/ AMC. We will add it to your dashboard in 24-48 hours."
            strUserNameDashboard = "Scan"
            
            topview.lblTitle.text? = strUserNameDashboard
            
            btnDot1.setImage(UIImage(named: "DotNewSelected")!, for: UIControlState.normal)
            btnDot2.setImage(UIImage(named: "DotNewIcon")!, for: UIControlState.normal)
            btnDot3.setImage(UIImage(named: "DotNewIcon")!, for: UIControlState.normal)
            
            btnScan.isHidden = false
            btnUpload.isHidden = false
            btnRegisterForAMC.isHidden = true
            btnRegister.isHidden = true
            
        }
        else if currentIndex == 1
        {
             print ("Index --1")
            lblDownSliderHdr.text?  = "Register a Product"
            strUserNameDashboard = "Register a Product"
            topview.lblTitle.text? = strUserNameDashboard
            
            lblDownSliderDesc.text? = "Click to manually add details of your Invoice / Warranty. We will add it to your dashboard in 24-48 hours."
            btnDot1.setImage(UIImage(named: "DotNewIcon")!, for: UIControlState.normal)
            btnDot2.setImage(UIImage(named: "DotNewSelected")!, for: UIControlState.normal)
            btnDot3.setImage(UIImage(named: "DotNewIcon")!, for: UIControlState.normal)
            
            btnScan.isHidden = true
            btnUpload.isHidden = true
            btnRegisterForAMC.isHidden = true
            btnRegister.isHidden = false
            
        }
        
        else if currentIndex == 2
        {
             print ("Index --2")
            lblDownSliderHdr.text?  = "Register An AMC"
            
            lblDownSliderDesc.text? = "Click to manually add details of your AMC. We will add it to your dashboard in 24-48 hours."
            strUserNameDashboard = "Add AMC"
            topview.lblTitle.text? = strUserNameDashboard
            btnDot1.setImage(UIImage(named: "DotNewIcon")!, for: UIControlState.normal)
            btnDot2.setImage(UIImage(named: "DotNewIcon")!, for: UIControlState.normal)
            btnDot3.setImage(UIImage(named: "DotNewSelected")!, for: UIControlState.normal)
            
            btnScan.isHidden = true
            btnUpload.isHidden = true
            btnRegisterForAMC.isHidden = false
            btnRegister.isHidden = true
            
        }
        else
        {
            
        }
        
        return value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.titleArrayName = ["scan_icon","add_icon","upload_icon"]
        
        btnUpload.layer.cornerRadius = 22
        btnRegister.layer.cornerRadius = 22
        btnScan.layer.cornerRadius = 22
        btnRegisterForAMC.layer.cornerRadius = 22
        
        self.txtDocumentName.delegate = self
        
        self.txtEntPopDocumentNam.delegate = self

        for i in 0 ... 99 {
            items.append(i)
        }
        
        //.coverFlow2
       // carousel.type = .coverFlow
       carousel.type = .linear
        carousel.delegate = self as! iCarouselDelegate
        carousel.dataSource = self as! iCarouselDataSource
        

        scrllScanAll.delegate = self

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .left
        //self.view.addGestureRecognizer(swipeRight)
   
        lblHdrStr.text?  = ""
        
        addTopView()
        setGradientBackground()
        addBottomView()
        
    }
    
    @IBAction func clickDownTapRegisterbtnAMC(sender: AnyObject)
    
    {
        //Temp Comment
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AMCAggrementController") as! AMCAggrementController
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    
    
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 19.0/255.0, green: 84.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 128.0/255.0, green: 209.0/255.0, blue: 199.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.VWgrdntBG.bounds
        
        self.VWgrdntBG.layer.addSublayer(gradientLayer)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        /*let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: btnUpload.center.x - 10, y: btnUpload.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: btnUpload.center.x + 10, y: btnUpload.center.y))
        btnUpload.layer.add(animation, forKey: "position")*/
    }
    
    //TopView
    func addTopView(){
        
        print("Top User Name",strUserNameDashboard)
        topview = TopViewController(title: strUserNameDashboard, menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70)
        topview.topBGVW.backgroundColor = UIColor .clear
        topview.btnMenu.isHidden = true
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    //Bottom View
    func addBottomView(){
        bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.bottomView.btnAddAplinc.isUserInteractionEnabled = false
        self.bottomView.btnAddAplinc.isSelected = true
        self.view.addSubview(bottomView.view)
    }
    
    //Gesture code
    func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTUploadFileViewController") as! WTUploadFileViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.up {
            print("Swipe Up")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.down {
            print("Swipe Down")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Device Register View
    @IBAction func clickDeviceRegister(sender: AnyObject)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterDeviceViewController") as! RegisterDeviceViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    //Camera open code for click action
   @objc @IBAction func clickCameraOpen(sender: AnyObject)
    {
        if sender.tag == 1001
        {
            print("tag 1001")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                imagePicker?.delegate = self
                
                imagePicker?.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker?.allowsEditing = true
                
                self.present(imagePicker!, animated: true, completion: nil)
                
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when){
                    self.VWPopEntrDocumentNMBG.isHidden = false
                    self.txtDocumentName.delegate = self
                }
                //DispatchQueue.main.async {
                //}
                
            }
            else
            {
                let alert:UIAlertController = UIAlertController(title: "Camera Unavailable", message: "Unable to find a camera on this device", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                alert.view.tintColor = UIColor(red:0.37, green:0.66, blue:0.44, alpha:1.0)
                self.present(alert, animated: true, completion: nil)
            }
            
            
            
        }
            
        else if sender.tag == 2002
        {
            print("upload tag 2002")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                imagePicker?.delegate = self
                imagePicker?.sourceType = UIImagePickerControllerSourceType.photoLibrary
                imagePicker?.allowsEditing = true
                self.present(imagePicker!, animated: true, completion: nil)
             
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when){
                    self.VWPopForUploadDocument.isHidden = false
                    self.txtDocumentName.delegate = self
                }
                
            }
            else
            {
                let alert:UIAlertController = UIAlertController(title: "Camera Unavailable", message: "Unable to find a camera on this device", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                alert.view.tintColor = UIColor(red:0.37, green:0.66, blue:0.44, alpha:1.0)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        else{
            
        }
    
    }
    
    //ImagePicker code.
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userPhotoImageView.contentMode = .scaleToFill
            imagePicker?.sourceType = UIImagePickerControllerSourceType.camera
            
            userPhotoImageView.image = pickedImage
            userPhotoImageView.contentMode = UIViewContentMode.scaleAspectFit
           
        }
        
        picker.dismiss(animated: true, completion: nil)
       
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        print("cancel")
        self.VWPopForUploadDocument.isHidden = true
        self.VWPopEntrDocumentNMBG.isHidden = true

        picker.dismiss(animated: true, completion: nil)
    
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("pathfile-->",paths)
        return paths[0]
    }
    
    //Document Pop Up button click.
    @IBAction func clickDocumentPopOKbtnhit(sender: AnyObject){
        
        if sender.tag == 1001
        {
            print("tag", 1001)
            
            if txtEntPopDocumentNam.text?.isEmpty == true
            {
                displayAlertMessagae(userMessage: "Please enter Document Name")
                return
            }
            
            self.VWPopEntrDocumentNMBG.isHidden = true
            view.endEditing(true)
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.MyImageUploadRequest()
                self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
                self.spinnerActivity.label.text = "Uploading Please wait..."
            })
        }
        
        else if sender.tag == 2002
        {
            print("tag",2002)
            
            print("print",txtDocumentName!.text!)
            if txtDocumentName.text!.isEmpty == true
            {
                displayAlertMessagae(userMessage: "Please enter Document Name")
                return
            }
            
            self.VWPopForUploadDocument.isHidden = true
            view.endEditing(true)
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.MyUploadDocumentRequest()
                self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
                self.spinnerActivity.label.text = "Uploading Please wait..."
            })
        }
        else{}
        
    }
    
    //PopUP Cancel
    @IBAction func clickDocumentPopHideCANCEL(sender: AnyObject){
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        VWPopEntrDocumentNMBG.layer.add(transition, forKey: nil)
        VWPopEntrDocumentNMBG.isHidden = true
        VWPopForUploadDocument.isHidden = true
        
    }
    
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Image saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    // step 2
    
    func percentEscapeString(string: String) -> String {
        return CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                       string as CFString,
                                                       nil,
                                                       ":/?@!$&'()*+,;=" as CFString,
                                                       CFStringBuiltInEncodings.UTF8.rawValue) as! String;
    }
    
    //Scan Service Request here..
  func MyImageUploadRequest()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
       // strDocumentName = txtDocumentName.text!
        strDocumentName = txtEntPopDocumentNam.text!
        
        let imageData = UIImagePNGRepresentation(userPhotoImageView.image!) as NSData?
        let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose
        let strBase64 = UIImageJPEGRepresentation(userPhotoImageView.image!, jpegCompressionQuality)?.base64EncodedString()
        //let imageStr = imageData?.base64EncodedString()
        
        var myurl: URL!
        myurl = NSURL(string: POST_SCAN_APPLIANCES_UPLOAD_SERVER_API)! as URL;
        let request = NSMutableURLRequest(url:myurl! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let param = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&scan_appliance=\(String(describing: percentEscapeString(string: strBase64!)))&tagname=\(String(describing: strDocumentName))&image_extension=\(String(describing: ".png"))"
        
        request.httpBody = param.data(using: String.Encoding.utf8)
       
        
        if(imageData==nil)  { return; }
        
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
                                                        let snackbar = TTGSnackbar.init(message: "Image Scan Successfully", duration: .middle)
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
    
    //Upload Service Request here..
    func MyUploadDocumentRequest()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
       // strDocumentUploadName = txtDocumentName.text!
        
        let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose
        let strBase64 = UIImageJPEGRepresentation(userPhotoImageView.image!, jpegCompressionQuality)?.base64EncodedString()
        // print(strBase64 ?? 09)
        
        var myurl: URL!
        myurl = NSURL(string:"http://13.127.90.30/walletWebApi/appliance/scanAppliance.php")! as URL;
        let request = NSMutableURLRequest(url:myurl! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        let imageData = UIImagePNGRepresentation(userPhotoImageView.image!) as NSData?
        
        let param = [
            "userId" : user_id,
            "tokenId" : UserToken,
            "tagname" : strDocumentName,
            "upload_appliance" : strBase64!,
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
                                                    // you can use data here
                                                    // Print out reponse body
                                                    
                                                    let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                                                    print("****** response data = \(responseString!)")
                                                    
                                                    let json = try!JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                                                    
                                                    print("json value \(String(describing: json))")
                                                    
                                                    DispatchQueue.main.async(execute: {
                                                        let snackbar = TTGSnackbar.init(message: "Image Upload Successfully", duration: .middle)
                                                        snackbar.show()
                                                        
                                                        MBProgressHUD.hide(for: self.view!, animated: true)
                                                        self.userPhotoImageView.image = nil;
                                                        DashBrdViewController.createHomeViewController()
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
    
    /*Generic Alert Method*/
    func displayAlertMessagae(userMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}


extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

extension String {
    func getPathExtension() -> String {
        return (self as NSString).pathExtension
    }
}

extension UIImageView {
    public func image(fromUrl urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Couldn't create URL from \(urlString)")
            return
        }
        let theTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: response)
                }
            }
        }
        theTask.resume()
    }
}



