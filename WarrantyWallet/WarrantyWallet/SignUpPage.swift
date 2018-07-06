//
//  SignUpPage.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 04/10/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit


class SignUpPage: UIViewController,UITextFieldDelegate,MRCountryPickerDelegate {

    /*IPHone Design***********/
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var textfieldPhoneNum: UITextField!
    @IBOutlet weak var textfieldCountryCd: UITextField!
    @IBOutlet weak var countryPicker: MRCountryPicker!
    @IBOutlet weak var countryFlag: UIImageView!
    var topview:TopViewController!
    var maivc = UIViewController()
    var dict = String()
    @IBOutlet weak var btnLoginHere: UIButton!
    
    @IBOutlet weak var vwBG: UIView!
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var vwMobNM: UIView!
    
    @IBOutlet weak var btnSignUp: UIButton!
   
    var gradientLayer: CAGradientLayer!
    
    @IBOutlet weak var gradientBG: UIView!
    
    
    @IBOutlet weak var redEmailImg: UIImageView!
    @IBOutlet weak var redCircle: UIImageView!
    
    @IBOutlet weak var redpassword: UIImageView!
    @IBOutlet weak var redCirclePass: UIImageView!
    
    @IBOutlet weak var redCirclePhone: UIImageView!

    @IBOutlet weak var btnFull: UIButton!
    @IBOutlet weak var thankVW: UIView!
    @IBOutlet weak var cnclPOP : UIButton!
    
     var AlertstrMsg = String()
    
     @IBOutlet weak var lblOppsMsg : UILabel!
    
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        
        self.textfieldCountryCd.text = phoneCode
        //self.countryFlag.image = flag
        
    }

      override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
        //createGradientLayer()

        let window = UIApplication.shared.keyWindow!
        
        textfieldEmail.delegate = self
        textfieldPassword.delegate = self
        textfieldPhoneNum.delegate = self
        textfieldCountryCd.delegate = self
        textfieldPhoneNum.keyboardType = .numberPad
        textfieldPassword.isSecureTextEntry = true
        
        //maivc.view .addSubview(countryPicker)
        
        countryPicker.isHidden = true
       //window.addSubview(countryPicker)
        self.view .addSubview(countryPicker)
        
       // addTopView()
    
        vwEmail.layer.cornerRadius = 10
        vwPassword.layer.cornerRadius = 10
        vwMobNM.layer.cornerRadius = 10
        btnSignUp.layer.cornerRadius = 18
    
    }
    
    @IBAction func cnclPopUPcrosbtn(sender: AnyObject) {
        thankVW.isHidden = true
        btnFull.isHidden = true
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        let rect = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        gradientLayer.frame = rect
        gradientLayer.colors = [UIColor(red:19/255.0, green:84/255.0, blue:122/255.0, alpha: 1.0).cgColor, UIColor(red:128/255.0, green:208/255.0, blue:199/255.0, alpha: 1.0).cgColor]
        
        self.vwBG.layer.addSublayer(gradientLayer)
        //self.view.addSubview(gradientBG)
        //vwBG .addSubview(gradientBG)
    
        self.view .addSubview(vwBG)
    }
    
    func addTopView(){
        topview = TopViewController(title: "", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        topview.topBGVW.backgroundColor = UIColor (colorLiteralRed: 47/255, green: 57/255, blue: 66/255, alpha: 1.0)
        topview.leftBack.isHidden = false
        topview.btnNotifiy.isHidden = true
        
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
    }
    
    /*Touch Method*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        countryPicker.isHidden = true
    }
    
    
    /*Keyboard Dismiss Method*/
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    //Loginbutton action
    @IBAction func clickLoginHere(sender: AnyObject)
    {
     self.navigationController?.popViewController(animated: true)
    }
    
    
    /*Validation Method*/
    func isvalidatephone(PhoneValidation:String) -> Bool {
        
        let PhoneFormat = "0123456789"
        let phonePredicate = NSPredicate(format:"SELF MATCHES %@", PhoneFormat)
        return phonePredicate.evaluate(with: phonePredicate)
        
    }
    
    /*Veryfy phn Method*/
    @IBAction func gotoVerifyPhone(sender: AnyObject)
    {
        
        let userEmail = textfieldEmail.text
        let usrPassword = textfieldPassword.text
        let ussrphoneNm = textfieldPhoneNum.text
        let countryCode = textfieldCountryCd.text
        
        // Check Empty
        /*if ((userEmail?.isEmpty)! || (usrPassword?.isEmpty)! || (ussrphoneNm?.isEmpty)!) || (countryCode?.isEmpty)!
           {
            //displayAlertMessagae(userMessage: "Please Enter All Fields.")
            
            redEmailImg.isHidden = false
            redCircle.isHidden =  false
            redpassword.isHidden = false
            redCirclePass.isHidden =  false
            redCirclePhone.isHidden =  false
            
            btnFull.isHidden = false
            thankVW.isHidden = false
            
            
          return
          
        }*/

        let isvalidUserEmail = isValidEmailAddress(emailAddressString: userEmail!)
        
        if isvalidUserEmail
        {
            if (textfieldPhoneNum.text?.characters.count)! < 10
            {
               // displayAlertMessagae(userMessage: "Please fill Phone number 10  digit")
                redCirclePhone.isHidden =  false
                
                btnFull.isHidden = false
                thankVW.isHidden = false
                self.lblOppsMsg.text = "Please enter 10 digit phone number"
                
                return
            }
            
            else if (textfieldEmail.text?.characters.count)!<0
            {
                redEmailImg.isHidden =  false
                btnFull.isHidden = false
                thankVW.isHidden = false
                self.lblOppsMsg.text = "Please enter Email"
                
                return
            }
                
            else if (textfieldPassword.text?.characters.count)!<1
            {
                redEmailImg.isHidden = false
                
                btnFull.isHidden = false
                thankVW.isHidden = false
                self.lblOppsMsg.text = "Please enter password"
                return
            
            }
            
          print("yes")
            
           /* let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            self.navigationController?.pushViewController(newViewController, animated: true)*/
           
            dopostSignUPApi()
            
            return
        }
        else{
           // displayAlertMessagae(userMessage: "Please Email should be right format.")
            
            redEmailImg.isHidden = false
            btnFull.isHidden = false
            thankVW.isHidden = false
            
             if (textfieldEmail.text?.characters.count)!>1
             {
             if (textfieldEmail.text?.isValidEmail())!
             {
             
             }else
             {
             btnFull.isHidden = false
             thankVW.isHidden = false
             self.lblOppsMsg.text = "Please enter valid email id"
             }
                
             return
             }
            
             else {}
           // self.lblOppsMsg.text = "Please enter valid email id"
        
        }
        
    }
    
    //Signup Api here.
    func dopostSignUPApi()
    {
    
        guard let name = textfieldEmail.text, !name.isEmpty,
            let pass = textfieldPassword.text, !pass.isEmpty,
            let phonenum = textfieldPhoneNum.text, !phonenum.isEmpty,
            let countrycode = textfieldCountryCd.text, !countrycode.isEmpty else { return }
        
        let request = NSMutableURLRequest(url: NSURL(string: POST_SIGNUP_API)! as URL)
        request.httpMethod = "POST"
        
        request.setValue(ServerAuthorization, forHTTPHeaderField: "authorization_token")
        request.setValue(ServerAccessTknCheck, forHTTPHeaderField: "access_token")
        
        let postString = "username=\(name)&password=\(pass)&countryCode=\(countrycode)&mobile=\(phonenum)"
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
                        
                        var mainArr = NSArray()
                        mainArr = (dictFromJSON["data"] as? NSArray)!
                        
                        print(mainArr)
                        let SessionToken = (mainArr[0] as? NSDictionary)!
                        print(SessionToken)
                        
                        //let userId = mainArr.value(forKey: "user_id") as AnyObject
                        var userId  = String()
                        userId = SessionToken.value(forKey: "user_id") as! String
                        
                        print("userId",userId)
                        
                        let defaultsUser = UserDefaults.standard
                        defaultsUser.set(userId, forKey: "user_id")
                        print("userdefault",defaultsUser.set(userId, forKey: "user_id"))
                        defaultsUser.synchronize()
                        
                        var strToken = String()
                        strToken = SessionToken.value(forKey: "session_token") as! String
                        print(strToken)
                        
                        let UserToken = UserDefaults.standard
                        UserToken.set(strToken, forKey: "UserToken")
                        UserToken.synchronize()
                        print(UserToken)
                        
                        DispatchQueue.main.async {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ScanInvoiceViewController") as! ScanInvoiceViewController
                            self.navigationController?.pushViewController(newViewController, animated: true)
                           // self.btnFull.isHidden = false
                            //self.thankVW.isHidden = false
                            //self.lblOppsMsg.text = self.AlertstrMsg
                        
                        }
                    }
                    
                    else {
                        
                        print ("status 0")
                        DispatchQueue.main.async {
                        self.btnFull.isHidden = false
                        self.thankVW.isHidden = false
                        self.lblOppsMsg.text = self.AlertstrMsg
                        
                        }
                    }
            
                }
                
            }catch
            {
                print("error")
                self.displayAlertMessagae(userMessage: "Please enter all details")
            }
            
        }
        
        task.resume()
        
    }

    
    /*Generic Alert Method*/
    func displayAlertMessagae(userMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Validationcode here...
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    
    //Textfield Delegate and Datasource method here..
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
        switch textField {
        case textfieldCountryCd:
        
        countryPicker.isHidden = false
        countryPicker.countryPickerDelegate = self
        countryPicker.showPhoneNumbers = true
        countryPicker.setCountry("IN")
        //countryPicker.setLocale("sl_SI")
        countryPicker.setCountryByName("india")
        
        default:
            print("Something went wrong")
        }

        
      return true
    
    }
    
    /*Text field delegate and data source Method*/
func textFieldDidBeginEditing(_ textField: UITextField) {
    switch textField {
    case textfieldEmail:
        textfieldEmail.text = ""
    case textfieldPassword:
        textfieldPassword.text = ""
    case textfieldPhoneNum:
        textfieldPhoneNum.text = ""
    case textfieldCountryCd:
        self.view.endEditing(true)
        countryPicker.isHidden = false

    default:
        print("Something went wrong")
    }
}

func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
   
    let usrPassword = textfieldPassword.text!
    let usrPhNom = textfieldPhoneNum.text!
    
    
    if (textField.text == usrPassword)
    {
        guard let text = textField.text else { return true }
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= 15 // Bool
    
    }
        
    else if (textField.text == usrPhNom)
    {
        guard let text = textField.text else { return true }
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= 10 // Bool
    }
    
    else {
        print("no")
    
    }
    
    return true
    
}

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
    }
    
}
extension String {
    
    func isValidEmail() -> Bool {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

/*
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count)) != nil
    }
}*/
