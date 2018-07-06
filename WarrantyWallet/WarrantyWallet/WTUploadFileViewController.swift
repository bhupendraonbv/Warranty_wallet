//
//  WTUploadFileViewController.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 26/12/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WTUploadFileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    var imagePicker:UIImagePickerController?=UIImagePickerController()
    @IBOutlet weak var userUploadImageView: UIImageView!
    var user_id = String()
    var UserToken = String()
    var userDefault = UserDefaults.standard
    var bottomView = BottomViewViewController()
    var spinnerActivity: MBProgressHUD = MBProgressHUD()
    
    @IBOutlet weak var VWPopEntrDocument : UIView!
    @IBOutlet weak var txtDocumentName : UITextField!
    @IBOutlet weak var btnCancelPOP : UIButton!
    @IBOutlet weak var btnOKAyPop : UIButton!
    var strDocumentUploadName = String()
    
    @IBOutlet weak var btnuploadGallary : UIButton!
    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        // RegstrPickVW.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        // Do any additional setup after loading the view.
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: btnuploadGallary.center.x - 10, y: btnuploadGallary.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: btnuploadGallary.center.x + 10, y: btnuploadGallary.center.y))
        btnuploadGallary.layer.add(animation, forKey: "position")
        
        addBottomView()
    }
    
    
    //Bottom View
    func addBottomView(){
        bottomView = BottomViewViewController()
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.view.addSubview(bottomView.view)
    }
    
    
    func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
            
            self.navigationController?.popViewController(animated: true)
            
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
            
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.up {
            print("Swipe Up")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.down {
            print("Swipe Down")
        }
    }

    
    //Device Register View
    @IBAction func DeviceRegister(sender: AnyObject)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterDeviceViewController") as! RegisterDeviceViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    @IBAction func clicktoUploadFile(sender: AnyObject)
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

                self.VWPopEntrDocument.isHidden = false
                self.txtDocumentName.delegate = self
            })
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Upload Document ..
    @IBAction func clickDocumentPopOKbtnhit(sender: AnyObject){
        
        if txtDocumentName.text?.isEmpty == true
        {
            displayAlertMessagae(userMessage: "Please enter Document Name")
            return
        }
        
        self.VWPopEntrDocument.isHidden = true
        
        view.endEditing(true)
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.MyUploadDocumentRequest()
            self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
            self.spinnerActivity.label.text = "Uploading Please wait..."
        })
        
        
    }
    
    @IBAction func clickDocumentPopHideCANCEL(sender: AnyObject){
        
        VWPopEntrDocument.isHidden = true
        
    }
    
    //Api Code here
    func MyUploadDocumentRequest()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        strDocumentUploadName = txtDocumentName.text!
        
        let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose
        let strBase64 = UIImageJPEGRepresentation(userUploadImageView.image!, jpegCompressionQuality)?.base64EncodedString()
       // print(strBase64 ?? 09)
        
        var myurl: URL!
        myurl = NSURL(string:"http://13.127.90.30/walletWebApi/appliance/scanAppliance.php")! as URL;
        let request = NSMutableURLRequest(url:myurl! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let imageData = UIImagePNGRepresentation(userUploadImageView.image!) as NSData?
        
        let param = [
            "userId" : user_id,
            "tokenId" : UserToken,
            "tagname" : strDocumentUploadName,
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
                                                        self.userUploadImageView.image = nil;
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
