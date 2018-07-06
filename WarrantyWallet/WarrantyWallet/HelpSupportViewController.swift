//
//  HelpSupportViewController.swift
//  WarrantyWallet
//  Created by ONBV-BHUPI on 05/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.

import UIKit
import MessageUI

class HelpSupportViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,TopviewDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var txtHelpQuery : UITextField!
    @IBOutlet weak var RegstrPickVW: UIPickerView!
    @IBOutlet weak var txtVwFeedback: UITextView!
    @IBOutlet weak var imgUpld: UIImageView!
    @IBOutlet weak var VWBox: UIView!
    
    var imagePicker:UIImagePickerController?=UIImagePickerController()
    
    var list = ["Please Select" , "Issue/Repair" , "Suggestion " , "Other"]
    var current_arr : [String] = []
    var active_txtField = UITextField()
    var maivc = UIViewController()
    var userDefault = UserDefaults.standard
    var user_id = String()
    var UserToken = String()
    var user_Email = String()
    var dict = String()
    var strQuery = String()
    var strFeedbackMsg = String()
    var topview:TopViewController!
    var ImgString = String()
    
    @IBOutlet weak var btnFull: UIButton!
    @IBOutlet weak var thankVW: UIView!
    @IBOutlet weak var cnclPOP : UIButton!
    
    var bottomView = BottomViewViewController()
    //@IBOutlet weak var imgUpld: uibut!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTopView()
        addBottomView()
        
        txtHelpQuery.delegate = self
        
        txtHelpQuery.inputView = RegstrPickVW
        
        maivc.view .addSubview(RegstrPickVW)
        
        RegstrPickVW.isHidden = false
        
        self.txtVwFeedback.placeholder = "Type your Message here"
        
        self.RegstrPickVW.delegate = self
        self.RegstrPickVW.dataSource = self
        
        self.view .bringSubview(toFront: btnFull)
        self.view .bringSubview(toFront: thankVW)
        
        // Do any additional setup after loading the view.
    }
    
    //Topview Custom Method...
    func addTopView(){
        topview = TopViewController(title: "Feedback", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
        //topview.topBGVW.backgroundColor = UIColor (colorLiteralRed: 47/255, green: 57/255, blue: 66/255, alpha: 1.0)
        topview.leftBack.isHidden = false
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    //Bottom View
    func addBottomView(){
        self.bottomView.view.frame = CGRect(x: 0, y: WINDOW_HEIGHT-56 , width: WINDOW_WIDTH, height: 56)
        self.view.addSubview(bottomView.view)
    }
    
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
        
        active_txtField.text = current_arr[row] as! String
        
        RegstrPickVW.reloadAllComponents();
    }
    
    //TextField Delegate method here..
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        active_txtField = textField
        switch textField {
        case txtHelpQuery:
            
        current_arr = list as! [String]
            
        default:
            print("default")
        }
        
        RegstrPickVW .reloadAllComponents()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    
    //upload document code
    @IBAction func clickUpload_Documnt(sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            // let imagePicker:UIImagePickerController = UIImagePickerController()
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
            imgUpld.contentMode = .scaleToFill
            imgUpld.image = pickedImage
            
            let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose
            let strBase64 = UIImageJPEGRepresentation(imgUpld.image!, jpegCompressionQuality)?.base64EncodedString()
            
            ImgString = strBase64!
            
            print(ImgString)
            
            DispatchQueue.main.async(execute: {() -> Void in
                // self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
                //  self.spinnerActivity.label.text = "Loading.."
            })
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func percentEscapeString(string: String) -> String {
        return CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                       string as CFString,
                                                       nil,
                                                       ":/?@!$&'()*+,;=" as CFString,
                                                       CFStringBuiltInEncodings.UTF8.rawValue) as! String;
    }
    
    /*do postcategory list*/
    func doPostHelpSupporttApi()
    {
        user_id = userDefault.string(forKey: "user_id")!
        UserToken = userDefault.string(forKey: "UserToken")!
        strQuery = txtHelpQuery.text!
        strFeedbackMsg = txtVwFeedback.text!
        user_Email = userDefault.string(forKey: "LoginEmail")!
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_HELP_SUPPORT_API)! as URL)
        request.httpMethod = "POST"
        request.setValue(ServerAuthorization, forHTTPHeaderField: "Authorization")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "Access_Token")
        
        let postString = "userId=\(String(describing: user_id))&tokenId=\(String(describing: UserToken))&support_subject=\(String(describing: strQuery))&support_message=\(String(describing: strFeedbackMsg))&support_document=\(String(describing: percentEscapeString(string: ImgString)))&image_extension=\(String(describing: ".jpg"))&email=\(String(describing: user_Email))"
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
                       
                    }
                    
                }
                
            }catch
            {
                print("error")
            }
            
        }
        
        task.resume()
        
    }

    @IBAction func clickSubmitFdBack(sender: AnyObject) {
        let helpQuery = txtHelpQuery.text
        let feedback = txtVwFeedback.text
        
        if ((helpQuery?.isEmpty)! || (feedback?.isEmpty)!)
        {
            displayAlertMessagae(userMessage: "All Fields are mandatory.")
            return
        }
        
        thankVW.isHidden = false
        btnFull.isHidden = false
        
    }
    
    
    @IBAction func cnclPopUPcrosbtn(sender: AnyObject) {
        
        thankVW.isHidden = true
        btnFull.isHidden = true
        
    }
    
    
    @IBAction func clickPopupOkbtn(sender: AnyObject){
        
        doPostHelpSupporttApi()
        
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
    
    
    @IBAction func clicktoFeedbaclList(sender: AnyObject)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WTHelpListViewController") as! WTHelpListViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    @IBAction func clicktoback(sender: AnyObject)
    {
    
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clicktoGmail(sender: AnyObject){
        
        if MFMailComposeViewController.canSendMail() {
            print("clickToMail")
            let emailTitle = "Welcome to Video Tap Interactive Videos!"
            let messageBody = "Download this interactive app url"
            let toRecipents = [""]
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(emailTitle)
            mc.setMessageBody(messageBody, isHTML: false)
            mc.setToRecipients(toRecipents)
            (AppDelegateInstance.rootNavigationController.topViewController)!.present(mc, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clicktoPhoneNymber(sender: AnyObject){
        
        UIApplication.shared.openURL(NSURL(string: "tel://9643296520")! as URL)
        
    }
    
    @IBAction func clicktowhatsApp(sender: AnyObject){
        var str = "Hello to whatsapp"
        str = str.addingPercentEncoding(withAllowedCharacters: (NSCharacterSet.urlQueryAllowed))!
        let whatsappURL = NSURL(string: "whatsapp://send?text=\(str)")
        
        if UIApplication.shared.canOpenURL(whatsappURL! as URL) {
            UIApplication.shared.openURL(whatsappURL! as URL)
        } else {
           // showAlert(message: "Whatsapp is not installed on this device. Please install Whatsapp and try again.")
        }
    
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


extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.characters.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.characters.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}
